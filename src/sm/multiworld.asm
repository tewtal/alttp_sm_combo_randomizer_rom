; SM Multiworld support
;

org $C28BB3
    jsl sm_mw_hook_main_game

org $f83000

sm_mw_nmi_read_messages:
    rep #$30
    lda.l !MESSAGEBASE+$18E
    bne +
    jsl read_messages
+
    inc $05b8
    rtl

; Display message that we picked up someone elses item
; X = item id, Y = player id
sm_mw_display_item_sent:
    stx $c1
    sty $c3
    ;lda #$0168       ; With fanfare skip, no need to queue room track
    ;jsl $82e118      ; Queue room track after item fanfare
    lda #$005c
    jsl $858080
    rtl

sm_mw_receive_item:
    pha : phx
    cmp #$00b0                  ; If below B0 it's an alttp item
    bcc .alttpItem
    sec
    sbc #$00b0
    asl #4 : tax
    lda.l sm_item_table+$2, x     ; Read item flag
    sta $cc
    lda #$005d
    sta $ce
    lda.l #sm_item_table
    sta $ca
    txa : clc : adc $ca : tax
    ldy #$00cc
    jsl sm_mw_call_receive           ; Call original item receive code (reading the item to get from $cc-ce)
    plx : pla
    rts

.alttpItem
    lda #$0001
    sta.l !SM_MULTIWORLD_PICKUP
    jsl alttp_item_pickup
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

