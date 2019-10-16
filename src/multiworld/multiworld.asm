org $f80000
incsrc "randolive.asm"

mw_init:
    pha : phx : phy : php
    %ai16()

    ; If already initialized, don't do it again
    lda.l !SRAM_MW_INITIALIZED
    cmp #$cafe
    beq .end

    lda #$0000
    ldx #$0000

-
    sta.l !SRAM_MW_ITEMS_RECV, x
    sta.l !SRAM_MW_ITEMS_SENT, x
    inx : inx
    cpx #$0600
    bne -

    sta.l !SRAM_MW_ITEMS_RECV_RPTR
    sta.l !SRAM_MW_ITEMS_RECV_WPTR
    
    sta.l !SRAM_MW_ITEMS_SENT_RPTR
    sta.l !SRAM_MW_ITEMS_SENT_WPTR

    lda #$cafe
    sta.l !SRAM_MW_INITIALIZED
    
.end
    plp : ply : plx : pla
    rtl 

; Write multiworld item message
; A = item index, X = item id, Y = world id (all 16-bit)
mw_write_message:
    pha : phx
    lda.l !SRAM_MW_ITEMS_SENT_WPTR
    asl #3 : tax
    tya
    sta.l !SRAM_MW_ITEMS_SENT, x
    pla
    sta.l !SRAM_MW_ITEMS_SENT+$2, x
    pla
    sta.l !SRAM_MW_ITEMS_SENT+$4, x

    lda.l !SRAM_MW_ITEMS_SENT_WPTR
    inc a
    sta.l !SRAM_MW_ITEMS_SENT_WPTR
    rtl

; Add received item to pickup queue (only do item pickups in game mode 8)
; mw_queue_receive:
;     pha : phx
;     lda.l !MESSAGES_IN+$2, x      ; Read player id
;     pha
;     lda.l !MESSAGES_IN+$4, x      ; Read item id
;     pha
;     lda.l !SRAM_MW_WPTR
;     asl #2
;     tax
;     pla
;     sta.l !SRAM_MW_RECVQ+$2, x         ; Store item id
;     pla
;     sta.l !SRAM_MW_RECVQ, x            ; Store player id
;     lda.l !SRAM_MW_WPTR
;     inc a
;     cmp #$0010
;     bne +
;     lda #$0000
; +
;     sta.l !SRAM_MW_WPTR
;     plx : pla
;     rtl

mw_save_sram:
    pha : php
    %ai16()
    lda.l !SRAM_MW_ITEMS_RECV_RPTR
    sta.l !SRAM_MW_ITEMS_RECV_SPTR
    plp : pla
    rtl

mw_load_sram:
    pha : php
    %ai16()
    lda.l !SRAM_MW_ITEMS_RECV_SPTR
    sta.l !SRAM_MW_ITEMS_RECV_RPTR
    plp : pla
    rtl

; Multiworld data
org $c0ff50
    incsrc seeddata.asm
org $f85000
    incsrc playertable.asm
org $f86000
    incsrc itemtable.asm