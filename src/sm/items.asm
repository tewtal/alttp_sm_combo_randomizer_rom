; Add ALTTP items to SM
;
; Extra message box code lifted from MessageBoxV4 by Kejardon, JAM

!IBranchItem = #$887C
!ISetItem = #$8899
!ILoadSpecialGraphics = #$8764
!ISetGoto = #$8A24
!ISetPreInstructionCode = #$86C1
!IDrawCustom1 = #$E04F
!IDrawCustom2 = #$E067
!IGoto = #$8724
!IKill = #$86BC
!IPlayTrackNow = #$8BDD
!IJSR = #$8A2E
!ISetCounter8 = #$874E
!IGotoDecrement = #$873F
!IAlttpPickup = #i_pickup
!IAlttpVisibleItem = #i_visible_item
!IAlttpChozoItem = #i_chozo_item
!IAlttpHiddenItem = #i_hidden_item
!IProgressiveItem = #i_progressive_item

!Big = #$825A
!Small = #$8289
!EmptySmall = #$8436
!Shot = #$83C5
!Dash = #$83CC
!Jump = #$8756
!ItemCancel = #$875D
!ItemSelect = #$8764
!AimDown = #$876B
!AimUp = #$8773
!EmptyBig = #$877A

;org $01E9BC
;    db $c0

;org $cf8432
;    dw $f08c    ; Replace terminator e-tank with shovel

;org $cf86de
;    dw $efe4    ; Morph to progressive sword

org $c98000      ; New item graphics
base $898000
    incbin "data/newitems.bin"

org $c4efe0     ; First free space in PLM block
base $84efe0

plm_items:
    dw $ee64, v_bow             ; efe0
    dw $ee64, v_silver_arrows   ; efe4
    dw $ee64, v_blue_boomerang  ; efe8
    dw $ee64, v_red_boomerang   ; efec
    dw $ee64, v_hookshot        ; eff0
    dw $ee64, v_bomb_1          ; eff4
    dw $ee64, v_mushroom        ; eff8
    dw $ee64, v_powder          ; effc
    dw $ee64, v_fire_rod        ; f000
    dw $ee64, v_ice_rod         ; f004
    dw $ee64, v_bombos          ; f008
    dw $ee64, v_ether           ; f00c
    dw $ee64, v_quake           ; f010
    dw $ee64, v_lamp            ; f014
    dw $ee64, v_hammer          ; f018
    dw $ee64, v_shovel          ; f01c
    dw $ee64, v_flute           ; f020
    dw $ee64, v_net             ; f024
    dw $ee64, v_book            ; f028
    dw $ee64, v_bottle_empty    ; f02c
    dw $ee64, v_bottle_red      ; f030
    dw $ee64, v_bottle_green    ; f034
    dw $ee64, v_bottle_blue     ; f038
    dw $ee64, v_bottle_bee      ; f03c
    dw $ee64, v_bottle_good_bee ; f040
    dw $ee64, v_bottle_fairy    ; f044
    dw $ee64, v_somaria         ; f048
    dw $ee64, v_byrna           ; f04c
    dw $ee64, v_cape            ; f050
    dw $ee64, v_mirror          ; f054
    dw $ee64, v_glove           ; f058
    dw $ee64, v_mitt            ; f05c
    dw $ee64, v_boots           ; f060
    dw $ee64, v_flippers        ; f064
    dw $ee64, v_pearl           ; f068
    dw $ee64, v_sword_master    ; f06c
    dw $ee64, v_sword_tempered  ; f070
    dw $ee64, v_sword_gold      ; f074
    dw $ee64, v_tunic_blue      ; f078
    dw $ee64, v_tunic_red       ; f07c
    dw $ee64, v_shield_blue     ; f080
    dw $ee64, v_shield_red      ; f084
    dw $ee64, v_shield_mirror   ; f088
    dw $ee64, v_heart_piece     ; f08c
    dw $ee64, v_heart_container ; f090
    dw $ee64, v_arrow_1         ; f094
    dw $ee64, v_arrow_5         ; f098
    dw $ee64, v_arrow_10        ; f09c
    dw $ee64, v_bomb_3          ; f0a0
    dw $ee64, v_bomb_10         ; f0a4
    dw $ee64, v_rupee_1         ; f0a8
    dw $ee64, v_rupee_5         ; f0ac
    dw $ee64, v_rupee_20        ; f0b0
    dw $ee64, v_rupee_50        ; f0b4
    dw $ee64, v_rupee_100       ; f0b8
    dw $ee64, v_rupee_300       ; f0bc
    dw $ee64, v_magic_half      ; f0c0
    dw $ee64, v_magic_quarter   ; f0c4


    dw $ee64, c_bow             ; efe0 + $e8
    dw $ee64, c_silver_arrows   ; efe4
    dw $ee64, c_blue_boomerang  ; efe8
    dw $ee64, c_red_boomerang   ; efec
    dw $ee64, c_hookshot        ; eff0
    dw $ee64, c_bomb_1          ; eff4
    dw $ee64, c_mushroom        ; eff8
    dw $ee64, c_powder          ; effc
    dw $ee64, c_fire_rod        ; f000
    dw $ee64, c_ice_rod         ; f004
    dw $ee64, c_bombos          ; f008
    dw $ee64, c_ether           ; f00c
    dw $ee64, c_quake           ; f010
    dw $ee64, c_lamp            ; f014
    dw $ee64, c_hammer          ; f018
    dw $ee64, c_shovel          ; f01c
    dw $ee64, c_flute           ; f020
    dw $ee64, c_net             ; f024
    dw $ee64, c_book            ; f028
    dw $ee64, c_bottle_empty    ; f02c
    dw $ee64, c_bottle_red      ; f030
    dw $ee64, c_bottle_green    ; f034
    dw $ee64, c_bottle_blue     ; f038
    dw $ee64, c_bottle_bee      ; f03c
    dw $ee64, c_bottle_good_bee ; f040
    dw $ee64, c_bottle_fairy    ; f044
    dw $ee64, c_somaria         ; f048
    dw $ee64, c_byrna           ; f04c
    dw $ee64, c_cape            ; f050
    dw $ee64, c_mirror          ; f054
    dw $ee64, c_glove           ; f058
    dw $ee64, c_mitt            ; f05c
    dw $ee64, c_boots           ; f060
    dw $ee64, c_flippers        ; f064
    dw $ee64, c_pearl           ; f068
    dw $ee64, c_sword_master    ; f06c
    dw $ee64, c_sword_tempered  ; f070
    dw $ee64, c_sword_gold      ; f074
    dw $ee64, c_tunic_blue      ; f078
    dw $ee64, c_tunic_red       ; f07c
    dw $ee64, c_shield_blue     ; f080
    dw $ee64, c_shield_red      ; f084
    dw $ee64, c_shield_mirror   ; f088
    dw $ee64, c_heart_piece     ; f08c
    dw $ee64, c_heart_container ; f090
    dw $ee64, c_arrow_1         ; f094
    dw $ee64, c_arrow_5         ; f098
    dw $ee64, c_arrow_10        ; f09c
    dw $ee64, c_bomb_3          ; f0a0
    dw $ee64, c_bomb_10         ; f0a4
    dw $ee64, c_rupee_1         ; f0a8
    dw $ee64, c_rupee_5         ; f0ac
    dw $ee64, c_rupee_20        ; f0b0
    dw $ee64, c_rupee_50        ; f0b4
    dw $ee64, c_rupee_100       ; f0b8
    dw $ee64, c_rupee_300       ; f0bc
    dw $ee64, c_magic_half      ; f0c0
    dw $ee64, c_magic_quarter   ; f0c4


    dw $ee8e, h_bow             ; efe0 + $1d0
    dw $ee8e, h_silver_arrows   ; efe4
    dw $ee8e, h_blue_boomerang  ; efe8
    dw $ee8e, h_red_boomerang   ; efec
    dw $ee8e, h_hookshot        ; eff0
    dw $ee8e, h_bomb_1          ; eff4
    dw $ee8e, h_mushroom        ; eff8
    dw $ee8e, h_powder          ; effc
    dw $ee8e, h_fire_rod        ; f000
    dw $ee8e, h_ice_rod         ; f004
    dw $ee8e, h_bombos          ; f008
    dw $ee8e, h_ether           ; f00c
    dw $ee8e, h_quake           ; f010
    dw $ee8e, h_lamp            ; f014
    dw $ee8e, h_hammer          ; f018
    dw $ee8e, h_shovel          ; f01c
    dw $ee8e, h_flute           ; f020
    dw $ee8e, h_net             ; f024
    dw $ee8e, h_book            ; f028
    dw $ee8e, h_bottle_empty    ; f02c
    dw $ee8e, h_bottle_red      ; f030
    dw $ee8e, h_bottle_green    ; f034
    dw $ee8e, h_bottle_blue     ; f038
    dw $ee8e, h_bottle_bee      ; f03c
    dw $ee8e, h_bottle_good_bee ; f040
    dw $ee8e, h_bottle_fairy    ; f044
    dw $ee8e, h_somaria         ; f048
    dw $ee8e, h_byrna           ; f04c
    dw $ee8e, h_cape            ; f050
    dw $ee8e, h_mirror          ; f054
    dw $ee8e, h_glove           ; f058
    dw $ee8e, h_mitt            ; f05c
    dw $ee8e, h_boots           ; f060
    dw $ee8e, h_flippers        ; f064
    dw $ee8e, h_pearl           ; f068
    dw $ee8e, h_sword_master    ; f06c
    dw $ee8e, h_sword_tempered  ; f070
    dw $ee8e, h_sword_gold      ; f074
    dw $ee8e, h_tunic_blue      ; f078
    dw $ee8e, h_tunic_red       ; f07c
    dw $ee8e, h_shield_blue     ; f080
    dw $ee8e, h_shield_red      ; f084
    dw $ee8e, h_shield_mirror   ; f088
    dw $ee8e, h_heart_piece     ; f08c
    dw $ee8e, h_heart_container ; f090
    dw $ee8e, h_arrow_1         ; f094
    dw $ee8e, h_arrow_5         ; f098
    dw $ee8e, h_arrow_10        ; f09c
    dw $ee8e, h_bomb_3          ; f0a0
    dw $ee8e, h_bomb_10         ; f0a4
    dw $ee8e, h_rupee_1         ; f0a8
    dw $ee8e, h_rupee_5         ; f0ac
    dw $ee8e, h_rupee_20        ; f0b0
    dw $ee8e, h_rupee_50        ; f0b4
    dw $ee8e, h_rupee_100       ; f0b8
    dw $ee8e, h_rupee_300       ; f0bc
    dw $ee8e, h_magic_half      ; f0c0
    dw $ee8e, h_magic_quarter   ; f0c4

    dw $ee64, v_progressive_armor    ; f298
    dw $ee64, c_progressive_armor    ; f29c
    dw $ee8e, h_progressive_armor    ; f2a0

    dw $ee64, v_progressive_gloves   ; f2a4
    dw $ee64, c_progressive_gloves   ; f2a8
    dw $ee8e, h_progressive_gloves   ; f2ac

    dw $ee64, v_progressive_shields  ; f2b0
    dw $ee64, c_progressive_shields  ; f2b4
    dw $ee8e, h_progressive_shields  ; f2b8

    dw $ee64, v_progressive_swords   ; f2bc
    dw $ee64, c_progressive_swords   ; f2c0
    dw $ee8e, h_progressive_swords   ; f2c4

    dw $ee64, v_bomb_upgrade_5       ; f2c8
    dw $ee64, c_bomb_upgrade_5       ; f2cc
    dw $ee8e, h_bomb_upgrade_5       ; f2d0

    dw $ee64, v_bomb_upgrade_10      ; f2d4
    dw $ee64, c_bomb_upgrade_10      ; f2d8
    dw $ee8e, h_bomb_upgrade_10      ; f2dc

    dw $ee64, v_arrow_upgrade_5      ; f2e0
    dw $ee64, c_arrow_upgrade_5      ; f2e4
    dw $ee8e, h_arrow_upgrade_5      ; f2e8

    dw $ee64, v_arrow_upgrade_10     ; f2ec
    dw $ee64, c_arrow_upgrade_10     ; f2f0
    dw $ee8e, h_arrow_upgrade_10     ; f2f4

    dw $ee64, v_sword_fighter        ; f2f8
    dw $ee64, c_sword_fighter        ; f2fc
    dw $ee8e, h_sword_fighter        ; f300

