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
!IGotoIfDoorSet = #$8A72
!ISleep = #$86B4
!IVisibleItem = #i_visible_item
!IChozoItem = #i_chozo_item
!IHiddenItem = #i_hidden_item
!ILoadCustomGraphics = #i_load_custom_graphics
!IPickup = #i_pickup
!IStartDrawLoop = #i_start_draw_loop
!IStartHiddenDrawLoop = #i_start_hidden_draw_loop

!ITEM_PLM_BUF = $7ffb00
!SM_MULTIWORLD_PICKUP = $7ffafe

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

!EmptyBig = #EmptyBig
!PlaceholderBig = #PlaceholderBig

;org $01E9BC
;    db $c0

;org $cf8432
;    dw $f08c    ; Replace terminator e-tank with shovel

;org $cf86de
;    dw $efe4    ; Morph to progressive sword

org $C22D7C   ; Patch to Crateria surface palette for Z3 items e.g. PoH, Pearl
base $822D7C  ; this may be way wrong
    incbin "data/Crateria_palette.bin"

org $C23798   ; Crocomire's room changes colors $2E, $2F, $3E, and $3F for reasons unknown.
base $823798  ; They were unused, so we're fixing them here so any items that appear won't have bright/odd borders
    incbin "data/Crocomire_palette.bin"

org $c98000      ; New item graphics
base $898000
    incbin "data/newitems.bin"

org $c4efe0     ; First free space in PLM block
base $84efe0

plm_items:
    dw i_visible_item_setup, v_item       ;efe0
    dw i_visible_item_setup, c_item       ;efe4
    dw i_hidden_item_setup,  h_item       ;efe8
v_item:
    dw !IVisibleItem
c_item:
    dw !IChozoItem
h_item:
    dw !IHiddenItem

; Graphics pointers for items (by item index)
item_graphics:
    ; SM (B0-FF)
    dw $8800 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Grapple beam
    dw $8900 : db $01, $01, $00, $00, $03, $03, $00, $00    ; X-ray scope
    dw $8300 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Varia suit
    dw $8200 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Spring ball
    dw $8700 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Morph ball
    dw $8500 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Screw attack
    dw $8100 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Gravity suit
    dw $8400 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Hi-Jump
    dw $8600 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Space jump
    dw $8000 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Bombs
    dw $8A00 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Speed booster
    dw $8B00 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Charge
    dw $8C00 : db $00, $03, $00, $00, $00, $03, $00, $00    ; Ice Beam
    dw $8D00 : db $00, $02, $00, $00, $00, $02, $00, $00    ; Wave beam
    dw $8F00 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Spazer
    dw $8E00 : db $00, $01, $00, $00, $00, $01, $00, $00    ; Plasma beam
    dw $0008 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Energy Tank
    dw $9000 : db $00, $00, $00, $00, $00, $00, $00, $00    ; Reserve tank
    dw $000A : db $00, $00, $00, $00, $00, $00, $00, $00    ; Missile
    dw $000C : db $00, $00, $00, $00, $00, $00, $00, $00    ; Super Missile
    dw $000E : db $00, $00, $00, $00, $00, $00, $00, $00    ; Power Bomb


    ; ALTTP (00-AF)
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 00 Dummy - L1SwordAndShield        
    dw $CA00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 01 Master Sword
    dw $CB00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 02 Tempered Sword
    dw $CC00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 03 Gold Sword
    dw $CF00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 04 Blue Shield
    dw $D000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 05 Red Shield
    dw $D100 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 06 Mirror Shield
    dw $AF00 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 07 Fire Rod
    dw $B000 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 08 Ice Rod
    dw $B500 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 09 Hammer
    dw $9100 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 0A Hookshot
    dw $9200 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 0B Bow
    dw $DF00 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 0C Blue Boomerang
    dw $9700 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 0D Powder
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 0E Bee (bottle contents)
    dw $B100 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 0F Bombos

    dw $B200 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 10 Ether
    dw $B300 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 11 Quake
    dw $B400 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 12 Lamp
    dw $B600 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 13 Shovel
    dw $B700 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 14 Flute
    dw $C100 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 15 Somaria
    dw $BA00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 16 Empty Bottle
    dw $D200 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 17 Heart Piece
    dw $C200 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 18 Cane of Byrna
    dw $C300 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 19 Cape
    dw $C400 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 1A Mirror
    dw $C500 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 1B Gloves
    dw $C600 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 1C Titan's Mitts
    dw $B900 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 1D Book
    dw $C800 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 1E Flippers
    dw $C900 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 1F Moon Pearl

    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 20 Dummy     
    dw $B800 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 21 Bug-Catching Net
    dw $CD00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 22 Blue Tunic
    dw $CE00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 23 Red Tunic
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 24 Dummy - Key       
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 25 Dummy - Compass
    dw $D300 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 26 Heart Container (no animation)
    dw $9400 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 27 One bomb
    dw $D700 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 28 3 Bombs
    dw $9600 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 29 Mushroom
    dw $E000 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 2A Red Boomerang
    dw $BB00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 2B Red Potion Bottle
    dw $BC00 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 2C Green Potion Bottle
    dw $BD00 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 2D Blue Potion Bottle
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 2E Dummy - Red potion (contents)
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 2F Dummy - Green potion (contents)

    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 30 Dummy - Blue potion (contents)
    dw $D800 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 31 10 Bombs
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 32 Dummy - Big key
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 33 Dummy - Map
    dw $D900 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 34 1 Rupee
    dw $DA00 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 35 5 Rupees
    dw $DB00 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 36 20 Rupees
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 37 Dummy - Pendant of Courage
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 38 Dummy - Pendant of Wisdom
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 39 Dummy - Pendant of Power
    dw $9200 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 3A Bow and Arrows
    dw $DE00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 3B Silver Arrows
    dw $BE00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 3C Bee Bottle
    dw $C000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 3D Fairy Bottle
    dw $D300 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 3E Heart Container - Boss
    dw $D300 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 3F Heart Container - Sanc

    dw $DD00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 40 100 Rupees
    dw $DC00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 41 50 Rupees
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 42 Dummy - Small heart
    dw $D400 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 43 Single Arrow
    dw $D600 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 44 10 Arrows
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 45 Dummy - Small magic
    dw $9300 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 46 300 Rupees
    dw $DB00 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 47 20 Rupees
    dw $BF00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 48 Good Bee Bottle
    dw $E700 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 49 Fighter Sword
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 4A Dummy - Activated flute
    dw $C700 : db $02, $02, $02, $02, $02, $02, $02, $02        ; 4B Boots
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 4C Dummy - 50 Bomb upgrade
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 4D Dummy - 70 Arrow upgrade
    dw $E100 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 4E Half Magic
    dw $E200 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 4F Quarter Magic

    dw $CA00 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 50 Master Sword    
    dw $E300 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 51 5 Bomb Upgrade
    dw $E400 : db $03, $03, $03, $03, $03, $03, $03, $03        ; 52 10 Bomb Upgrade
    dw $E500 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 53 5 Arrow Upgrade
    dw $E600 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 54 10 Arrow Upgrade
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 55 Dummy - Programmable 1
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 56 Dummy - Programmable 2
    dw $0000 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 57 Dummy - Programmable 3
    dw $DE00 : db $01, $01, $01, $01, $01, $01, $01, $01        ; 58 Silver Arrows

    ;dw $D300 : db $02, $02, $02, $02, $02, $02, $02, $02        ; Heart Container
    ;dw $D500 : db $00, $00, $00, $00, $00, $00, $00, $00        ; 5 Arrows

