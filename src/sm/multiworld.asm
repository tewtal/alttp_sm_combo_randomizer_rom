; SM Multiworld support
;

org $f83000

; Display message that we picked up someone elses item
; X = item id, Y = player id
sm_mw_display_item_sent:
    stx $c1
    sty $c3
    ;lda #$0168       ; With fanfare skip, no need to queue room track
    ;jsl $82e118      ; Queue room track after item fanfare
    lda #$001d
    jsl $858080
    rtl

sm_mw_receive_item:
    pha : phx
    asl #4 : tax
    lda.l sm_item_table+$2, x     ; Read item flag
    sta $cc
    lda #$001e
    sta $ce
    lda.l #sm_item_table
    sta $ca
    txa : clc : adc $ca : tax
    ldy #$00cc
    jsl sm_mw_call_receive           ; Call original item receive code (reading the item to get from $cc-ce)
    plx : pla
    rts

sm_mw_handle_queue:
    pha : phx

.loop
    lda.l !SRAM_MW_RPTR
    cmp.l !SRAM_MW_WPTR
    beq .end
    
    asl #2 : tax
    lda.l !SRAM_MW_RECVQ, x : sta $c3
    lda.l !SRAM_MW_RECVQ+$2, x : sta $c1
    jsr sm_mw_receive_item

    lda.l !SRAM_MW_RPTR
    inc a
    cmp #$0010
    bne +
    lda.l #$0000
+
    sta.l !SRAM_MW_RPTR
    bra .loop    

.end
    plx : pla
    rts

sm_mw_hook_main_game:
    jsl $A09169     ; Last routine of game mode 8 (main gameplay)
    lda $0998
    cmp #$0008
    bne +
    jsr sm_mw_handle_queue     ; Handle MW RECVQ only in gamemode 8 
+
    rtl

