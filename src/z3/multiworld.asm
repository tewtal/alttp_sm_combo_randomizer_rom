; ALTTP Multiworld support
;

org $f81000

; Lookup item in ALTTP table and replace as needed, return as 8-bit A
alttp_multiworld_replace_item:
    lsr !MULTIWORLD_SWAP : bcs .exit      ; If !MULTIWORLD_SWAP is set, skip one item swap
    CMP.b #$20 : BEQ .exit                ; Crystal
	CMP.b #$26 : BEQ .exit                ; Piece of heart completion heart
	CMP.b #$2E : BEQ .exit                ; red refill
	CMP.b #$2F : BEQ .exit                ; green refill
	CMP.b #$30 : BEQ .exit                ; Blue refill
    CMP.b #$32 : BEQ .exit                ; Big key (guard)
	CMP.b #$37 : BEQ .exit                ; Pendant
	CMP.b #$38 : BEQ .exit                ; Pendant
	CMP.b #$39 : BEQ .exit                ; Pendant
    bra .next
.exit
    jmp .end
.next
    phx : phy : php
    %ai16()
    tax

    lda $10
    and #$00ff
    cmp #$0007      ; Only check for shops in dungeon mode
    bne .noShop      

    lda $A0        
    cmp #$00FF : BEQ .paradoxShop
    cmp #$011C : BEQ .bombShop              ; Bomb shop
    cmp #$010F : BEQ .shop
    cmp #$011F : BEQ .shop
    cmp #$0110 : BEQ .shop
    cmp #$0112 : BEQ .shop
    cmp #$0100 : BEQ .shop              ; LW Chest game 1
    cmp #$0118 : BEQ .shop              ; LW Chest game 2
    bra .noShop
.paradoxShop
    lda $A8
    cmp #$0014 : BEQ .shop
    bra .noShop
.bombShop
    lda $A9
    cmp #$0200 : beq .shop
    bra .noShop
.shop
    txa : bra .noReplace
.noShop
    txa
    and #$00ff                          ; Mask off any extra high bits left in A
    asl #3 : tax
    ora #$8000                          ; Set high bit in item index for ALTTP to not clash with SM indexes
    sta !MULTIWORLD_GIVE_INDEX          ; Save the multiworld table index for later
    lda.l alttp_rando_item_table, x     ; Load multiworld item type
    sta !MULTIWORLD_PICKUP              ; Make sure we always set this flag so it's updated depending on item type
    beq .ownItem

    sta !MULTIWORLD_DIALOG
    lda.l alttp_rando_item_table+$4, x
    sta !MULTIWORLD_GIVE_PLAYER        ; Store multiworld owner
    sta !MULTIWORLD_DIALOG_PLAYER    
.ownItem
    lda.l alttp_rando_item_table+$2, x
    sta !MULTIWORLD_GIVE_ITEM
    sta !MULTIWORLD_DIALOG_ITEM
.noReplace
    plp : ply : plx
.end
    stz !MULTIWORLD_SWAP
    rtl

alttp_multiworld_replace_graphics:
    lsr !MULTIWORLD_SWAP : bcs .end     ; If !MULTIWORLD_SWAP is set, skip one item swap
    CMP.b #$20 : BEQ .end                ; Crystal
	CMP.b #$26 : BEQ .end                ; Piece of heart completion heart
	CMP.b #$2E : BEQ .end                ; red refill
	CMP.b #$2F : BEQ .end                ; green refill
	CMP.b #$30 : BEQ .end                ; Blue refill
    CMP.b #$32 : BEQ .end                ; Big key (guard)
	CMP.b #$37 : BEQ .end                ; Pendant
	CMP.b #$38 : BEQ .end                ; Pendant
	CMP.b #$39 : BEQ .end                ; Pendant

    phx : phy : php
    %ai16()
    and #$00ff              ; Mask off any extra high bits left in A
    asl #3 : tax
    lda.l alttp_rando_item_table+$2, x
    plp : ply : plx

.end
    stz !MULTIWORLD_SWAP
    rtl

alttp_mw_handle_queue:
    pha : phx : phy : php
    %ai16()
    
    lda config_multiworld
    bne +
    jmp .end
+

;    lda.l !SRAM_MW_RPTR      ; Don't loop in ALTTP because we have to wait for item pickup to actually start
;    cmp.l !SRAM_MW_WPTR
    lda.l !SRAM_MW_ITEMS_RECV_RPTR
    cmp.l !SRAM_MW_ITEMS_RECV_WPTR    
    beq .end

    %a8()
    lda.l !MULTIWORLD_PICKUP
    bne .cantGive                 ; If a pickup is happening, don't queue another yet
    lda $02E4
    bne .cantGive                 ; Don't queue pickups if link is not allowed to move
    lda $03EF
    bne .cantGive                 ; Don't queue pickups when link is forced into "sword up"

    lda $5d                       ; Check links state
    cmp #$00                      ; Only allow ground state, swimming, dashing and bunny states
    beq .next
    cmp #$04
    beq .next
    cmp #$11
    beq .next
    cmp #$17
    beq .next
    bra .cantGive