sm_item_table:
    ; pickup, qty,   msg,   type,  ext2,  ext3,  loop,  hloop
    dw $891A, $4000, $0000, $0004, $0000, $0000, $0000, $0000      ; Grapple
    dw $8941, $8000, $0000, $0004, $0000, $0000, $0000, $0000      ; X-ray scope
    dw $88F3, $0001, $0007, $0004, $0000, $0000, $0000, $0000      ; Varia suit
    dw $88F3, $0002, $0008, $0004, $0000, $0000, $0000, $0000      ; Spring ball
    dw $88F3, $0004, $0009, $0004, $0000, $0000, $0000, $0000      ; Morph ball
    dw $88F3, $0008, $000A, $0004, $0000, $0000, $0000, $0000      ; Screw attack
    dw $88F3, $0020, $001A, $0004, $0000, $0000, $0000, $0000      ; Gravity suit
    dw $88F3, $0100, $000B, $0004, $0000, $0000, $0000, $0000      ; Hi-jump
    dw $88F3, $0200, $000C, $0004, $0000, $0000, $0000, $0000      ; Space jump
    dw $88F3, $1000, $0013, $0004, $0000, $0000, $0000, $0000      ; Bombs
    dw $88F3, $2000, $000D, $0004, $0000, $0000, $0000, $0000      ; Speed booster
    dw $88B0, $1000, $000E, $0005, $0000, $0000, $0000, $0000      ; Charge beam
    dw $88B0, $0002, $000F, $0005, $0000, $0000, $0000, $0000      ; Ice beam
    dw $88B0, $0001, $0010, $0005, $0000, $0000, $0000, $0000      ; Wave beam
    dw $88B0, $0004, $0011, $0005, $0000, $0000, $0000, $0000      ; Spazer
    dw $88B0, $0008, $0012, $0005, $0000, $0000, $0000, $0000      ; Plasma
    dw $8968, $0064, $0000, $0000, $0000, $0000, $E0A5, #p_etank_hloop      ; E-Tank
    dw $8986, $0064, $0000, $0006, $0000, $0000, $0000, $0000      ; Reserve tank
    dw $89A9, $0005, $0000, $0001, $0000, $0000, $E0CA, #p_missile_hloop    ; Missiles
    dw $89D2, $0005, $0000, $0002, $0000, $0000, $E0EF, #p_super_hloop      ; Super Missiles
    dw $89FB, $0005, $0000, $0003, $0000, $0000, $E114, #p_pb_hloop         ; Power Bombs


progressive_items:
    db $5e, $59, $04, $49, $01, $02, $03, $00     ; Progressive sword
    db $5f, $5A, $03, $04, $05, $06, $00, $00     ; Progressive shield
    db $60, $5B, $02, $22, $23, $00, $00, $00     ; Progressive armor
    db $61, $54, $02, $1b, $1c, $00, $00, $00     ; Progressive glove
    db $ff

i_visible_item:
    lda #$0006
    jsr i_load_rando_item
    rts

i_chozo_item:
    lda #$0008
    jsr i_load_rando_item
    rts

i_hidden_item:
    lda #$000A
    jsr i_load_rando_item
    rts

p_etank_hloop:
    dw $0004, $a2df
    dw $0004, $a2e5
    dw !IGotoDecrement, p_etank_hloop
    dw !IJSR, $e020
    dw !IGoto, p_hidden_item_loop2

p_missile_hloop:
    dw $0004, $A2EB
    dw $0004, $A2F1
    dw !IGotoDecrement, p_missile_hloop
    dw !IJSR, $e020
    dw !IGoto, p_hidden_item_loop2

p_super_hloop:
    dw $0004, $A2F7
    dw $0004, $A2FD
    dw !IGotoDecrement, p_super_hloop
    dw !IJSR, $e020
    dw !IGoto, p_hidden_item_loop2