v_bow:
    dw !ILoadSpecialGraphics, $9200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0000

v_silver_arrows:
    dw !ILoadSpecialGraphics, $DE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0001

v_blue_boomerang:
    dw !ILoadSpecialGraphics, $DF00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0002

v_red_boomerang:
    dw !ILoadSpecialGraphics, $E000 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0003

v_hookshot:
    dw !ILoadSpecialGraphics, $9100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0004

v_bomb_1:
    dw !ILoadSpecialGraphics, $9400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0005

v_mushroom:
    dw !ILoadSpecialGraphics, $9600 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0006

v_powder:
    dw !ILoadSpecialGraphics, $9700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0007

v_fire_rod:
    dw !ILoadSpecialGraphics, $AF00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0008

v_ice_rod:
    dw !ILoadSpecialGraphics, $B000 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0009

v_bombos:
    dw !ILoadSpecialGraphics, $B100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $000A

v_ether:
    dw !ILoadSpecialGraphics, $B200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $000B

v_quake:
    dw !ILoadSpecialGraphics, $B300 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $000C

v_lamp:
    dw !ILoadSpecialGraphics, $B400 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $000D

v_hammer:
    dw !ILoadSpecialGraphics, $B500 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $000E

v_shovel:
    dw !ILoadSpecialGraphics, $B600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $000F

v_flute:
    dw !ILoadSpecialGraphics, $B700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0010

v_net:
    dw !ILoadSpecialGraphics, $B800 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0011
    
v_book:
    dw !ILoadSpecialGraphics, $B900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0012
    
v_bottle_empty:
    dw !ILoadSpecialGraphics, $BA00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0013
    
v_bottle_red:
    dw !ILoadSpecialGraphics, $BB00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0014
    
v_bottle_green:
    dw !ILoadSpecialGraphics, $BC00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0015
    
v_bottle_blue:
    dw !ILoadSpecialGraphics, $BD00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0016
    
v_bottle_bee:
    dw !ILoadSpecialGraphics, $BE00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0017
    