.next

    lda $10                       ; Only get items if we're still in dungeon or overworld mode
    cmp #$07
    beq .continue
    cmp #$09
    beq .continue
    bra .cantGive

.continue                         ; Always induce a 10 frame waiting period of "normal gameplay"
    lda $11
    bne .cantGive                 ; Make sure submodule is 0
    lda !MULTIWORLD_DELAY
    beq .cantGive
    dec : sta !MULTIWORLD_DELAY
    cmp #$00
    beq +
    bra .end
+
    %a16()

;    lda.l !SRAM_MW_RPTR
    lda.l !SRAM_MW_ITEMS_RECV_RPTR
    asl #2 : tax
;    lda.l !SRAM_MW_RECVQ, x : sta $7e
;    lda.l !SRAM_MW_RECVQ+$2, x : sta $7c
    lda.l !SRAM_MW_ITEMS_RECV, x : sta $7e
    lda.l !SRAM_MW_ITEMS_RECV+$2, x : sta $7c
    jsr alttp_mw_receive_item

    lda.l !SRAM_MW_ITEMS_RECV_RPTR
    inc a
    sta.l !SRAM_MW_ITEMS_RECV_RPTR
    bra .end

.cantGive
    lda #$0A
    sta !MULTIWORLD_DELAY   ; Wait 10 frames before trying to give item again
.end
    plp : ply : plx : pla
    jsl $078000              ; JSL Player_Main (do stoops lonk things)
    rtl

alttp_mw_no_rupees:
    pha
    lda config_multiworld
    beq +
    lda !MULTIWORLD_PICKUP
    cmp #$01
    beq .end
+
    pla
    jsl GiveRupeeGift
    rtl
.end 
    pla
    rtl

alttp_mw_receive_item:
    ; Item in $7c, World in $7e
    lda $7e
    sta.l !MULTIWORLD_DIALOG_PLAYER
    lda #$0002
    sta.l !MULTIWORLD_PICKUP  ; 1 = pickup multiworld for other player, 2 = get multiworld item from other player
    sta.l !MULTIWORLD_DIALOG  ; dialog 2 = we got item from other player
    %ai8()
    lda #$01
    sta.l !MULTIWORLD_SWAP
    ldy $7c
    sty !MULTIWORLD_DIALOG_ITEM
    jsl Link_ReceiveItem    ; Get item in $7c
    %ai16()
    rts

alttp_mw_send_item:
    phx : phy : php
    ; Item in A
    %ai16()
    lda.l !MULTIWORLD_GIVE_ITEM        ; This gets set by the replacement routine
    and #$00ff                         ; so that progressive items will send the progressive id correctly
    tax
    lda.l !MULTIWORLD_GIVE_PLAYER
    tay
    lda.l !MULTIWORLD_GIVE_INDEX
    jsl mw_write_message
    plp : ply : plx
    rtl

alttp_multiworld_dialog:
    lda $1cf0
    bmi .multiworldDialog
    ; If not multiworld dialog, return
    asl : tax
    jml $0eee8d

.multiworldDialog

    ; Item Name
    lda !MULTIWORLD_DIALOG_ITEM
    and #$00ff
    cmp #$00b0
    bcc .alttpItem
    sec
    sbc #$00b0
    bra +
.alttpItem
    clc
    adc #$0030
+

    %a8()
    sta $211b : xba : sta $211b
    lda #$13
    sta $211c
    %ai16()

    ldx $2134
    ldy #$0000
-    
    phx
    lda.l alttp_mw_item_names, x
    and #$00ff
    tax
    lda.l alttp_dialog_char_table-$20, x
    and #$00ff
    xba
    tyx
    sta.l $7f1200, x
    iny #2
    plx
    inx
    cpy #$0026
    bne -    

    lda $1cf0
    and #$00ff
    cmp #$0000
    beq +
    clc
    adc #$0012
+
    tax

-
    phx
    lda.l alttp_mw_dialogtable, x
    and #$00ff
    tax
    lda.l alttp_dialog_char_table-$20, x
    and #$00ff
    xba
    tyx
    sta.l $7f1200, x
    iny #2
    plx
    inx
    cpy #$004C
    bne -

    lda #$ff00
    tyx
    sta.l $7f1200, x
    sta.l $7f1200+$2, x
    sta.l $7f1200+$4, x
    tya : clc : adc #$0006 : tay

    lda !MULTIWORLD_DIALOG_PLAYER
    and #$00ff
    asl #4 : tax
