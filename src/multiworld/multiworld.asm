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
    sta.l !SRAM_MW_ITEMS_RECV+$0400, x
    sta.l !SRAM_MW_ITEMS_RECV+$0800, x
    sta.l !SRAM_MW_ITEMS_RECV+$0C00, x
    inx : inx
    cpx #$0400
    bne -

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