p_pb_hloop:
    dw $0004, $A303
    dw $0004, $A309
    dw !IGotoDecrement, p_pb_hloop
    dw !IJSR, $e020
    dw !IGoto, p_hidden_item_loop2

p_visible_item:
    dw !ILoadCustomGraphics
    dw !IBranchItem, .end
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !IStartDrawLoop
    .loop
    dw !IDrawCustom1
    dw !IDrawCustom2
    dw !IGoto, .loop
    .trigger
    dw !ISetItem
    dw SOUNDFX : db !Click
    dw !IPickup
    .end
    dw !IGoto, $dfa9

p_chozo_item:
    dw !ILoadCustomGraphics
    dw !IBranchItem, .end
    dw !IJSR, $dfaf
    dw !IJSR, $dfc7
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !ISetCounter8 : db $16
    dw !IStartDrawLoop
    .loop
    dw !IDrawCustom1
    dw !IDrawCustom2
    dw !IGoto, .loop
    .trigger
    dw !ISetItem
    dw SOUNDFX : db !Click
    dw !IPickup
    .end
    dw $0001, $a2b5
    dw !IKill   

p_hidden_item:
    dw !ILoadCustomGraphics
    .loop2
    dw !IJSR, $e007
    dw !IBranchItem, .end
    dw !ISetGoto, .trigger
    dw !ISetPreInstructionCode, $df89
    dw !ISetCounter8 : db $16
    dw !IStartHiddenDrawLoop
    .loop
    dw !IDrawCustom1
    dw !IDrawCustom2
    dw !IGotoDecrement, .loop
    dw !IJSR, $e020
    dw !IGoto, .loop2
    .trigger
    dw !ISetItem
    dw SOUNDFX : db !Click
    dw !IPickup
    .end
    dw !IJSR, $e032
    dw !IGoto, .loop2

i_start_draw_loop:
    phy : phx
    lda !ITEM_PLM_BUF, x    ; Load item id
    cmp #$0015
    bcc .smItem
    bra .custom_item

.smItem
    asl #4
    clc : adc #$000C
    tax
    lda sm_item_table, x      ; Load next loop point if available
    beq .custom_item
    plx : ply
    tay
    rts

.custom_item
    plx
    ply
    rts

i_start_hidden_draw_loop:
    phy : phx
    lda !ITEM_PLM_BUF, x    ; Load item id
    cmp #$0015
    bcc .smItem
    bra .custom_item

.smItem
    asl #4
    clc : adc #$000E
    tax
    lda sm_item_table, x      ; Load next loop point if available
    beq .custom_item
    plx : ply
    tay
    rts

.custom_item
    plx
    ply
    rts

i_load_custom_graphics:
    phy : phx 
    lda !ITEM_PLM_BUF, x    ; Load item id

    %a8()
    sta $4202
    lda #$0A
    sta $4203
    nop : nop : %ai16()
    lda $4216               ; Multiply it by 0x0A
    clc
    adc #item_graphics
    tay                     ; Add it to the graphics table and transfer into Y
    lda $0000, y
    cmp #$8000
    bcc .no_custom    
    jsr $8764               ; Jump to original PLM graphics loading routine
    plx
    ply
    rts

.no_custom
    tay
    lda $0000, y
    sta.l $7edf0c, x
    plx
    ply
    rts

i_visible_item_setup:
    phy : phx
    jsr load_item_id                
    %a8()
    sta $4202
    lda #$0A
    sta $4203
    nop : nop : %ai16()
    lda $4216                       ; Multiply it by 0x0A
    tax

    lda item_graphics, x
    cmp #$8000
    bcc .no_custom
    plx : ply
    jmp $ee64

.no_custom
    plx : ply
    tyx
    sta.l $7edf0c, x
    jmp $ee64

i_hidden_item_setup:
    phy : phx
    jsr load_item_id
    %a8()
    sta $4202
    lda #$0A
    sta $4203
    nop : nop : %ai16()
    lda $4216                       ; Multiply it by 0x0A
    tax

    lda item_graphics, x
    cmp #$8000
    bcc .no_custom
    plx : ply
    jmp $ee8e
    
.no_custom
    plx : ply
    tyx
    sta.l $7edf0c, x
    jmp $ee8e


i_load_rando_item:
    cmp #$0006 : bne +
    ldy #p_visible_item
    bra .end
+   cmp #$0008 : bne +    
    ldy #p_chozo_item
    bra .end
+   ldy #p_hidden_item

.end
    rts

; Pick up item
i_pickup:
    phx : phy : php : phx
    lda.l config_multiworld
    beq .own_item

    lda $1dc7, x              ; Load PLM room argument
    asl #3 : tax

    lda #$0000
    sta !SM_MULTIWORLD_PICKUP

    lda.l rando_item_table, x       ; Load item type
    beq .own_item

.multiworld_item                    ; This is someone elses item, send message
    phx
    lda.l rando_item_table+$4, x    ; Load item owner into Y
    tay
    lda.l rando_item_table+$2, x    ; Load original item id into X
    tax
    pla                             ; Multiworld item table id in A
    phx : phy
    jsl mw_write_message            ; Send message
    ply : plx
    jsl sm_mw_display_item_sent     ; Display custom message box
    plx
    bra .end

.own_item
    plx
    lda !ITEM_PLM_BUF, x        ; Load adjusted item id (progression etc)
    cmp #$0015
    bcc .smItem
    sec
    sbc #$0015
    sta !ITEM_PLM_BUF, x        ; Readjust item id so it fits the ALTTP table again
    jsl alttp_item_pickup
    bra .end

.smItem
    jsr receive_sm_item
    bra .end

.end
    plp : ply : plx
    rts