-    
    phx
    lda.l rando_player_table, x
    and #$00ff
    tax
    lda.l alttp_dialog_char_table-$20, x
    and #$00ff
    xba
    tyx
    sta.l $7f1200, x
    iny #2
    plx
    inx
    cpy #$006A
    bne -

    tyx
    lda #$FF00
    sta.l $7f1200, x
    sta.l $7f1200+$2, x
    sta.l $7f1200+$4, x
    sta.l $7f1200+$6, x
    tya : clc : adc #$0008 : tay

    stz !MULTIWORLD_DIALOG
    stz !MULTIWORLD_DIALOG_ITEM
    stz !MULTIWORLD_DIALOG_PLAYER

    tyx
    jml $0eef1c     ; Return back to original code


alttp_mw_dialogtable:
    ; Dialog boxes are 19 characters wide
    ;   0123456789ABCDEF012
.give
    db " found for player  "
.get
    db "   received from   "

alttp_mw_item_names:
    db "   Grappling Beam  "             ; 00 (b0) (sm items)
    db "    X-Ray Scope    "
    db "     Varia Suit    "
    db "    Spring Ball    "
    db "   Morphing Ball   "
    db "    Screw Attack   "
    db "    Gravity Suit   "
    db "   Hi-Jump Boots   "
    db "     Space Jump    "
    db "        Bomb       "
    db "   Speed Booster   "
    db "    Charge Beam    "
    db "      Ice Beam     "
    db "      Wave Beam    "
    db " ~~ S P a z E R ~~ "
    db "    Plasma Beam    "  
    db "    Energy Tank    "
    db "    Reserve Tank   "
    db "      Missiles     "
    db "   Super Missiles  "
    db "    Power Bombs    "

    db "                   "  ;15
    db "                   "  ;16
    db "                   "  ;17
    db "                   "  ;18
    db "                   "  ;19
    db "                   "  ;1A
    db "                   "  ;1B
    db "                   "  ;1C
    db "                   "  ;1D
    db "                   "  ;1E
    db "                   "  ;1F
 
    db " Crateria L 1 Card " ; 20
    db " Crateria L 2 Card " ; 21
    db " Crateria Boss Card" ; 22
    db " Brinstar L 1 Card " ; 20
    db " Brinstar L 2 Card " ; 21
    db " Brinstar Boss Card" ; 22
    db " Norfair L 1 Card  " ; 20
    db " Norfair L 2 Card  " ; 21
    db " Norfair Boss Card " ; 22
    db " Maridia L 1 Card  " ; 20
    db " Maridia L 2 Card  " ; 21
    db " Maridia Boss Card " ; 22
    db "  W.Ship L 1 Card  " ; 2C
    db "  W.Ship Boss Card " ; 2D
    db "L.Norfair L 1 Card " ; 2E
    db "L.Norfair Boss Card" ; 2F

    db "                   "       ; $30+ (alttp items)
    db "    Master Sword   "
    db "   Tempered Sword  "
    db "     Gold Sword    "
    db "     Toy Shield    "
    db "     Red Shield    "
    db "   Mirror Shield   "
    db "      Fire Rod     "
    db "       Ice Rod     "
    db "       Hammer      "
    db "  Hookshot, BOING! "
    db "        Bow        "
    db "   Blue Boomerang  "
    db "    Magic Powder   "
    db "                   "
    db "       Bombos      "
    db "       Ether       "
    db "       Quake       "
    db "       Lamp        "
    db "       Shovel      "
    db "       Flute       "
    db "  Cane of Somaria  "
    db "       Bottle      "
    db "   Piece of Heart  "
    db "   Cane of Byrna   "
    db "     Magic Cape    "
    db "    Magic Mirror   "
    db "     Power Glove   "
    db "    Titan's Mitt   "
    db "   Book of Mudora  "
    db "  Zora's Flippers  "
    db "     Moon Pearl    "
    db "                   "
    db "      Bug Net      "
    db "     Blue Mail     "
    db "      Red Mail     "
    db "                   "
    db "                   "
    db "  Heart Container  "
    db "      One Bomb     "
    db "     Three Bombs   "
    db "      Mushroom     "
    db "   Red Boomerang   "
    db "     Red Potion    "
    db "    Green Potion   "
    db "     Blue Potion   "
    db "                   "
    db "                   "
    db "                   "
    db "     Ten Bombs     "
    db "                   "
    db "                   "
    db "   A single Rupee  "
    db "     Five Rupees   "
    db "   Twenty Rupees   "
    db "                   "
    db "                   "
    db "                   "
    db "        Bow        "
    db "   Silver Arrows   "
    db "        Bee        "
    db "       Fairy       "
    db "  Heart Container  "
    db "  Heart Container  "
    db "One Hundred Rupees "
    db "    Fifty Rupees   "
    db "                   "
    db "   A single Arrow  "
    db "     Ten Arrows    "
    db "                   "
    db "     300 Rupees    "
    db "   Twenty Rupees   "
    db "    A good Bee     "
    db "  Fighter's Sword  "
    db "                   "
    db "   Pegasus Boots   "
    db "                   "
    db "                   "
    db "     Half Magic    "
    db "   Quarter Magic   "
    db "    Master Sword   "
    db "  5 Bomb Capacity  "
    db "  10 Bomb Capacity "
    db " 5 Arrow Capacity  "
    db " 10 Arrow Capactiy "
    db "                   "
    db "                   "
    db "                   "
    db "   Silver Arrows   "   ; 58
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "   Sword Upgrade   "
    db "   Shield Upgrade  "
    
    db "   Armour Upgrade  "
    db "   Glove Upgrade   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "
    db "                   "  ; 6F

    db "                   "  ; 70
    db "                   "
    db " Ganon's Tower Map "
    db "  Turtle Rock Map  "
    db " Thieves' Town Map "
    db " Tower of Hera Map "
    db "  Ice Palace Map   "
    db "  Skull Woods Map  "
    db "  Misery Mire Map  "
    db "  Dark Palace Map  "
    db "  Swamp Palace Map "
    db "                   "
    db " Desert Palace Map "
    db " Eastern Palace Map"
    db "                   "
    db " Hyrule Castle Map "  ; 7F

    db "                   "  ; 80
    db "                   "
    db "  G. Tower Compass "
    db "Turtle Rock Compass"
    db "   T. Town Compass "
    db "    Hera Compass   "
    db "Ice Palace Compass "
    db "Skull Woods Compass"
    db "Misery Mire Compass"
    db "Dark Palace Compass"
    db "  Swamp P. Compass "
    db "                   "
    db " Desert P. Compass "
    db "Eastern P. Compass "
    db "                   "
    db "                   "  ; 8F

    db "                   "  ; 90
    db "                   "
    db " Ganon's Tower B.K "
    db "  Turtle Rock B.K  "
    db " Thieves' Town B.K "
    db " Tower of Hera B.K "
    db "  Ice Palace B.K   "
    db "  Skull Woods B.K  "
    db "  Misery Mire B.K  "
    db "  Dark Palace B.K  "
    db "  Swamp Palace B.K "
    db "                   "
    db " Desert Palace B.K "
    db " Eastern Palace B.K"
    db "                   "
    db "                   "  ; 9F

    db " Hyrule Castle Key " ; A0
    db "    Sewers Key     "
    db " Eastern Palace Key"
    db " Desert Palace Key "
    db " Castle Tower Key  "
    db " Swamp Palace Key  "
    db "  Dark Palace Key  "
    db "  Misery Mire Key  "
    db "  Skull Woods Key  "
    db "  Ice Palace Key   "
    db " Tower of Hera Key "
    db " Thieves' Town Key "
    db "  Turtle Rock Key  "
    db " Ganon's Tower Key "
    db "                   "
    db "                   " ; AF   
 