v_bottle_good_bee:
    dw !ILoadSpecialGraphics, $BF00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0018
    
v_bottle_fairy:
    dw !ILoadSpecialGraphics, $C000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0019
    
v_somaria:
    dw !ILoadSpecialGraphics, $C100 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $001A
    
v_byrna:
    dw !ILoadSpecialGraphics, $C200 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $001B
    
v_cape:
    dw !ILoadSpecialGraphics, $C300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $001C
    
v_mirror:
    dw !ILoadSpecialGraphics, $C400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $001D
    
v_glove:
    dw !ILoadSpecialGraphics, $C500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $001E
    
v_mitt:
    dw !ILoadSpecialGraphics, $C600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $001F
    
v_boots:
    dw !ILoadSpecialGraphics, $C700 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0020
    
v_flippers:
    dw !ILoadSpecialGraphics, $C800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0021
    
v_pearl:
    dw !ILoadSpecialGraphics, $C900 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0022
    
v_sword_master:
    dw !ILoadSpecialGraphics, $CA00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0023
    
v_sword_tempered:
    dw !ILoadSpecialGraphics, $CB00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0024
    
v_sword_gold:
    dw !ILoadSpecialGraphics, $CC00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0025
    
v_tunic_blue:
    dw !ILoadSpecialGraphics, $CD00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0026
    
v_tunic_red:
    dw !ILoadSpecialGraphics, $CE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0027
    
v_shield_blue:
    dw !ILoadSpecialGraphics, $CF00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0028
    
v_shield_red:
    dw !ILoadSpecialGraphics, $D000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $0029
    
v_shield_mirror:
    dw !ILoadSpecialGraphics, $D100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $002A
    
v_heart_piece:
    dw !ILoadSpecialGraphics, $D200 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $002B
    
v_heart_container:
    dw !ILoadSpecialGraphics, $D300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $002C
    
v_arrow_1:
    dw !ILoadSpecialGraphics, $D400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $002D
    
v_arrow_5:
    dw !ILoadSpecialGraphics, $D500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $002E
    
v_arrow_10:
    dw !ILoadSpecialGraphics, $D600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $002F
    
v_bomb_3:
    dw !ILoadSpecialGraphics, $D700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0030
    
v_bomb_10:
    dw !ILoadSpecialGraphics, $D800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0031
    
v_rupee_1:
    dw !ILoadSpecialGraphics, $D900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0032
    
v_rupee_5:
    dw !ILoadSpecialGraphics, $DA00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $0033
    
v_rupee_20:
    dw !ILoadSpecialGraphics, $DB00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpVisibleItem, $0034
    
v_rupee_50:
    dw !ILoadSpecialGraphics, $DC00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0035
    
v_rupee_100:
    dw !ILoadSpecialGraphics, $DD00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0036
    
v_rupee_300:
    dw !ILoadSpecialGraphics, $9300 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0037

v_magic_half:
    dw !ILoadSpecialGraphics, $E100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0038

v_magic_quarter:
    dw !ILoadSpecialGraphics, $E200 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpVisibleItem, $0039

v_bomb_upgrade_5:
    dw !ILoadSpecialGraphics, $E300 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $003a

v_bomb_upgrade_10:
    dw !ILoadSpecialGraphics, $E400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpVisibleItem, $003b

v_arrow_upgrade_5:
    dw !ILoadSpecialGraphics, $E500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $003c

v_arrow_upgrade_10:
    dw !ILoadSpecialGraphics, $E600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $003d

v_sword_fighter:
    dw !ILoadSpecialGraphics, $E700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpVisibleItem, $003e


c_bow:
    dw !ILoadSpecialGraphics, $9200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0000

c_silver_arrows:
    dw !ILoadSpecialGraphics, $DE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0001

c_blue_boomerang:
    dw !ILoadSpecialGraphics, $DF00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0002

c_red_boomerang:
    dw !ILoadSpecialGraphics, $E000 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0003

c_hookshot:
    dw !ILoadSpecialGraphics, $9100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0004

c_bomb_1:
    dw !ILoadSpecialGraphics, $9400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0005

c_mushroom:
    dw !ILoadSpecialGraphics, $9600 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0006

c_powder:
    dw !ILoadSpecialGraphics, $9700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0007

c_fire_rod:
    dw !ILoadSpecialGraphics, $AF00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0008

c_ice_rod:
    dw !ILoadSpecialGraphics, $B000 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0009

c_bombos:
    dw !ILoadSpecialGraphics, $B100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $000A

c_ether:
    dw !ILoadSpecialGraphics, $B200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $000B

c_quake:
    dw !ILoadSpecialGraphics, $B300 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $000C

c_lamp:
    dw !ILoadSpecialGraphics, $B400 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $000D

c_hammer:
    dw !ILoadSpecialGraphics, $B500 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $000E

c_shovel:
    dw !ILoadSpecialGraphics, $B600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $000F

c_flute:
    dw !ILoadSpecialGraphics, $B700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0010

c_net:
    dw !ILoadSpecialGraphics, $B800 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0011
    
c_book:
    dw !ILoadSpecialGraphics, $B900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0012
    
c_bottle_empty:
    dw !ILoadSpecialGraphics, $BA00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0013
    
c_bottle_red:
    dw !ILoadSpecialGraphics, $BB00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0014
    
c_bottle_green:
    dw !ILoadSpecialGraphics, $BC00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0015
    
c_bottle_blue:
    dw !ILoadSpecialGraphics, $BD00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0016
    
c_bottle_bee:
    dw !ILoadSpecialGraphics, $BE00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0017
    
c_bottle_good_bee:
    dw !ILoadSpecialGraphics, $BF00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0018
    
c_bottle_fairy:
    dw !ILoadSpecialGraphics, $C000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0019
    
c_somaria:
    dw !ILoadSpecialGraphics, $C100 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $001A
    
c_byrna:
    dw !ILoadSpecialGraphics, $C200 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $001B
    
c_cape:
    dw !ILoadSpecialGraphics, $C300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $001C
    
c_mirror:
    dw !ILoadSpecialGraphics, $C400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $001D
    
c_glove:
    dw !ILoadSpecialGraphics, $C500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $001E
    
c_mitt:
    dw !ILoadSpecialGraphics, $C600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $001F
    
c_boots:
    dw !ILoadSpecialGraphics, $C700 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0020
    
c_flippers:
    dw !ILoadSpecialGraphics, $C800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0021
    
c_pearl:
    dw !ILoadSpecialGraphics, $C900 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0022
    
c_sword_master:
    dw !ILoadSpecialGraphics, $CA00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0023
    
c_sword_tempered:
    dw !ILoadSpecialGraphics, $CB00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0024
    
c_sword_gold:
    dw !ILoadSpecialGraphics, $CC00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0025
    
c_tunic_blue:
    dw !ILoadSpecialGraphics, $CD00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0026
    
c_tunic_red:
    dw !ILoadSpecialGraphics, $CE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0027
    
c_shield_blue:
    dw !ILoadSpecialGraphics, $CF00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0028
    
c_shield_red:
    dw !ILoadSpecialGraphics, $D000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $0029
    
c_shield_mirror:
    dw !ILoadSpecialGraphics, $D100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $002A
    
c_heart_piece:
    dw !ILoadSpecialGraphics, $D200 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $002B
    
