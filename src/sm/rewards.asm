; $A7:C831 9F 28 D8 7E STA $7ED828,x[$7E:D828]    ; Set Kraid as dead
; $A7:DB85 9F 28 D8 7E STA $7ED828,x[$7E:D82B]    ; Set Phantoon as dead
; $A5:92DE 9F 28 D8 7E STA $7ED828,x[$7E:D82C]    ; Set Draygon as dead
; $A6:C5E2 22 A6 81 80 JSL $8081A6[$80:81A6]      ; Set Ridley as dead

; Hook Kraid death
org $e7c831
    jsl boss_death_kraid
org $e7db85
    jsl boss_death_phantoon
org $e592de
    jsl boss_death_draygon
org $e6c5e2
    jsl boss_death_ridley

org $cfa68f
    dw $91d6    ; Disable G4 Statue Animations
                ; G4 opening is only triggered by the new event flags
                

org $d9f000
base $99f000
boss_death_kraid:
    sta $7ed828,x   ; Store actual boss kill flag
    lda #$0000
    jsr boss_death_reward
    rtl

boss_death_phantoon:
    sta $7ed828,x   ; Store actual boss kill flag
    lda #$0008
    jsr boss_death_reward
    rtl

boss_death_draygon:
    sta $7ed828,x   ; Store actual boss kill flag
    lda #$0010
    jsr boss_death_reward
    rtl

boss_death_ridley:
    jsl $8081a6    ; Store actual boss kill flag
    lda #$0018
    jsr boss_death_reward
    rtl


boss_death_reward:
    phx : php : tax

    ; Load boss reward type from table
    %a8()
    lda.l boss_rewards, x
    sta $c7
    beq .pendant
    cmp #$20
    beq .crystal
    bra .smboss

    .pendant
        lda.l boss_rewards+$2, x
        sta $c9
        ora.l !SRAM_ALTTP_ITEM_BUF+$74
        sta.l !SRAM_ALTTP_ITEM_BUF+$74        
        bra .exit
    .crystal
        lda.l boss_rewards+$2, x
        sta $c9
        ora.l !SRAM_ALTTP_ITEM_BUF+$7A
        sta.l !SRAM_ALTTP_ITEM_BUF+$7A
        bra .exit
    .smboss
        ; Save to special event bits for boss tokens (not the actual boss kill flags that opens doors)
        ; Although in a future update adding the option of this also setting those flags should be a possibility
        lda.l boss_rewards+$2, x
        sta $c9
        ora.l $7ed832
        sta.l $7ed832
        bra .exit

    .exit

    %ai16()

    ; Show message box
    lda #$0063
    jsl $858080

    plp : plx
    rts
