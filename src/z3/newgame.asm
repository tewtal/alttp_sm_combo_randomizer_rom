; When starting a new game, run this code
;
; Only copies the "new file" SRAM into the ALTTP SRAM slot right now (only file 1 works)

org $5e0000
alttp_new_game:
    pha
    phx
    phy
    php
    %ai16()

    ldx #$0000
-
    lda.l alttp_sram,x
    sta.l $a06000,x
    inx
    inx
    cpx #$2000
    bne -

    ; Load starting equipment, pre-open stuff
    LDA.l !SRAM_ALTTP_FRESH_FILE : BNE +
        %ai8()
        JSL.l OnNewFile
        LDA.b #$FF : STA.l !SRAM_ALTTP_FRESH_FILE
    +

    %ai16()
    jsl zelda_fix_checksum
    
    plp
    ply
    plx
    pla
    rtl

alttp_sram:
    incbin "../data/zelda-sram.bin"