; Get item ID from randomizer table (and adjust item id to local tables as needed for graphics display)
load_item_id:
    phx : phy
    lda.l config_multiworld
    bne .multiworld_item
    lda $1dc7, y                    ; Load PLM room argument
    xba
    and #$00ff                      ; Get top 8 bits of room argument as item id
    bra .checkItem
.multiworld_item
    lda $1dc7, y                    ; Load PLM room argument
    asl #3 : tax    
    lda.l rando_item_table+$2, x    ; Load item id from table
.checkItem
    jsr check_upgrade_item
    cmp #$00b0                      ; b0+ = SM Item
    bcc .alttpItem
    sec
    sbc #$00b0                      ; Subtract $b0 since we have SM items starting at index 00
    bra +
.alttpItem
    clc
    adc #$0015                      ; Offset alttp items by #$14 to point to the correct table entries
+
    ply
    tyx
    sta !ITEM_PLM_BUF, x            ; Store adjusted item id (used for custom graphics and things) 
    plx
    rts                             

check_upgrade_item:
    phx
    %a8()
    sta $c5
    ldx #$0000
-
    lda progressive_items, x
    cmp #$ff
    beq .notFound
    cmp $c5
    beq .found
    txa : clc : adc #$08 : tax
    bne -
.found
    lda progressive_items+$1, x     ; Load SRAM index offset
    phx : tax
    lda !SRAM_ALTTP_ITEM_BUF, x
    plx
    cmp progressive_items+$2, x     ; Check against max allowed value
    beq +
    inc
+
    stx $c5 : clc : adc $c5 : tax   ; Add upgraded item value to x
    lda progressive_items+$2, x     ; Get new item id
    bra +

.notFound
    lda $c5
+
    %ai16()
    and #$00ff
    plx
    rts

check_upgrade_item_long:
    phb : phk : plb
    jsr check_upgrade_item
    plb
    rtl

; Item index to receive in A
receive_sm_item:
    asl : asl : asl : asl
    phx
    clc
    adc #sm_item_table ; A contains pointer to pickup routine from item table
    tax
    tay
    iny : iny          ; Y points to data to be used in item pickup routine
    jsr ($0000,x)
    plx
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

sm_mw_call_receive:
    phx : phy
    jsr SETFX
    lda #$0037
    jsl $809049
    ply : plx
    jsr ($0000,x)
    rtl
    
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
    lda.l config_multiworld
    beq +
    lda !SM_MULTIWORLD_PICKUP
    bne .multiworldItemId
+
    lda $7ffb00,x               ; Load previously saved item index
    bra .checkItemSwap
.multiworldItemId                                
    lda $c1                     ; This item was gotten from another player in MW
    jsl check_upgrade_item_long ; Progress item if needed
.checkItemSwap
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
    ;lda #$0168
    ;jsl $82e118                 ; Music fix (no need with nofanfare?)
    lda.l config_multiworld
    beq +

    lda.l !SM_MULTIWORLD_PICKUP
    bne .multiworldMessage
+
    lda.l alttp_item_table+6,x  ; Load message pointer
    and #$00ff
    jsl $858080                 ; Display message
    bra +
.multiworldMessage
    lda #$005d
    jsl $858080                 ; Display multiworld message
    lda #$0000
    sta !SM_MULTIWORLD_PICKUP