c_heart_container:
    dw !ILoadSpecialGraphics, $D300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $002C
    
c_arrow_1:
    dw !ILoadSpecialGraphics, $D400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $002D
    
c_arrow_5:
    dw !ILoadSpecialGraphics, $D500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $002E
    
c_arrow_10:
    dw !ILoadSpecialGraphics, $D600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $002F
    
c_bomb_3:
    dw !ILoadSpecialGraphics, $D700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0030
    
c_bomb_10:
    dw !ILoadSpecialGraphics, $D800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0031
    
c_rupee_1:
    dw !ILoadSpecialGraphics, $D900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0032
    
c_rupee_5:
    dw !ILoadSpecialGraphics, $DA00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $0033
    
c_rupee_20:
    dw !ILoadSpecialGraphics, $DB00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpChozoItem, $0034
    
c_rupee_50:
    dw !ILoadSpecialGraphics, $DC00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0035
    
c_rupee_100:
    dw !ILoadSpecialGraphics, $DD00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0036
    
c_rupee_300:
    dw !ILoadSpecialGraphics, $9300 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0037

c_magic_half:
    dw !ILoadSpecialGraphics, $E100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0038

c_magic_quarter:
    dw !ILoadSpecialGraphics, $E200 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpChozoItem, $0039

c_bomb_upgrade_5:
    dw !ILoadSpecialGraphics, $E300 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $003a

c_bomb_upgrade_10:
    dw !ILoadSpecialGraphics, $E400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpChozoItem, $003b

c_arrow_upgrade_5:
    dw !ILoadSpecialGraphics, $E500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $003c

c_arrow_upgrade_10:
    dw !ILoadSpecialGraphics, $E600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $003d

c_sword_fighter:
    dw !ILoadSpecialGraphics, $E700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpChozoItem, $003e


h_bow:
    dw !ILoadSpecialGraphics, $9200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0000

h_silver_arrows:
    dw !ILoadSpecialGraphics, $DE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0001

h_blue_boomerang:
    dw !ILoadSpecialGraphics, $DF00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0002

h_red_boomerang:
    dw !ILoadSpecialGraphics, $E000 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0003

h_hookshot:
    dw !ILoadSpecialGraphics, $9100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0004

h_bomb_1:
    dw !ILoadSpecialGraphics, $9400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0005

h_mushroom:
    dw !ILoadSpecialGraphics, $9600 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0006

h_powder:
    dw !ILoadSpecialGraphics, $9700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0007

h_fire_rod:
    dw !ILoadSpecialGraphics, $AF00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0008

h_ice_rod:
    dw !ILoadSpecialGraphics, $B000 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0009

h_bombos:
    dw !ILoadSpecialGraphics, $B100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $000A

h_ether:
    dw !ILoadSpecialGraphics, $B200 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $000B

h_quake:
    dw !ILoadSpecialGraphics, $B300 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $000C

h_lamp:
    dw !ILoadSpecialGraphics, $B400 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $000D

h_hammer:
    dw !ILoadSpecialGraphics, $B500 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $000E

h_shovel:
    dw !ILoadSpecialGraphics, $B600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $000F

h_flute:
    dw !ILoadSpecialGraphics, $B700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0010

h_net:
    dw !ILoadSpecialGraphics, $B800 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0011
    
h_book:
    dw !ILoadSpecialGraphics, $B900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0012
    
h_bottle_empty:
    dw !ILoadSpecialGraphics, $BA00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0013
    
h_bottle_red:
    dw !ILoadSpecialGraphics, $BB00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0014
    
h_bottle_green:
    dw !ILoadSpecialGraphics, $BC00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0015
    
h_bottle_blue:
    dw !ILoadSpecialGraphics, $BD00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0016
    
h_bottle_bee:
    dw !ILoadSpecialGraphics, $BE00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0017
    
h_bottle_good_bee:
    dw !ILoadSpecialGraphics, $BF00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0018
    
h_bottle_fairy:
    dw !ILoadSpecialGraphics, $C000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0019
    
h_somaria:
    dw !ILoadSpecialGraphics, $C100 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $001A
    
h_byrna:
    dw !ILoadSpecialGraphics, $C200 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $001B
    
h_cape:
    dw !ILoadSpecialGraphics, $C300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $001C
    
h_mirror:
    dw !ILoadSpecialGraphics, $C400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $001D
    
h_glove:
    dw !ILoadSpecialGraphics, $C500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $001E
    
h_mitt:
    dw !ILoadSpecialGraphics, $C600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $001F
    
h_boots:
    dw !ILoadSpecialGraphics, $C700 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0020
    
h_flippers:
    dw !ILoadSpecialGraphics, $C800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0021
    
h_pearl:
    dw !ILoadSpecialGraphics, $C900 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0022
    
h_sword_master:
    dw !ILoadSpecialGraphics, $CA00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0023
    
h_sword_tempered:
    dw !ILoadSpecialGraphics, $CB00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0024
    
h_sword_gold:
    dw !ILoadSpecialGraphics, $CC00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0025
    
h_tunic_blue:
    dw !ILoadSpecialGraphics, $CD00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0026
    
h_tunic_red:
    dw !ILoadSpecialGraphics, $CE00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0027
    
h_shield_blue:
    dw !ILoadSpecialGraphics, $CF00 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0028
    
h_shield_red:
    dw !ILoadSpecialGraphics, $D000 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $0029
    
h_shield_mirror:
    dw !ILoadSpecialGraphics, $D100 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $002A
    
h_heart_piece:
    dw !ILoadSpecialGraphics, $D200 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $002B
    
h_heart_container:
    dw !ILoadSpecialGraphics, $D300 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $002C
    
h_arrow_1:
    dw !ILoadSpecialGraphics, $D400 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $002D
    
h_arrow_5:
    dw !ILoadSpecialGraphics, $D500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $002E
    
h_arrow_10:
    dw !ILoadSpecialGraphics, $D600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $002F
    
h_bomb_3:
    dw !ILoadSpecialGraphics, $D700 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0030
    
h_bomb_10:
    dw !ILoadSpecialGraphics, $D800 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0031
    
h_rupee_1:
    dw !ILoadSpecialGraphics, $D900 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0032
    
h_rupee_5:
    dw !ILoadSpecialGraphics, $DA00 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $0033
    
h_rupee_20:
    dw !ILoadSpecialGraphics, $DB00 : db $02, $02, $02, $02, $02, $02, $02, $02
    dw !IAlttpHiddenItem, $0034
    
h_rupee_50:
    dw !ILoadSpecialGraphics, $DC00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0035
    
h_rupee_100:
    dw !ILoadSpecialGraphics, $DD00 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0036
    
h_rupee_300:
    dw !ILoadSpecialGraphics, $9300 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0037

h_magic_half:
    dw !ILoadSpecialGraphics, $E100 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0038

h_magic_quarter:
    dw !ILoadSpecialGraphics, $E200 : db $01, $01, $01, $01, $01, $01, $01, $01
    dw !IAlttpHiddenItem, $0039

h_bomb_upgrade_5:
    dw !ILoadSpecialGraphics, $E300 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $003a

h_bomb_upgrade_10:
    dw !ILoadSpecialGraphics, $E400 : db $03, $03, $03, $03, $03, $03, $03, $03
    dw !IAlttpHiddenItem, $003b

