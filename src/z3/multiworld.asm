; ALTTP Multiworld support
;

org $f81000

; Lookup item in ALTTP table and replace as needed, return as 8-bit A
alttp_multiworld_replace_item:
    lsr !MULTIWORLD_SWAP : bcs .end      ; If !MULTIWORLD_SWAP is set, skip one item swap
    phx : phy : php         ; and the item is already replaced
    %ai16()
    and #$00ff              ; Mask off any extra high bits left in A

    asl #3 : tax
    lda.l alttp_rando_item_table, x ; Load multiworld item type
    sta !MULTIWORLD_PICKUP          ; Make sure we always set this flag so it's updated depending on item type
    beq .ownItem

    dec a
    sta !MULTIWORLD_DIALOG
    lda.l alttp_rando_item_table+$4, x
    sta.l !MULTIWORLD_PLAYER        ; Store multiworld owner    

.ownItem
    lda.l alttp_rando_item_table+$2, x
    plp : ply : plx
.end
    rtl

alttp_mw_handle_queue:
    jsl $078000              ; JSL Player_Main (do stoops lonk things)
    pha : phx : phy : php
    %ai16()

    lda.l !SRAM_MW_RPTR      ; Don't loop in ALTTP because we have to wait for item pickup to actually start
    cmp.l !SRAM_MW_WPTR
    beq .end

    lda !MULTIWORLD_PICKUP
    bne .end                 ; If a pickup is happening, don't queue another yet
    lda $02DA
    bne .end                 ; Don't queue pickups if link is already holding an item

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

.end
    plp : ply : plx : pla
    rtl

alttp_mw_receive_item:
    ; Item in $7c, World in $7e
    lda $7e
    sta !MULTIWORLD_PLAYER
    lda #$0002
    sta !MULTIWORLD_PICKUP  ; 1 = pickup multiworld for other player, 2 = get multiworld item from other player
    lda #$0001
    sta !MULTIWORLD_DIALOG  ; dialog 1 = we got item from other player
    %ai8()
    ldy $7c
    inc !MULTIWORLD_SWAP    ; setting this flag to 1 will prevent the next item substitution
    jsl Link_ReceiveItem    ; Get item in $7c
    %ai16()
    rts

alttp_mw_send_item:
    phx : phy : php
    ; Item in A
    %ai16()
    and #$00ff
    tax
    ldy !MULTIWORLD_PLAYER
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
    and #$00ff
    asl #5
    tax
    
    ldy #$0000
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

    lda !MULTIWORLD_PLAYER     ; Multiworld player id
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

    stz !MULTIWORLD_PICKUP
    stz !MULTIWORLD_DIALOG
    stz !MULTIWORLD_PLAYER
    tyx
    jml $0eef1c     ; Return back to original code


alttp_mw_dialogtable:
    ; Dialog boxes are 14 characters wide
    ;   0123456789ABCD
.give
    db "  YOU FOUND   "
    db " AN ITEM FOR  "
    db "0123" ; Padding

.get
    db " YOU RECEIVED "
    db " AN ITEM FROM "
    db "0123" ; Padding

alttp_dialog_char_table:
    db $FF, $C7, $D8, $FF, $FF, $FF, $FF, $D8, $FF, $FF, $FF, $FF, $C8, $C9, $CD, $00
    db $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $FF, $FF, $E2, $DF, $E3, $C6
    db $FF, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8
    db $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $FF, $FF, $E0, $FF
    