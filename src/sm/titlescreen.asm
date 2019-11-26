; Spritemap format is roughly:
;     nnnn         ; Number of entries (2 bytes)
;     xxxx yy attt ; Entry 0 (5 bytes)
;     ...          ; Entry 1...
; Where:
;     n = number of entries
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     a = attributes
;     t = tile number

; More specifically, a spritemap entry is:
;     s000000xxxxxxxxx yyyyyyyy YXpp000ttttttttt
; Where:
;     s = size bit
;     x = X offset of sprite from centre
;     y = Y offset of sprite from centre
;     Y = Y flip
;     X = X flip
;     p = priority (relative to background)
;     t = tile number

; NB Must be located in bank $CC
org $CCFA00
titlescreen_map:
    incbin "../data/titlescreen-map.bin"

org $CBA0C7
    dw titlescreen_map

org $CBA0CD
    dw titlescreen_map

org $CB9C5F
    JSL titlescreen_upload_gfx
    NOP

; Offset 0x00D000, free space in SM
org $C0D000
titlescreen_gfx:
    incbin "../data/titlescreen-gfx.bin"
titlescreen_end:

macro gfx_upload_loop(end, target)
?loop:
    CPX <end> : BEQ ?done
    DEX : DEX
    LDA.L titlescreen_gfx,X
    STA.L <target>,X
    BRA ?loop
?done:
endmacro

titlescreen_upload_gfx:
    PHP : REP #$30
        LDX.W #$16C0 ; LDX #titlescreen_end-titlescreen_gfx
        %gfx_upload_loop(#$15E0, $7F7020)
        %gfx_upload_loop(#$1500, $7F6F00)
        %gfx_upload_loop(#$1420, $7F6DE0)
        %gfx_upload_loop(#$1340, $7F6CC0)
        %gfx_upload_loop(#$1280, $7F6B80)
        %gfx_upload_loop(#$0BE0, $7F6A40)
        %gfx_upload_loop(#$0A00, $7F6A20)
        %gfx_upload_loop(#$0840, $7F6A00)
        %gfx_upload_loop(#$0680, $7F69C0)
        %gfx_upload_loop(#$0200, $7F6980)
        %gfx_upload_loop(#$0180, $7F6800)
        %gfx_upload_loop(#$0100, $7F6680)
        %gfx_upload_loop(#$0080, $7F6500)
        %gfx_upload_loop(#$0040, $7F6380)
        .loop
            DEX : BMI .done : DEX
            LDA.L titlescreen_gfx,X
            STA.L $7F61C0,X
            BRA .loop
        .done
    PLP
    LDA #$02 : STA $420B  ; start DMA transfer, the code we wrote over
    RTL