h_arrow_upgrade_5:
    dw !ILoadSpecialGraphics, $E500 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $003c

h_arrow_upgrade_10:
    dw !ILoadSpecialGraphics, $E600 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $003d

h_sword_fighter:
    dw !ILoadSpecialGraphics, $E700 : db $00, $00, $00, $00, $00, $00, $00, $00
    dw !IAlttpHiddenItem, $003e

v_progressive_gloves:
    dw !IProgressiveItem, $0054, v_glove, v_mitt, v_mitt

c_progressive_gloves:
    dw !IProgressiveItem, $0054, c_glove, c_mitt, c_mitt

h_progressive_gloves:
    dw !IProgressiveItem, $0054, h_glove, h_mitt, h_mitt


v_progressive_swords:
    dw !IProgressiveItem, $0059, v_sword_fighter, v_sword_master, v_sword_tempered, v_sword_gold, v_sword_gold

c_progressive_swords:
    dw !IProgressiveItem, $0059, c_sword_fighter, c_sword_master, c_sword_tempered, c_sword_gold, c_sword_gold

h_progressive_swords:
    dw !IProgressiveItem, $0059, h_sword_fighter, h_sword_master, h_sword_tempered, h_sword_gold, h_sword_gold


v_progressive_shields:
    dw !IProgressiveItem, $005A, v_shield_blue, v_shield_red, v_shield_mirror, v_shield_mirror

c_progressive_shields:
    dw !IProgressiveItem, $005A, c_shield_blue, c_shield_red, c_shield_mirror, c_shield_mirror

h_progressive_shields:
    dw !IProgressiveItem, $005A, h_shield_blue, h_shield_red, h_shield_mirror, h_shield_mirror


v_progressive_armor:
    dw !IProgressiveItem, $005B, v_tunic_blue, v_tunic_red, v_tunic_red

c_progressive_armor:
    dw !IProgressiveItem, $005B, c_tunic_blue, c_tunic_red, c_tunic_red

h_progressive_armor:
    dw !IProgressiveItem, $005B, h_tunic_blue, h_tunic_red, h_tunic_red


p_visible_item:
    dw !IBranchItem, .end
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !IGoto, i_loop
    .trigger
    dw !ISetItem
    ;dw !IPlayTrackNow : db $02
    dw SOUNDFX : db $37
    dw !IAlttpPickup
    .end
    dw !IGoto, $dfa9

p_chozo_item:
    dw !IBranchItem, .end
    dw !IJSR, $dfaf
    dw !IJSR, $dfc7
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !ISetCounter8 : db $16
    dw !IGoto, i_loop
    .trigger
    dw !ISetItem
    ;dw !IPlayTrackNow : db $02
    dw SOUNDFX : db $37
    dw !IAlttpPickup
    .end
    dw $0001, $a2b5
    dw !IKill

p_hidden_item:
    .loop2
    dw !IJSR, $e007
    dw !IBranchItem, .end
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !ISetCounter8 : db $16   
    .loop
    dw !IDrawCustom1
    dw !IDrawCustom2
    dw !IGotoDecrement, .loop
    dw !IJSR, $e020
    dw !IGoto, .loop2
    .trigger
    dw !ISetItem
    ;dw !IPlayTrackNow : db $02
    dw SOUNDFX : db $37
    dw !IAlttpPickup
    .end
    dw !IJSR, $e032
    dw !IGoto, .loop2

i_loop:
    dw !IDrawCustom1
    dw !IDrawCustom2
    dw !IGoto, i_loop    

i_visible_item:
    lda $0000,y
    sta $7ffb00,x               ; Store ALTTP item index to temp memory
    ldy #p_visible_item
    rts

i_chozo_item:
    lda $0000,y
    sta $7ffb00,x
    ldy #p_chozo_item
    rts

i_hidden_item:
    lda $0000,y
    sta $7ffb00,x
    ldy #p_hidden_item
    rts


warnpc $850000

org $c498e3
base $8498e3
CLIPCHECK:
	LDA $05D7
	CMP #$0002
	BEQ $0E
	LDA #$0000
	JSL $808FF7
	LDA $07F5
	JSL $808FC1
	LDA #$0000
	STA $05D7
	RTL

CLIPSET:
	LDA #$0001
	STA $05D7
	JSL $82BE17
	LDA #$0000
	RTS
SOUNDFX:
	JSR SETFX
	AND #$00FF
	JSL $809049
	RTS
SPECIALFX:
	JSR SETFX
	JSL $8090CB
	RTS
MISCFX:
	JSR SETFX
	JSL $80914D
	RTS
SETFX:
	LDA #$0002
	STA $05D7
	LDA $0000,y
	INY
	RTS

i_pickup:
    jsl alttp_item_pickup
    rts

i_progressive_item:
    jsl alttp_progressive_item
    rts

warnpc $849953

org $f30000
;!SM_INVENTORY_SWAP = $a0638c
;!SM_INVENTORY_SWAP_2 = $a0638e

!SM_INVENTORY_SWAP = !SRAM_ALTTP_ITEM_BUF+$8c
!SM_INVENTORY_SWAP_2 = !SRAM_ALTTP_ITEM_BUF+$8e

alttp_progressive_item:
    phx
    lda $0000,y                 ; Load SRAM offset of progressive item
    iny : iny                   ; Y points to value of first progressive item
    sty $89
    tax
    lda !SRAM_ALTTP_ITEM_BUF,x  ; Load current item value
    and #$00ff
    asl a                       ; Shift left for table lookup
    clc : adc $89
    tax
    ldy $0000,x                 ; Set Y to next instruction by lookup table
    plx
    rtl

alttp_item_pickup:
    phx
    phy
    php
    lda $7ffb00,x               ; Load previously saved item index
    jsl check_item_swap         ; Set correct item swap flag if needed
    asl : asl : asl             ; Value * 8 to get a table index
    tax
    lda.l alttp_item_table,x    ; Get ALTTP SRAM index
    tay                         ; Store Index in Y
    lda.l alttp_item_table+4,x  ; Get item type
    sta.l $89                   ; Store item type in temp variable
    and #$00ff
    
    cmp #$0000
    beq .normal_item_jmp
    cmp #$0001
    beq .increment_item_jmp
    cmp #$0002
    beq .bottle_item_jmp
    cmp #$0003
    beq .piece_of_heart_jmp
    cmp #$0004
    beq .rupees_jmp
    cmp #$0005
    beq .boots_jmp
    cmp #$0006
    beq .flippers_jmp
    cmp #$0007
    beq .silvers_jmp
    jmp .end

.normal_item_jmp
    jmp .normal_item
.increment_item_jmp
    jmp .increment_item
.bottle_item_jmp
    jmp .bottle_item
.piece_of_heart_jmp
    jmp .piece_of_heart
.rupees_jmp
    jmp .rupees
.boots_jmp
    jmp .boots
.flippers_jmp
    jmp .flippers
.silvers_jmp
    jmp .silvers

.normal_item
    lda.l alttp_item_table+2,x               ; Get Item value
    phx
    tyx
    %a8()
    cmp.l !SRAM_ALTTP_ITEM_BUF,x             ; Prevent downgrades
    bcc .normal_item_end
    beq .check_progressive
    sta.l !SRAM_ALTTP_ITEM_BUF,x             ; Save value to ALTTP SRAM