+
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
	CPY.b #$0C : BNE + ; Blue Boomerang
		LDA !SM_INVENTORY_SWAP : ORA #$80 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$2A : BNE + ; Red Boomerang
		LDA !SM_INVENTORY_SWAP : ORA #$40 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$29 : BNE + ; Mushroom
		LDA !SM_INVENTORY_SWAP : ORA #$20 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$0D : BNE + ; Magic Powder
		LDA !SM_INVENTORY_SWAP : ORA #$10 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$13 : BNE + ; Shovel
		LDA !SM_INVENTORY_SWAP : ORA #$04 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$14 : BNE + ; Flute (Inactive)
		LDA !SM_INVENTORY_SWAP : ORA #$02 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$4A : BNE + ; Flute (Active)
		LDA !SM_INVENTORY_SWAP : ORA #$01 : STA !SM_INVENTORY_SWAP
		BRL .done
	+ CPY.b #$0B : BNE + ; Bow
    	LDA !SM_INVENTORY_SWAP_2 : ORA #$80 : STA !SM_INVENTORY_SWAP_2
		BRL .done
	+ CPY.b #$3A : BNE + ; Bow & Arrows
		LDA !SM_INVENTORY_SWAP_2 : ORA #$80 : STA !SM_INVENTORY_SWAP_2
		BRL .done
	+ CPY.b #$3B : BNE + ; Bow & Silver Arrows
		LDA !SM_INVENTORY_SWAP_2 : ORA #$40 : STA !SM_INVENTORY_SWAP_2
		BRL .done
	+ CPY.b #$43 : BNE + ; Single arrow
		LDA !SM_INVENTORY_SWAP_2 : ORA #$80 : STA !SM_INVENTORY_SWAP_2 ; activate wood arrows in quick-swap
		BRL .done
	+ CPY.b #$58 : BNE + ; Upgrade-Only Silver Arrows
		LDA !SM_INVENTORY_SWAP_2 : ORA #$40 : STA !SM_INVENTORY_SWAP_2
	+ CPY.b #$49 : BNE + ; Fighter's Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$01 : BNE + ; Master Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$50 : BNE + ; Master Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$02 : BNE + ; Tempered Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$03 : BNE + ; Golden Sword
		JSR .stampSword
		BRL .done
	+ CPY.b #$4B : BNE + ; Pegasus Boots
		JSR .stampBoots
		BRL .done
	+ CPY.b #$1A : BNE + ; Magic Mirror
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
    dw $0000, $0000, $0000, $0000       ; 00 Dummy - L1SwordAndShield 
    dw $0059, $0002, $0100, $0040       ; 01 Master Sword
    dw $0059, $0003, $0100, $0041       ; 02 Tempered Sword
    dw $0059, $0004, $0000, $0042       ; 02 Gold Sword
    dw $005A, $0001, $0100, $0045       ; 04 Shield
    dw $005A, $0002, $0100, $0046       ; 05 Red Shield
    dw $005A, $0003, $0000, $0047       ; 06 Mirror Shield
    dw $0045, $0001, $0000, $0025       ; 07 Firerod
    dw $0046, $0001, $0000, $0026       ; 08 Icerod  
    dw $004B, $0001, $0000, $002B       ; 09 Hammer
    dw $0042, $0001, $0000, $0021       ; 0A Hookshot
    dw $0040, $0002, $0000, $001d       ; 0B Bow                       
    dw $0041, $0001, $0000, $001f       ; 0C Blue Boomerang
    dw $0044, $0002, $0000, $0024       ; 0D Powder
    dw $0000, $0000, $0000, $0000       ; 0E Dummy - Bee (bottle content)
    dw $0047, $0001, $0000, $0027       ; 0F Bombos
    
    dw $0048, $0001, $0000, $0028       ; 10 Ether
    dw $0049, $0001, $0000, $0029       ; 11 Quake
    dw $004A, $0001, $0000, $002A       ; 12 Lamp
    dw $004C, $0001, $0000, $002C       ; 13 Shovel
    dw $004C, $0002, $0000, $002D       ; 14 Flute                      
    dw $0050, $0001, $0000, $0037       ; 15 Somaria
    dw $004F, $0002, $0002, $0030       ; 16 Bottle
    dw $006B, $0001, $0003, $0048       ; 17 Piece of Heart
    dw $0051, $0001, $0000, $0038       ; 18 Byrna
    dw $0052, $0001, $0000, $0039       ; 19 Cape
    dw $0053, $0002, $0000, $003A       ; 1A Mirror
    dw $0054, $0001, $0100, $003B       ; 1B Glove
    dw $0054, $0002, $0000, $003C       ; 1C Mitt
    dw $004E, $0001, $0000, $002F       ; 1D Book
    dw $0056, $0001, $0006, $003E       ; 1E Flippers
    dw $0057, $0001, $0000, $003F       ; 1F Pearl
    
    dw $0000, $0000, $0000, $0000       ; 20 Dummy 
    dw $004D, $0001, $0000, $002E       ; 21 Net
    dw $005B, $0001, $0100, $0043       ; 22 Blue Tunic
    dw $005B, $0002, $0000, $0044       ; 23 Red Tunic
    dw $0000, $0000, $0000, $0000       ; 24 Dummy - key
    dw $0000, $0000, $0000, $0000       ; 25 Dummy - compass
    dw $006C, $0008, $0001, $0049       ; 26 Heart Container - no anim
    dw $0075, $0001, $0001, $0022       ; 27 Bomb 1
    dw $0075, $0003, $0001, $004D       ; 28 3 Bombs                    
    dw $0044, $0001, $0000, $0023       ; 29 Mushroom
    dw $0041, $0002, $0000, $0020       ; 2A Red Boomerang
    dw $004F, $0003, $0002, $0031       ; 2B Red Potion
    dw $004F, $0004, $0002, $0032       ; 2C Green Potion
    dw $004F, $0005, $0002, $0033       ; 2D Blue Potion
    dw $0000, $0000, $0000, $0000       ; 2E Dummy - red
    dw $0000, $0000, $0000, $0000       ; 2F Dummy - green
    
    dw $0000, $0000, $0000, $0000       ; 30 Dummy - blue
    dw $0075, $000A, $0001, $004E       ; 31 10 Bombs
    dw $0000, $0000, $0000, $0000       ; 32 Dummy - big key
    dw $0000, $0000, $0000, $0000       ; 33 Dummy - map
    dw $0060, $0001, $0004, $004F       ; 34 1 Rupee
    dw $0060, $0005, $0004, $0050       ; 35 5 Rupees
    dw $0060, $0014, $0004, $0051       ; 36 20 Rupees
    dw $0000, $0000, $0000, $0000       ; 37 Dummy - Pendant of Courage
    dw $0000, $0000, $0000, $0000       ; 38 Dummy - Pendant of Wisdom
    dw $0000, $0000, $0000, $0000       ; 39 Dummy - Pendant of Power
    dw $0040, $0002, $0000, $001d       ; 3A Bow and arrows
    dw $0040, $0003, $0007, $001e       ; 3B Bow and silver Arrows
    dw $004F, $0007, $0002, $0034       ; 3C Bee
    dw $004F, $0006, $0002, $0036       ; 3D Fairy
    dw $006C, $0008, $0001, $0049       ; 3E Heart Container - Boss
    dw $006C, $0008, $0001, $0049       ; 3F Heart Container - Sanc
    
    dw $0060, $0064, $0004, $0053       ; 40 100 Rupees
    dw $0060, $0032, $0004, $0052       ; 41 50 Rupees
    dw $0000, $0000, $0000, $0000       ; 42 Dummy - small heart
    dw $0076, $0001, $0001, $004A       ; 43 1 Arrow
    dw $0076, $000A, $0001, $004C       ; 44 10 Arrows
    dw $0000, $0000, $0000, $0000       ; 45 Dummy - small magic
    dw $0060, $012C, $0004, $0054       ; 46 300 Rupees
    dw $0060, $0014, $0004, $0051       ; 47 20 Rupees
    dw $004F, $0008, $0002, $0035       ; 48 Good Bee
    dw $0059, $0001, $0100, $005B       ; 49 Fighter Sword
    dw $0000, $0000, $0000, $0000       ; 4A Dummy - activated flute
    dw $0055, $0001, $0005, $003D       ; 4B Boots                      
    dw $0000, $0000, $0000, $0000       ; 4C Dummy - 50+bombs
    dw $0000, $0000, $0000, $0000       ; 4D Dummy - 70+arrows
    dw $007B, $0001, $0000, $0055       ; 4E Half Magic
    dw $007B, $0002, $0000, $0056       ; 4F Quarter Magic              
    
    dw $0059, $0002, $0100, $0040       ; 50 Master Sword
    dw $0070, $0005, $0001, $0057       ; 51 +5 Bombs
    dw $0070, $000A, $0001, $0058       ; 52 +10 Bombs
    dw $0071, $0005, $0001, $0059       ; 53 +5 Arrows
    dw $0071, $000A, $0001, $005A       ; 54 +10 Arrows
    dw $0000, $0000, $0000, $0000       ; 55 Dummy - Programmable 1
    dw $0000, $0000, $0000, $0000       ; 56 Dummy - Programmable 2
    dw $0000, $0000, $0000, $0000       ; 57 Dummy - Programmable 3
    dw $0040, $0003, $0007, $001e       ; 58 Silver Arrows

