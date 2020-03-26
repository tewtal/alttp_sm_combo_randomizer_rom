org $c2ecbb
base $82ecbb
    jsr seed_display

org $c2f800
base $82f800
seed_display:
    pha
    phx
    php
    rep #$30

    lda.l $420000
    and #$007f
    asl
    asl
    asl
    tay
    ldx #$0000
-
    lda WordTable, y
    and #$00ff
    asl
    phx
    tax
    lda CharTable, x
    plx
    sta $7fc052, x
    inx
    inx
    iny
    cpx #$000E
    bne -

    lda.l $420001
    and #$007f
    asl
    asl
    asl
    tay
    ldx #$0000
-
    lda WordTable, y
    and #$00ff
    asl
    phx
    tax
    lda CharTable, x
    plx
    sta $7fc060, x
    inx
    inx
    iny
    cpx #$000E
    bne -

    lda.l $420002
    and #$007f
    asl
    asl
    asl
    tay
    ldx #$0000
-
    lda WordTable, y
    and #$00ff
    asl
    phx
    tax
    lda CharTable, x
    plx
    sta $7fc092, x
    inx
    inx
    iny
    cpx #$000E
    bne -

    lda.l $420003
    and #$007f
    asl
    asl
    asl
    tay
    ldx #$0000
-
    lda WordTable, y
    and #$00ff
    asl
    phx
    tax
    lda CharTable, x
    plx
    sta $7fc0a0, x
    inx
    inx
    iny
    cpx #$000E
    bne -

    plp
    plx
    pla
    ldx #$07fe
    rts

CharTable:
    ; 0x00                                                                                       0x0F
    dw $000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f
    ; 0x10                                                                                       0x0F
    dw $000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f,$000f
    ; 0x20                                                                                       0x0F
    dw $000f,$0084,$002d,$000f,$000f,$000f,$000f,$0022,$008a,$008b,$000f,$0086,$0089,$0087,$0088,$000f
NumTable:
    ; 0x30                                                                                       0x0F
    dw $0060,$0061,$0062,$0063,$0064,$0065,$0066,$0067,$0068,$0069,$000f,$000f,$000f,$000f,$000f,$0085
    ; 0x40                                                                                       0x0F
    dw $000f,$006a,$006b,$006c,$006d,$006e,$006f,$0070,$0071,$0072,$0073,$0074,$0075,$0076,$0077,$0078
    ; 0x50                                                                                       0x0F
    dw $0079,$007a,$007b,$007c,$007d,$007e,$007f,$0080,$0081,$0082,$0083,$000f,$000f,$000f,$000f,$000f

WordTable:
    db "GEEMER  "   ; $00
    db "RIPPER  "
    db "ATOMIC  "
    db "POWAMP  "
    db "SCISER  "
    db "NAMIHE  "
    db "PUROMI  "
    db "ALCOON  "
    db "BEETOM  "   ; $08
    db "OWTCH   "
    db "ZEBBO   "
    db "ZEELA   "
    db "HOLTZ   "
    db "VIOLA   "
    db "WAVER   "
    db "RINKA   "
    db "BOYON   "   ; $10
    db "CHOOT   "
    db "KAGO    "
    db "SKREE   "
    db "COVERN  "
    db "EVIR    "
    db "TATORI  "
    db "OUM     "
    db "PUYO    "   ; $18
    db "YARD    "
    db "ZOA     "
    db "FUNE    "
    db "GAMET   "
    db "GERUTA  "
    db "SOVA    "
    db "BULL    "
    db "ARRGI   "   ; $20
    db "BABUSU  "
    db "BORU    "
    db "HACHI   "
    db "BABURU  "
    db "TAINON  "
    db "GERUDO  "
    db "GIBO    "
    db "KOPPI   "   ; $28
    db "PON     "
    db "HOBA    "
    db "HYU     "
    db "KISU    "
    db "KYUNE   "
    db "RIBA    "
    db "MEDUSA  "
    db "TERU    "   ; $30
    db "FANGIN  "
    db "PIKKU   "
    db "POPO    "
    db "NOMOSU  "
    db "GUZU    "
    db "AIGORU  "
    db "ROPA    "
    db "GAPURA  "   ; $38
    db "HEISHI  "
    db "SUTARU  "
    db "TOZOKU  "
    db "TOPPO   "
    db "WAINDA  "
    db "KURIPI  "
    db "ZORA    "
    db "SPAZER  "   ; $40 - START OF LENO ADDITIONS, these are generics that are across almost all games of both universes -
    db "PLASMA  "
    db "CHOZO   "
    db "TORIZO  "
    db "GOHMA   "
    db "DAMPE   "
    db "POE     "
    db "GANON   "
    db "PEAHAT  "   ; $48
    db "RIDLEY  "
    db "KRAID   "
    db "SR388   "   ; - Metroid II/Samus Returns, Zero Mission, and Fusion enemies, characters, and bosses
    db "GUNZOO  "
    db "SHIRK   "
    db "MUMBO   "
    db "SKORP   "
    db "DRIVEL  "   ; $50
    db "SERRIS  "
    db "GERON   "
    db "FUSION  "
    db "MAJORA  "   ; - Ocarina of Time/Majora's Mask enemies, characters, and bosses
    db "GORON   "
    db "ODOLWA  "
    db "GOHT    "
    db "GYORG   "   ; $58
    db "MORPHA  "
    db "ONOX    "   ; - Link's Awakening, Oracles of Seasons/Ages enemies, characters, and bosses  - 90
    db "VERAN   "
    db "HINOX   "
    db "ROVER   "
    db "OMUAI   "
    db "SYGER   "
    db "SMOG    "   ; $60
    db "MINISH  "   ; - Minish Cap enemies, characters, and bosses
    db "PICORI  "
    db "MAZURA  "   ; - Zelda 2: Adventure of Link enemies, characters, and bosses
    db "CAROCK  "
    db "BARBA   "
    db "GOOMA   "
    db "ERROR   "
    db "DAIRA   "   ; $68
    db "DEELER  "
    db "BOON    "
    db "PHAZON  "   ; - Metroid Prime Trilogy enemies, characters, and bosses
    db "REZBIT  "
    db "CHYKKA  "
    db "AGON    "
    db "PRIME   "
    db "ING     "   ; $70
    db "TALLON  "
    db "EYON    "
    db "JELZAP  "
    db "OCULUS  "
    db "BLOGG   "
    db "KRALEE  "
    db "QUAD    "
    db "SPORB   "   ; $78
    db "BRYYO   "
    db "GELBUG  "
    db "RUNDAS  "
    db "KORBA   "
    db "PHAAZE  "
    db "ELYSIA  "
    db "NORION  "   ; $7F
