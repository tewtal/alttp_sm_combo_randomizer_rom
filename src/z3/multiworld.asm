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

    lda.l !SRAM_MW_RPTR      ; Don't loop in ALTTP because we have to wait for item pickup to actually start
    cmp.l !SRAM_MW_WPTR
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

    lda.l !SRAM_MW_RPTR
    asl #2 : tax
    lda.l !SRAM_MW_RECVQ, x : sta $7e
    lda.l !SRAM_MW_RECVQ+$2, x : sta $7c
    jsr alttp_mw_receive_item

    lda.l !SRAM_MW_RPTR
    inc a
    cmp #$0010
    bne +
    lda.l #$0000
+
    sta.l !SRAM_MW_RPTR
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
    lda !MULTIWORLD_PICKUP
    cmp #$01
    beq .end
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
    lda #$1001
    jsl write_message
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
    adc #$0015
+

    asl #4 : tax
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
    cpy #$001E
    bne -    

    lda $1cf0
    and #$00ff
    asl #5
    clc
    adc #$000E
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
    cpy #$0038
    bne -

    lda #$ff00
    tyx
    sta.l $7f1200, x
    iny #2

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
    cpy #$0052
    bne -

    stz !MULTIWORLD_DIALOG
    stz !MULTIWORLD_DIALOG_ITEM
    stz !MULTIWORLD_DIALOG_PLAYER

    tyx
    jml $0eef1c     ; Return back to original code


alttp_mw_dialogtable:
    ; Dialog boxes are 14 characters wide
    ;   0123456789ABCD
.give
    db "              "
    db "  FOUND FOR   "
    db "0123" ; Padding

.get
    db "              "
    db "RECEIVED FROM "
    db "0123" ; Padding

alttp_mw_item_names:
    db "GRAPPLING BEAM__"             ; 00 (b0) (sm items)
    db " X-RAY SCOPE  __"
    db "  VARIA SUIT  __"
    db " SPRING BALL  __"
    db "MORPHING BALL __"
    db " SCREW ATTACK __"
    db " GRAVITY SUIT __"
    db "HI-JUMP BOOTS __"
    db "  SPACE JUMP  __"
    db "    BOMBS     __"
    db "SPEED BOOSTER __"
    db " CHARGE BEAM  __"
    db "   ICE BEAM   __"
    db "   WAVE BEAM  __"
    db " S P A Z E R  __"
    db " PLASMA BEAM  __"  
    db " ENERGY TANK  __"
    db " RESERVE TANK __"
    db "   MISSILES   __"
    db "SUPER MISSILES__"
    db " POWER BOMBS  __"

    db "              __"       ; $15+ (alttp items)
    db " MASTER SWORD __"
    db "TEMPERED SWORD__"
    db "  GOLD SWORD  __"
    db "    SHIELD    __"
    db "  RED SHIELD  __"
    db "MIRROR SHIELD __"
    db "   FIRE ROD   __"
    db "    ICE ROD   __"
    db "    HAMMER    __"
    db "   HOOKSHOT   __"
    db "      BOW     __"
    db "BLUE BOOMERANG__"
    db " MAGIC POWDER __"
    db "              __"
    db "    BOMBOS    __"
    db "     ETHER    __"
    db "     QUAKE    __"
    db "     LAMP     __"
    db "    SHOVEL    __"
    db "     FLUTE    __"
    db "    SOMARIA   __"
    db "    BOTTLE    __"
    db "PIECE OF HEART__"
    db "CANE OF BYRNA __"
    db "  MAGIC CAPE  __"
    db "    MIRROR    __"
    db "  POWER GLOVE __"
    db " TITAN'S MITT __"
    db "BOOK OF MUDORA__"
    db "ZORAS FLIPPERS__"
    db "  MOON PEARL  __"
    db "              __"
    db "    BUG NET   __"
    db "   BLUE MAIL  __"
    db "    RED MAIL  __"
    db "              __"
    db "              __"
    db "  FULL HEART  __"
    db "   ONE BOMB   __"
    db "  THREE BOMBS __"
    db "   MUSHROOM   __"
    db "RED BOOMERANG __"
    db "  RED POTION  __"
    db " GREEN POTION __"
    db " BLUE POTION  __"
    db "              __"
    db "              __"
    db "              __"
    db "  TEN BOMBS   __"
    db "              __"
    db "              __"
    db "   ONE RUPEE  __"
    db "  FIVE RUPEES __"
    db "TWENTY RUPEES __"
    db "              __"
    db "              __"
    db "              __"
    db "      BOW     __"
    db " SILVER ARROW __"
    db "      BEE     __"
    db "     FAIRY    __"
    db "  FULL HEART  __"
    db "  FULL HEART  __"
    db "HUNDRED RUPEES__"
    db " FIFTY RUPEES __"
    db "              __"
    db " SINGLE ARROW __"
    db "  TEN ARROWS  __"
    db "              __"
    db "  300 RUPEES  __"
    db "TWENTY RUPEES __"
    db "   GOOD BEE   __"
    db "FIGHTERS SWORD__"
    db "              __"
    db "PEGASUS BOOTS __"
    db "              __"
    db "              __"
    db "  HALF MAGIC  __"
    db "QUARTER MAGIC __"
    db " MASTER SWORD __"
    db "  5 BOMB CAP  __"
    db " 10 BOMB CAP  __"
    db "  5 ARROW CAP __"
    db " 10 ARROW CAP __"
    db "              __"
    db "              __"
    db "              __"
    db " SILVER ARROW __"   ; 58
    db "              __"
    db "              __"
    db "              __"
    db "              __"
    db "              __"
    db "SWORD UPGRADE __"
    db "SHIELD UPGRADE__"
    db "ARMOUR UPGRADE__"
    db "GLOVE UPGRADE __"


alttp_dialog_char_table:
    db $FF, $C7, $D8, $FF, $FF, $FF, $FF, $D8, $FF, $FF, $FF, $FF, $C8, $C9, $CD, $00
    db $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $FF, $FF, $E2, $DF, $E3, $C6
    db $FF, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8
    db $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $FF, $FF, $E0, $FF


alttp_mw_check_softreset:
    lda $4219 : sta $01
    cmp #$30
    bne .end
    lda $00
    cmp #$30
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