;    dw $006C, $0008, $0001, $0049       ; Heart Container
;    dw $0076, $0005, $0001, $004B       ; 5 Arrows




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
    dw !PlaceholderBig, !Big, sm_item_sent
    dw !PlaceholderBig, !Big, sm_item_received
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

sm_item_sent:
    dw "___         YOU FOUND        ___"
    dw "___      ITEM NAME HERE      ___"
    dw "___           FOR            ___"
    dw "___          PLAYER          ___"

sm_item_received:
    dw "___       YOU RECEIVED       ___"
    dw "___      ITEM NAME HERE      ___"
    dw "___           FROM           ___"
    dw "___          PLAYER          ___"

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

table box_yellow.tbl,rtl
item_names:
    dw "___      GRAPPLING BEAM      ___"   ; 00 (b0) (sm items)
    dw "___       X-RAY SCOPE        ___"
    dw "___        VARIA SUIT        ___"
    dw "___       SPRING BALL        ___"
    dw "___       MORPHING BALL      ___"
    dw "___       SCREW ATTACK       ___"
    dw "___       GRAVITY SUIT       ___"
    dw "___       HI-JUMP BOOTS      ___"
    dw "___        SPACE JUMP        ___"
    dw "___          BOMBS           ___"
    dw "___       SPEED BOOSTER      ___"
    dw "___       CHARGE BEAM        ___"
    dw "___         ICE BEAM         ___"
    dw "___        WAVE BEAM         ___"
    dw "___       S P A Z E R        ___"
    dw "___       PLASMA BEAM        ___"
    dw "___      AN ENERGY TANK      ___"
    dw "___      A RESERVE TANK      ___"
    dw "___         MISSILES         ___"
    dw "___       SUPER MISSILES     ___"
    dw "___        POWER BOMBS       ___"

    dw "___                          ___"       ; $15+ (alttp items)
    dw "___       MASTER SWORD       ___"
    dw "___      TEMPERED SWORD      ___"
    dw "___        GOLD SWORD        ___"
    dw "___          SHIELD          ___"
    dw "___        RED SHIELD        ___"
    dw "___       MIRROR SHIELD      ___"
    dw "___         FIRE ROD         ___"
    dw "___         ICE ROD          ___"
    dw "___          HAMMER          ___"
    dw "___         HOOKSHOT         ___"
    dw "___           BOW            ___"
    dw "___      BLUE BOOMERANG      ___"
    dw "___       MAGIC POWDER       ___"
    dw "___                          ___"
    dw "___          BOMBOS          ___"
    dw "___          ETHER           ___"
    dw "___          QUAKE           ___"
    dw "___           LAMP           ___"
    dw "___          SHOVEL          ___"
    dw "___          FLUTE           ___"
    dw "___      CANE OF SOMARIA     ___"
    dw "___          BOTTLE          ___"
    dw "___       HEART PIECE        ___"
    dw "___       CANE OF BYRNA      ___"
    dw "___        MAGIC CAPE        ___"
    dw "___          MIRROR          ___"
    dw "___        POWER GLOVE       ___"
    dw "___       TITAN'S MITT       ___"
    dw "___      BOOK OF MUDORA      ___"
    dw "___      ZORA'S FLIPPERS     ___"
    dw "___        MOON PEARL        ___"
    dw "___                          ___"
    dw "___     BUG-CATCHING NET     ___"
    dw "___         BLUE MAIL        ___"
    dw "___          RED MAIL        ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___      HEART CONTAINER     ___"
    dw "___          1 BOMB          ___"
    dw "___          3 BOMBS         ___"
    dw "___         MUSHROOM         ___"
    dw "___       RED BOOMERANG      ___"
    dw "___        RED POTION        ___"
    dw "___       GREEN POTION       ___"
    dw "___       BLUE POTION        ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___         10 BOMBS         ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___          1 RUPEE         ___"
    dw "___         5 RUPEES         ___"
    dw "___         20 RUPEES        ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___           BOW            ___"
    dw "___       SILVER ARROWS      ___"
    dw "___           BEE            ___"
    dw "___          FAIRY           ___"
    dw "___      HEART CONTAINER     ___"
    dw "___      HEART CONTAINER     ___"
    dw "___        100 RUPEES        ___"
    dw "___         50 RUPEES        ___"
    dw "___                          ___"
    dw "___         1 ARROW          ___"
    dw "___         10 ARROWS        ___"
    dw "___                          ___"
    dw "___        300 RUPEES        ___"
    dw "___         20 RUPEES        ___"
    dw "___         GOOD BEE         ___"
    dw "___      FIGHTER'S SWORD     ___"
    dw "___                          ___"
    dw "___       PEGASUS BOOTS      ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___        HALF MAGIC        ___"
    dw "___       QUARTER MAGIC      ___"
    dw "___       MASTER SWORD       ___"
    dw "___      5 BOMB CAPACITY     ___"
    dw "___     10 BOMB CAPACITY     ___"
    dw "___      5 ARROW CAPACITY    ___"
    dw "___     10 ARROW CAPACITY    ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___       SILVER ARROWS      ___"   ; 58
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___                          ___"
    dw "___    PROGRESSIVE SWORD     ___"
    dw "___    PROGRESSIVE SHIELD    ___"
    dw "___    PROGRESSIVE ARMOR     ___"
    dw "___    PROGRESSIVE GLOVE     ___"