.normal_item_end
    %a16()
    plx
    jmp .end

.check_progressive
    pha
    lda $8a
    and #$01
    cmp #$01
    beq +
    pla
    sta.l !SRAM_ALTTP_ITEM_BUF,x
    bra .normal_item_end

+
    pla   ; Progressive item that we already have, force upgrade
    inc a
    sta.l !SRAM_ALTTP_ITEM_BUF,x
    %a16()
    and #$00ff
    sta $89
    plx
    lda.l alttp_item_table,x
    sta $87
    
    ; find the new index to the alttp_item_table so we can show the correct text box
    ldx #$0000
-
    lda.l alttp_item_table,x
    cmp.l $87
    bne +
    lda.l alttp_item_table+2,x
    cmp.l $89
    bne +
    jmp .end
+    
    txa
    clc
    adc #$0008
    tax
    bra -


.increment_item
    lda.l alttp_item_table+2,x
    phx
    tyx
    %a8()
    clc
    adc.l !SRAM_ALTTP_ITEM_BUF,x
    sta.l !SRAM_ALTTP_ITEM_BUF,x
    %a16()
    plx
    jmp .end

.bottle_item
    phx
    tyx
    lda #$0000
    %a8()
    lda.b #$01
    sta.l !SRAM_ALTTP_ITEM_BUF,x    ; Set we have bottles flag
    ldx #$0000

-
    lda.l !SRAM_ALTTP_ITEM_BUF+$5c,x
    beq .found_bottle_index
    inx
    cpx #$0004
    bne -
    %a16()
    plx
    jmp .end                                ; Bail out if we have all bottles already
.found_bottle_index
    txy
    plx
    lda.l alttp_item_table+2,x    ; Get bottle value
    phx
    tyx
    sta.l !SRAM_ALTTP_ITEM_BUF+$5c,x         ; $a0635b,x             ; Store bottle value to the correct bottle index
    %a16()
    plx
    jmp .end

.piece_of_heart
    %a8()
    phx
    tyx
    lda.l !SRAM_ALTTP_ITEM_BUF,x             ; Load amount of heart pieces
    inc a                                    ; Increment
    cmp.b #$04                               ; Oh we got 4, then give a real heartpiece
    bne .no_heartpiece
    lda #$00
    sta.l !SRAM_ALTTP_ITEM_BUF,x             ; Reset heartpieces
    lda.l !SRAM_ALTTP_ITEM_BUF+$6c           ; $a0636C               
    clc
    adc #$08
    sta.l !SRAM_ALTTP_ITEM_BUF+$6c           ; $a0636C               ; Give a heartpiece
    lda.l !SRAM_ALTTP_ITEM_BUF+$6c
    sta.l !SRAM_ALTTP_ITEM_BUF+$6d           ; Refill Link's Health
    bra .piece_end

.no_heartpiece
    sta.l !SRAM_ALTTP_ITEM_BUF,x             ; Store heartpieces
.piece_end
    %a16()
    plx
    jmp .end

.rupees
    lda.l alttp_item_table+2,x  ; 16-bit add
    phx
    tyx
    clc
    adc.l !SRAM_ALTTP_ITEM_BUF+$2,x
    sta.l !SRAM_ALTTP_ITEM_BUF,x
    sta.l !SRAM_ALTTP_ITEM_BUF+$2,x
    plx
    jmp .end

.boots
    lda.l alttp_item_table+2,x  ; Get Item value
    phx
    tyx
    %a8()
    sta.l !SRAM_ALTTP_ITEM_BUF,x             ; Save value to ALTTP SRAM
    lda.l !SRAM_ALTTP_ITEM_BUF+$79          ; $a06379
    ora #$04
    sta.l !SRAM_ALTTP_ITEM_BUF+$79          ;$a06379               ; Set dash bit
    %a16()    
    plx
    jmp .end

.flippers
    lda.l alttp_item_table+2,x  ; Get Item value
    phx
    tyx
    %a8()
    sta.l !SRAM_ALTTP_ITEM_BUF,x             ; Save value to ALTTP SRAM
    lda.l !SRAM_ALTTP_ITEM_BUF+$79          ; $a06379
    ora #$02
    sta.l !SRAM_ALTTP_ITEM_BUF+$79          ;$a06379               ; Set swim bit
    %a16()    
    plx
    jmp .end

.silvers
    %a8()
    lda.l !SRAM_ALTTP_ITEM_BUF+$40  ;$a06340               ; Load bow value
    beq .nobow
    clc
    adc #$02
    sta.l !SRAM_ALTTP_ITEM_BUF+$40               ; Store silver arrows and bow
    %a16()
    jmp .end

.nobow
    %a8()
    lda.b #$01
    sta.l !SRAM_ALTTP_ITEM_BUF+$76      ;$a06376               ; Give upgrade only silver arrows
    %a16()
    jmp .end

.end
    lda #$0168
    jsl $82e118                 ; Music fix
    lda.l alttp_item_table+6,x  ; Load message pointer
    and #$00ff
    jsl $858080                 ; Display message
    jsl zelda_fix_checksum      ; Fix SRAM checksum
    plp
    ply
    plx
    rtl

check_item_swap:
    pha
    phy
    php    
    %ai8()
    tay
	CPY.b #$02 : BNE + ; Blue Boomerang
		LDA !SM_INVENTORY_SWAP : ORA #$80 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$03 : BNE + ; Red Boomerang
		LDA !SM_INVENTORY_SWAP : ORA #$40 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$06 : BNE + ; Mushroom
		LDA !SM_INVENTORY_SWAP : ORA #$20 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$07 : BNE + ; Magic Powder
		LDA !SM_INVENTORY_SWAP : ORA #$10 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$0F : BNE + ; Shovel
		LDA !SM_INVENTORY_SWAP : ORA #$04 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$10 : BNE + ; Flute (Inactive)
		JSR .stampFlute
		LDA !SM_INVENTORY_SWAP : ORA #$02 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$00 : BNE + ; Bow & Arrows
		LDA !SM_INVENTORY_SWAP_2 : ORA #$80 : STA !SM_INVENTORY_SWAP_2
		BRL .done
	+ CPY.b #$01 : BNE + ; Silver Arrows
		LDA !SM_INVENTORY_SWAP_2 : ORA #$40 : STA !SM_INVENTORY_SWAP_2
	+ CPY.b #$3f : BNE + ; Fighter's Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$23 : BNE + ; Master Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$24 : BNE + ; Tempered Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$25 : BNE + ; Golden Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$20 : BNE + ; Pegasus Boots
		JSR .stampBoots
		BRL .done
	+ CPY.b #$1D : BNE + ; Magic Mirror
		JSR .stampMirror
		BRL .done
    + 
.done
    plp
    ply
    pla
    rtl

!SWORD_TIME = "$a06458"
!BOOTS_TIME = "$a0645C"
!FLUTE_TIME = "$a06460"
!MIRROR_TIME = "$a06464"

.stampSword
	REP #$20 ; set 16-bit accumulator
	JSL get_total_frame_time
	LDA.l !SWORD_TIME : BNE +
	LDA.l !SWORD_TIME+2 : BNE +
		LDA.l !SRAM_TIMER1 : STA.l !SWORD_TIME
		LDA.l !SRAM_TIMER2 : STA.l !SWORD_TIME+2
	+
	SEP #$20 ; set 8-bit accumulator
