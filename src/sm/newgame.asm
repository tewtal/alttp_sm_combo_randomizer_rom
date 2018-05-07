; This skips the intro
org $c2eeda
    db $1f

; Hijack init routine to autosave and set door flags
org $c28067
    jsl introskip_doorflags

org $c0fd00
base $80fd00
introskip_doorflags:
    ; Do some checks to see that we're actually starting a new game
    
    ; Make sure game mode is 1f
    lda $7e0998
    cmp.w #$001f
    bne .ret
    
    ; Check if samus saved energy is 00, if it is, run startup code
    lda $7ed7e2
    bne .ret
    
    ; Set construction zone and red tower elevator doors to blue
    lda $7ed8b6
    ora.w #$0004
    sta $7ed8b6    
    lda $7ed8b2
    ora.w #$0001
    sta $7ed8b2

    ; Unlock crateria map station door
    lda $7ed8b0
    ora.w #$0020
    sta $7ed8b0

    ; Unlock norfair map station door
    lda $7ed8b8
    ora.w #$1000
    sta $7ed8b8

    ; Set up open mode event bit flags
    lda #$0001
    sta $7ed820
    
    ; Call the save code to create a new file
    lda $7e0952
    jsl $818000

    lda #$0000
    sta.l !SRAM_SM_COMPLETED
    sta.l !SRAM_ALTTP_EQUIPMENT_1
    sta.l !SRAM_ALTTP_EQUIPMENT_2
    sta.l !SRAM_ALTTP_COMPLETED
    sta.l !SRAM_ALTTP_RANDOMIZER_SAVED
    
    jsl alttp_new_game  ; Setup new game for ALTTP
    jsl sm_copy_alttp_items ; Copy alttp items into temporary SRAM buffer
    jsl zelda_fix_checksum  ; Fix alttp checksum

.ret:   
    lda #$0000
    rtl