cleartable

write_placeholders:
    phx : phy
    lda $1c1f
    cmp #$005c
    beq .adjust
    cmp #$005d
    beq .adjust
    bra .end

.adjust
    lda $c1                 ; Load item id
    cmp #$00b0              
    bcc .alttpItem
    sec
    sbc #$00b0
    bra +
.alttpItem
    clc
    adc #$0015
+
    asl #6 : tay
    ldx #$0000
-
    lda item_names, y       ; Write item name to box
    sta.l $7e3280, x
    inx #2 : iny #2
    cpx #$0040
    bne -

    lda $c3                 ; Load player 1
    asl #4 : tax
    ldy #$0000
-
    lda.l rando_player_table, x
    and #$00ff
    phx
    asl : tax               ; Put char table offset in X
    lda char_table-$40, x 
    tyx
    sta.l $7e3314, x
    iny #2
    plx
    inx
    cpy #$0018
    bne -
    rep #$30

.end
    ply : plx
    lda #$0020
    rts

char_table:
    ;  <sp>     !      "      #      $      %      %      '      (      )      *      +      ,      -      .      /
    dw $384E, $38FF, $38FD, $38FE, $38FE, $380A, $38FE, $38FD, $38FE, $38FE, $38FE, $38FE, $38FB, $38FC, $38FA, $38FE
    ;    0      1      2      3      4      5      6      7      8      9      :      ;      <      =      >      ?
    dw $3809, $3800, $3801, $3802, $3803, $3804, $3805, $3806, $3807, $3808, $38FE, $38FE, $38FE, $38FE, $38FE, $38FE
    ;    @      A      B      C      D      E      F      G      H      I      J      K      L      M      N      O 
    dw $38FE, $38E0, $38E1, $38E2, $38E3, $38E4, $38E5, $38E6, $38E7, $38E8, $38E9, $38EA, $38EB, $38EC, $38ED, $38EE
    ;    P      Q      R      S      T      U      V      W      X      Y      Z      [      \      ]      ^      _   
    dw $38EF, $38F0, $38F1, $38F2, $38F3, $38F4, $38F5, $38F6, $38F7, $38F8, $38F9, $38FE, $38FE, $38FE, $38FE, $38FE

org $c58749
base $858749
fix_1c1f:
    LDA $CE     ; if $CE is set, it overrides the message box
    BEQ +
    STA $1C1F
    STZ $CE     ; Clear $CE
+	LDA $1C1F
	CMP #$001D
	BPL +
	RTS
+
	ADC #$027F
	RTS
EmptyBig:
	REP #$30
    LDY #$0000
	JMP $841D
PlaceholderBig:
    REP #$30
    JSR write_placeholders
    LDY #$0000
    JMP $841D

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


; Patch item PLM's
org $CF81CC
	dw $efe0	;Power Bomb (Crateria surface)
org $CF81E8
	dw $efe0	;Missile (outside Wrecked Ship bottom)
org $CF81EE
	dw $efe8	;Missile (outside Wrecked Ship top)
org $CF81F4
	dw $efe0	;Missile (outside Wrecked Ship middle)
org $CF8248
	dw $efe0	;Missile (Crateria moat)
org $CF8264
	dw $efe0	;Energy Tank (Crateria gauntlet)
org $CF83EE
	dw $efe0	;Missile (Crateria bottom)
org $CF8404
	dw $efe4	;Bomb
org $CF8432
	dw $efe0	;Energy Tank (Crateria tunnel to Brinstar)
org $CF8464
	dw $efe0	;Missile (Crateria gauntlet right)
org $CF846A
	dw $efe0	;Missile (Crateria gauntlet left)
org $CF8478
	dw $efe0	;Super Missile (Crateria)
org $CF8486
	dw $efe0	;Missile (Crateria middle)
org $CF84AC
	dw $efe4	;Power Bomb (green Brinstar bottom)
org $CF84E4
	dw $efe4	;Super Missile (pink Brinstar)
org $CF8518
	dw $efe0	;Missile (green Brinstar below super missile)
org $CF851E
	dw $efe0	;Super Missile (green Brinstar top)
org $CF852C
	dw $efe4	;Reserve Tank (Brinstar)
org $CF8532
	dw $efe8	;Missile (green Brinstar behind missile)
org $CF8538
	dw $efe0	;Missile (green Brinstar behind Reserve Tank)
org $CF8608
	dw $efe0	;Missile (pink Brinstar top)
org $CF860E
	dw $efe0	;Missile (pink Brinstar bottom)
org $CF8614
	dw $efe4	;Charge Beam
org $CF865C
	dw $efe0	;Power Bomb (pink Brinstar)
org $CF8676
	dw $efe0	;Missile (green Brinstar pipe)
org $CF86DE
	dw $efe0	;Morphing Ball
