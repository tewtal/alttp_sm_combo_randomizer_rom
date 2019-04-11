org $f80000
incsrc "randolive.asm"

mw_init:
    pha : phx : phy : php
    %ai16()
    lda #$0000
    ldx #$0000

-    
    sta.l !SRAM_MW_RECVQ, x
    inx : inx
    cpx #$0040
    bne -

    sta.l !SRAM_MW_WPTR
    sta.l !SRAM_MW_RPTR

    plp : ply : plx : pla
    rtl 

; Add received item to pickup queue (only do item pickups in game mode 8)
mw_queue_receive:
    pha : phx
    lda.l !MESSAGES_IN+$2, x      ; Read player id
    pha
    lda.l !MESSAGES_IN+$4, x      ; Read item id
    pha
    lda.l !SRAM_MW_WPTR
    asl #2
    tax
    pla
    sta.l !SRAM_MW_RECVQ+$2, x         ; Store item id
    pla
    sta.l !SRAM_MW_RECVQ, x            ; Store player id
    lda.l !SRAM_MW_WPTR
    inc a
    cmp #$0010
    bne +
    lda #$0000
+
    sta.l !SRAM_MW_WPTR
    plx : pla
    rtl

; Multiworld data
org $c0ff50
    incsrc seeddata.asm
org $f85000
    incsrc playertable.asm
org $f86000
    incsrc itemtable.asm