RTS

.stampBoots
	REP #$20 ; set 16-bit accumulator
	JSL get_total_frame_time
	LDA.l !BOOTS_TIME : BNE +
	LDA.l !BOOTS_TIME+2 : BNE +
		LDA.l !SRAM_TIMER1 : STA.l !BOOTS_TIME
		LDA.l !SRAM_TIMER2 : STA.l !BOOTS_TIME+2
	+
	SEP #$20 ; set 8-bit accumulator
RTS

.stampFlute
	REP #$20 ; set 16-bit accumulator
	JSL get_total_frame_time
	LDA.l !FLUTE_TIME : BNE +
	LDA.l !FLUTE_TIME+2 : BNE +
		LDA.l !SRAM_TIMER1 : STA.l !FLUTE_TIME
		LDA.l !SRAM_TIMER2 : STA.l !FLUTE_TIME+2
	+
	SEP #$20 ; set 8-bit accumulator
RTS

.stampMirror
	REP #$20 ; set 16-bit accumulator
	JSL get_total_frame_time
	LDA.l !MIRROR_TIME : BNE +
	LDA.l !MIRROR_TIME+2 : BNE +
		LDA.l !SRAM_TIMER1 : STA.l !MIRROR_TIME
		LDA.l !SRAM_TIMER2 : STA.l !MIRROR_TIME+2
	+
	SEP #$20 ; set 8-bit accumulator
RTS

alttp_item_table:
namespace "alttp_item_"
    ; Offset = ALTTP SRAM Offset
    ; Value = Value to write/add to offset
    ; Type = Type of item (Item / Amount / ...)
    ; Message = Id of message box to show    

    ;  Offset Value  Type  Message
    dw $0040, $0002, $0000, $001d       ; Bow                       ; 00
    dw $0040, $0003, $0007, $001e       ; Silver Arrows
    dw $0041, $0001, $0000, $001f       ; Blue Boomerang
    dw $0041, $0002, $0000, $0020       ; Red Boomerang
    dw $0042, $0001, $0000, $0021       ; Hookshot
    dw $0075, $0001, $0001, $0022       ; Bomb 1
    dw $0044, $0001, $0000, $0023       ; Mushroom
    dw $0044, $0002, $0000, $0024       ; Powder
    dw $0045, $0001, $0000, $0025       ; Firerod
    dw $0046, $0001, $0000, $0026       ; Icerod
    dw $0047, $0001, $0000, $0027       ; Bombos
    dw $0048, $0001, $0000, $0028       ; Ether
    dw $0049, $0001, $0000, $0029       ; Quake
    dw $004A, $0001, $0000, $002A       ; Lamp
    dw $004B, $0001, $0000, $002B       ; Hammer
    dw $004C, $0001, $0000, $002C       ; Shovel
    dw $004C, $0002, $0000, $002D       ; Flute                      ; 10
    dw $004D, $0001, $0000, $002E       ; Net
    dw $004E, $0001, $0000, $002F       ; Book
    dw $004F, $0002, $0002, $0030       ; Bottle
    dw $004F, $0003, $0002, $0031       ; Red Potion
    dw $004F, $0004, $0002, $0032       ; Green Potion
    dw $004F, $0005, $0002, $0033       ; Blue Potion
    dw $004F, $0007, $0002, $0034       ; Bee
    dw $004F, $0008, $0002, $0035       ; Good Bee
    dw $004F, $0006, $0002, $0036       ; Fairy
    dw $0050, $0001, $0000, $0037       ; Somaria
    dw $0051, $0001, $0000, $0038       ; Byrna
    dw $0052, $0001, $0000, $0039       ; Cape
    dw $0053, $0002, $0000, $003A       ; Mirror
    dw $0054, $0001, $0100, $003B       ; Glove
    dw $0054, $0002, $0000, $003C       ; Mitt
    dw $0055, $0001, $0005, $003D       ; Boots                      ; 20
    dw $0056, $0001, $0006, $003E       ; Flippers
    dw $0057, $0001, $0000, $003F       ; Pearl
    dw $0059, $0002, $0100, $0040       ; Master Sword
    dw $0059, $0003, $0100, $0041       ; Tempered Sword
    dw $0059, $0004, $0000, $0042       ; Gold Sword
    dw $005B, $0001, $0100, $0043       ; Blue Tunic
    dw $005B, $0002, $0000, $0044       ; Red Tunic
    dw $005A, $0001, $0100, $0045       ; Shield
    dw $005A, $0002, $0100, $0046       ; Red Shield
    dw $005A, $0003, $0000, $0047       ; Mirror Shield
    dw $006B, $0001, $0003, $0048       ; Piece of Heart
    dw $006C, $0008, $0001, $0049       ; Heart Container
    dw $0076, $0001, $0001, $004A       ; 1 Arrow
    dw $0076, $0005, $0001, $004B       ; 5 Arrows
    dw $0076, $000A, $0001, $004C       ; 10 Arrows
    dw $0075, $0003, $0001, $004D       ; 3 Bombs                    ; 30
    dw $0075, $000A, $0001, $004E       ; 10 Bombs
    dw $0060, $0001, $0004, $004F       ; 1 Rupee
    dw $0060, $0005, $0004, $0050       ; 5 Rupees
    dw $0060, $0014, $0004, $0051       ; 20 Rupees
    dw $0060, $0032, $0004, $0052       ; 50 Rupees
    dw $0060, $0064, $0004, $0053       ; 100 Rupees
    dw $0060, $012C, $0004, $0054       ; 300 Rupees
    dw $007B, $0001, $0000, $0055       ; Half Magic
    dw $007B, $0002, $0000, $0056       ; Quarter Magic              ; 39
    dw $0070, $0005, $0001, $0057       ; +5 Bombs
    dw $0070, $000A, $0001, $0058       ; +10 Bombs
    dw $0071, $0005, $0001, $0059       ; +5 Arrows
    dw $0071, $000A, $0001, $005A       ; +10 Arrows
    dw $0059, $0001, $0100, $005B       ; Fighter Sword
    