org $CF874C
	dw $efe0	;Power Bomb (blue Brinstar)
org $CF8798
	dw $efe0	;Missile (blue Brinstar middle)
org $CF879E
	dw $efe8	;Energy Tank (blue Brinstar)
org $CF87C2
	dw $efe0	;Energy Tank (green Brinstar bottom)
org $CF87D0
	dw $efe0	;Super Missile (green Brinstar bottom)
org $CF87FA
	dw $efe0	;Energy Tank (pink Brinstar bottom)
org $CF8802
	dw $efe4	;Missile (blue Brinstar bottom)
org $CF8824
	dw $efe0	;Energy Tank (pink Brinstar top)
org $CF8836
	dw $efe0	;Missile (blue Brinstar top)
org $CF883C
	dw $efe8	;Missile (blue Brinstar behind missile)
org $CF8876
	dw $efe4	;X-Ray Visor
org $CF88CA
	dw $efe0	;Power Bomb (red Brinstar sidehopper room)
org $CF890E
	dw $efe4	;Power Bomb (red Brinstar spike room)
org $CF8914
	dw $efe0	;Missile (red Brinstar spike room)
org $CF896E
	dw $efe4	;Spazer
org $CF899C
	dw $efe8	;Energy Tank (Kraid)
org $CF89EC
	dw $efe8	;Missile (Kraid)
org $CF8ACA
	dw $efe4	;Varia Suit
org $CF8AE4
	dw $efe8	;Missile (lava room)
org $CF8B24
	dw $efe4	;Ice Beam
org $CF8B46
	dw $efe8	;Missile (below Ice Beam)
org $CF8BA4
	dw $efe0	;Energy Tank (Crocomire)
org $CF8BAC
	dw $efe4	;Hi-Jump Boots
org $CF8BC0
	dw $efe0	;Missile (above Crocomire)
org $CF8BE6
	dw $efe0	;Missile (Hi-Jump Boots)
org $CF8BEC
	dw $efe0	;Energy Tank (Hi-Jump Boots)
org $CF8C04
	dw $efe0	;Power Bomb (Crocomire)
org $CF8C14
	dw $efe0	;Missile (below Crocomire)
org $CF8C2A
	dw $efe0	;Missile (Grapple Beam)
org $CF8C36
	dw $efe4	;Grapple Beam
org $CF8C3E
	dw $efe4	;Reserve Tank (Norfair)
org $CF8C44
	dw $efe8	;Missile (Norfair Reserve Tank)
org $CF8C52
	dw $efe0	;Missile (bubble Norfair green door)
org $CF8C66
	dw $efe0	;Missile (bubble Norfair)
org $CF8C74
	dw $efe8	;Missile (Speed Booster)
org $CF8C82
	dw $efe4	;Speed Booster
org $CF8CBC
	dw $efe0	;Missile (Wave Beam)
org $CF8CCA
	dw $efe4	;Wave Beam
org $CF8E6E
	dw $efe0	;Missile (Gold Torizo)
org $CF8E74
	dw $efe8	;Super Missile (Gold Torizo)
org $CF8F30
	dw $efe0	;Missile (Mickey Mouse room)
org $CF8FCA
	dw $efe0	;Missile (lower Norfair above fire flea room)
org $CF8FD2
	dw $efe0	;Power Bomb (lower Norfair above fire flea room)
org $CF90C0
	dw $efe0	;Power Bomb (above Ridley)
org $CF9100
	dw $efe0	;Missile (lower Norfair near Wave Beam)
org $CF9108
	dw $efe8	;Energy Tank (Ridley)
org $CF9110
	dw $efe4	;Screw Attack
org $CF9184
	dw $efe0	;Energy Tank (lower Norfair fire flea room)
org $CFC265
	dw $efe0	;Missile (Wrecked Ship middle)
org $CFC2E9
	dw $efe4	;Reserve Tank (Wrecked Ship)
org $CFC2EF
	dw $efe0	;Missile (Gravity Suit)
org $CFC319
	dw $efe0	;Missile (Wrecked Ship top)
org $CFC337
	dw $efe0	;Energy Tank (Wrecked Ship)
org $CFC357
	dw $efe0	;Super Missile (Wrecked Ship left)
org $CFC365
	dw $efe0	;Super Missile (Wrecked Ship right)
org $CFC36D
	dw $efe4	;Gravity Suit
org $CFC437
	dw $efe0	;Missile (green Maridia shinespark)
org $CFC43D
	dw $efe0	;Super Missile (green Maridia)
org $CFC47D
	dw $efe0	;Energy Tank (green Maridia)
org $CFC483
	dw $efe8	;Missile (green Maridia tatori)
org $CFC4AF
	dw $efe0	;Super Missile (yellow Maridia)
org $CFC4B5
	dw $efe0	;Missile (yellow Maridia super missile)
org $CFC533
	dw $efe0	;Missile (yellow Maridia false wall)
org $CFC559
	dw $efe4	;Plasma Beam
org $CFC5DD
	dw $efe0	;Missile (left Maridia sand pit room)
org $CFC5E3
	dw $efe4	;Reserve Tank (Maridia)
org $CFC5EB
	dw $efe0	;Missile (right Maridia sand pit room)
org $CFC5F1
	dw $efe0	;Power Bomb (right Maridia sand pit room)
org $CFC603
	dw $efe0	;Missile (pink Maridia)
org $CFC609
	dw $efe0	;Super Missile (pink Maridia)
org $CFC6E5
	dw $efe4	;Spring Ball
org $CFC74D
	dw $efe8	;Missile (Draygon)
org $CFC755
	dw $efe0	;Energy Tank (Botwoon)
org $CFC7A7
	dw $efe4	;Space Jump