alttp_dialog_char_table:
    db $FF, $C7, $D8, $FF, $FF, $FF, $FF, $D8, $FF, $FF, $FF, $FF, $C8, $C9, $CD, $00
    db $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $FF, $FF, $E2, $DF, $E3, $C6
    db $FF, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8
    db $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $FF, $FF, $E0, $FF

; lowercase, might change    
    db $FF, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E
    db $3F, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $CE, $4E

alttp_mw_check_softreset:
    lda $4219 : sta $01
    cmp #$30
    bne .end
    lda $00
    cmp #$30
    bne .end
    lda.l !SRAM_SAVING
    bne .end
    jmp alttp_mw_softreset

.end
    rtl

alttp_mw_softreset:
    sei                         ; Disable IRQ's
    
    %i16()
    %a8()

    lda #$01
    sta $420d                   ; Toggle FastROM on

    lda #$00
    sta $4200                   ; Disable NMI and Joypad autoread
    sta $420c                   ; Disable H-DMA

    lda #$8f
    sta $2100                   ; Enable PPU force blank

    jsl sm_spc_reset            ; Kill the ALTTP music engine and put the SPC in IPL upload mode
                                ; Gotta do this before switching RAM contents

-
    bit $4212                   ; Wait for a fresh NMI
    bmi -

-
    bit $4212
    bpl -

    %ai16()

    ldx #$1ff0
    txs                         ; Adjust stack pointer

    lda #$ffff                  ; Set the "game flag" to SM so IRQ's/NMI runs using the 
    sta !SRAM_CURRENT_GAME      ; correct game

    jsl sm_fix_checksum         ; Fix SRAM checksum (otherwise SM deletes the file on load)

    jml $80841C                 ; Jump to SM boot code