org $c59643
base $859643
    dw !EmptySmall, !Small, bow
    dw !EmptySmall, !Small, silver_arrows
    dw !EmptySmall, !Small, blue_boomerang
    dw !EmptySmall, !Small, red_boomerang
    dw !EmptySmall, !Small, hookshot
    dw !EmptySmall, !Small, bomb_1
    dw !EmptySmall, !Small, mushroom
    dw !EmptySmall, !Small, powder
    dw !EmptySmall, !Small, firerod
    dw !EmptySmall, !Small, icerod
    dw !EmptySmall, !Small, bombos
    dw !EmptySmall, !Small, ether
    dw !EmptySmall, !Small, quake
    dw !EmptySmall, !Small, lamp
    dw !EmptySmall, !Small, hammer
    dw !EmptySmall, !Small, shovel
    dw !EmptySmall, !Small, flute
    dw !EmptySmall, !Small, net
    dw !EmptySmall, !Small, book
    dw !EmptySmall, !Small, bottle_empty
    dw !EmptySmall, !Small, bottle_red
    dw !EmptySmall, !Small, bottle_green
    dw !EmptySmall, !Small, bottle_blue
    dw !EmptySmall, !Small, bottle_bee
    dw !EmptySmall, !Small, bottle_good_bee
    dw !EmptySmall, !Small, bottle_fairy
    dw !EmptySmall, !Small, somaria
    dw !EmptySmall, !Small, byrna
    dw !EmptySmall, !Small, cape
    dw !EmptySmall, !Small, mirror
    dw !EmptySmall, !Small, glove
    dw !EmptySmall, !Small, mitt
    dw !EmptySmall, !Small, boots
    dw !EmptySmall, !Small, flippers
    dw !EmptySmall, !Small, pearl
    dw !EmptySmall, !Small, sword_master
    dw !EmptySmall, !Small, sword_tempered
    dw !EmptySmall, !Small, sword_gold
    dw !EmptySmall, !Small, tunic_blue
    dw !EmptySmall, !Small, tunic_red
    dw !EmptySmall, !Small, shield
    dw !EmptySmall, !Small, shield_red
    dw !EmptySmall, !Small, shield_mirror
    dw !EmptySmall, !Small, heart_piece
    dw !EmptySmall, !Small, heart_container
    dw !EmptySmall, !Small, arrow_1
    dw !EmptySmall, !Small, arrows_5
    dw !EmptySmall, !Small, arrows_10
    dw !EmptySmall, !Small, bombs_3
    dw !EmptySmall, !Small, bombs_10
    dw !EmptySmall, !Small, rupee_1
    dw !EmptySmall, !Small, rupees_5
    dw !EmptySmall, !Small, rupees_20
    dw !EmptySmall, !Small, rupees_50
    dw !EmptySmall, !Small, rupees_100
    dw !EmptySmall, !Small, rupees_300
    dw !EmptySmall, !Small, magic_half
    dw !EmptySmall, !Small, magic_quarter
    dw !EmptySmall, !Small, bomb_upgrade_5
    dw !EmptySmall, !Small, bomb_upgrade_10
    dw !EmptySmall, !Small, arrow_upgrade_5
    dw !EmptySmall, !Small, arrow_upgrade_10
    dw !EmptySmall, !Small, sword_fighter
    dw !EmptySmall, !Small, btn_array

table box.tbl,rtl
    ;   0                              31
bow:
    dw "______        BOW        _______"
silver_arrows:
    dw "______   SILVER ARROWS   _______"
blue_boomerang:
    dw "______  BLUE BOOMERANG   _______"
red_boomerang:
    dw "______   RED BOOMERANG   _______"
hookshot:
    dw "______     HOOKSHOT      _______"
bomb_1:
    dw "______      1 BOMB       _______"
mushroom:
    dw "______     MUSHROOM      _______"
powder:
    dw "______   MAGIC POWDER    _______"
firerod:
    dw "______     FIRE ROD      _______"
icerod:
    dw "______     ICE ROD       _______"
bombos:
    dw "______      BOMBOS       _______"
ether:
    dw "______      ETHER        _______"
quake:
    dw "______      QUAKE        _______"
lamp:
    dw "______       LAMP        _______"
hammer:
    dw "______      HAMMER       _______"
shovel:
    dw "______      SHOVEL       _______"
flute:
    dw "______      FLUTE        _______"
net:
    dw "______ BUG-CATCHING NET  _______"
book:
    dw "______  BOOK OF MUDORA   _______"
bottle_empty:
    dw "______      BOTTLE       _______"
bottle_red:
    dw "______    RED POTION     _______"
bottle_green:
    dw "______   GREEN POTION    _______"
bottle_blue:
    dw "______   BLUE POTION     _______"
bottle_bee:
    dw "______       BEE         _______"
bottle_good_bee:
    dw "______     GOOD BEE      _______"
bottle_fairy:
    dw "______      FAIRY        _______"
somaria:
    dw "______  CANE OF SOMARIA  _______"
byrna:
    dw "______   CANE OF BYRNA   _______"
cape:
    dw "______    MAGIC CAPE     _______"
mirror:
    dw "______      MIRROR       _______"
glove:
    dw "______    POWER GLOVE    _______"
mitt:
    dw "______   TITAN'S MITT    _______"
boots:
    dw "______   PEGASUS BOOTS   _______"
flippers:
    dw "______  ZORA'S FLIPPERS  _______"
pearl:
    dw "______    MOON PEARL     _______"
sword_master:
    dw "______   MASTER SWORD    _______"
sword_tempered:
    dw "______  TEMPERED SWORD   _______"
sword_gold:
    dw "______    GOLD SWORD     _______"
tunic_blue:
    dw "______     BLUE MAIL     _______"
tunic_red:
    dw "______      RED MAIL     _______"
shield:
    dw "______      SHIELD       _______"
shield_red:
    dw "______    RED SHIELD     _______"
shield_mirror:
    dw "______   MIRROR SHIELD   _______"
heart_piece:
    dw "______   HEART PIECE     _______"
heart_container:
    dw "______  HEART CONTAINER  _______"
arrow_1:
    dw "______     1 ARROW       _______"
arrows_5:
    dw "______     5 ARROWS      _______"
arrows_10:
    dw "______     10 ARROWS     _______"
bombs_3:
    dw "______      3 BOMBS      _______"
bombs_10:
    dw "______     10 BOMBS      _______"
rupee_1:
    dw "______      1 RUPEE      _______"
rupees_5:
    dw "______     5 RUPEES      _______"
rupees_20:
    dw "______     20 RUPEES     _______"
rupees_50:
    dw "______     50 RUPEES     _______"
rupees_100:
    dw "______    100 RUPEES     _______"
rupees_300:
    dw "______    300 RUPEES     _______"
magic_half:
    dw "______    HALF MAGIC     _______"
magic_quarter:
    dw "______   QUARTER MAGIC   _______"
bomb_upgrade_5:
    dw "______  5 BOMB CAPACITY  _______"
bomb_upgrade_10:
    dw "______ 10 BOMB CAPACITY  _______"
arrow_upgrade_5:
    dw "______  5 ARROW CAPACITY _______"
arrow_upgrade_10:
    dw "______ 10 ARROW CAPACITY _______"
sword_fighter:
    dw "______  FIGHTER'S SWORD  _______"

cleartable

btn_array:
	DW $0000, $012A, $012A, $012C, $012C, $012C, $0000, $0000, $0000, $0000, $0000, $0000, $0120, $0000, $0000
	DW $0000, $0000, $0000, $012A, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    DW $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000


org $c58749
base $858749
fix_1c1f:
	LDA $1C1F
	CMP #$001D
	BPL +
	RTS
+
	ADC #$027F
	RTS

; ;Jump
; 	REP #30
; 	LDA $09B4
; 	BRA $1A
; ;ItemCancel
; 	REP #30
; 	LDA $09B8
; 	BRA $13
; ;ItemSelect
; 	REP #30
; 	LDA $09BA
; 	BRA $0C
; ;AimDown
; 	REP #30
; 	LDA $09BC
; 	BRA $05
; ;AimUp
; 	REP #30
; 	LDA $09BE
; 	JMP $83D1
; ;EmptyBig
; 	REP #30
; 	JMP $8409

org $c58243
base $858243
	JSR fix_1c1f

org $c582E5
base $8582E5
	JSR fix_1c1f

org $c58413
base $858413
	DW btn_array

namespace off
