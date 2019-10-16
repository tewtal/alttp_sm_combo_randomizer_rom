; --- new control code routine ---

; This sets up for screw attack without space jump.
; First off, we need a new control code that checks for space jump, so that we
; can gate the animation appropriately.

org $D08688
base $908688
control_code_routine:
    LDA config_screwattack  
    BEQ .config_disabled    ; If config_screwattack is 0, use the vanilla screw attack code
    
    LDA $09A2       ; get item equipped info
    BIT #$0200      ; check for space jump equipped
    BNE .space_jump ; if space jump, branch to space jump stuff
    LDA $0A96       ; get the pose number
    CLC             ; prepare to do math
    ADC #$001B      ; skip past the old screw attack to the new stuff
    BRA .exit       ; then exit after doing some important things after branching

.config_disabled
    LDA $09A2       ; This code is here just to make sure both implementations 
    BIT #$0200      ; uses the same amount of clock cycles for pose selection
    BNE .space_jump
    NOP : XBA       

.space_jump:
    LDA $0A96       ; get the pose number
    INC A           ; just go to the next pose

.exit:
    STA $0A96       ; store the new pose in the correct spot
    TAY             ; transfer to Y because reasons
    SEC             ; flag the carry bit because reasons
    RTS


; Hook the subroutine to control code $F5

org $D0832E
    dw control_code_routine


; We want the $F5 code to run right after the $FB code. The $F5 code adds 1/27
; for space jump equipped/unequiped, but we technically want to add 0/26. This
; is solved by by having $FB add one less, and, with neither waste nor want, by
; sliding in a JMP so that return and result turns out correct.
;org $908482
;   ADC #$0015
;   STA $0A96
;   TAY
;   SEC
;   RTS

org $D08482
base $908482
    ADC #$0014
    STA $0A96
    JMP control_code_routine


; --- implement spin attack ---

; The control codes now need to be integrated with the screw attack and
; walljump animation sequences. We need space from bank $91. Screw attack is
; relocated into $91:812D-816E. Since much of the code is duplicated, we just
; need to move some JSR pointers.

org $D18014+(11*2)
    dw $8066, $8066, $8066, $8189, $8086, $8066, $8066, $8066, $8066, $8066


; New screw attack sequence. Leaves 10 bytes to spare.

org $D1812D
    db $04, $F5                                                   ; $F5 forces the decision about which sequence to draw
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; old screw attack
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $FE, $18
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; new spin attack
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $FE, $18
    db $08, $FF                                                   ; this gives the wall jump prompt when close to a wall


; The subroutine at $91:80BE-8109 is unreachable. The walljump sequence is
; relocate to this space. Leaves 1 byte to spare.

org $D180BE
    db $05, $05                                                   ; lead up into a jump
    db $FB                                                        ; this chooses the type of jump. we have augmented this subroutine
    db $03, $02, $03, $02, $03, $02, $03, $02                     ; spin jump
    db $FE, $08
    db $02, $01, $02, $01, $02, $01, $02, $01                     ; space jump
    db $FE, $08
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; old screw attack
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $FE, $18
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; new spin attack
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $FE, $18


; Hook the new sequences

org $D1B010+(2*$81)
    dw $812D, $812D, $80BE, $80BE


; Because of this code some things need to be fixed:

; Samus green glow during spin attack
;$91:DA04    CMP #$001B

org $D1DA04
base $91DA04
    CMP #$0036

; Wall jump check
;$90:9D63    CMP #$001B

org $D09D63
base $909D63
    CMP #$0036

; Relocate walljump prompt
;$90:9DD4    LDA #$001A

org $D09DD4
base $909DD4
    LDA #$0035


; This breaks when Samus turns mid-air, due to:
;$91:F634    LDA #$0001
;$91:F637    STA $0A9A  [$7E:0A9A]
; The value needs to be conditional based on water, screw attack, and space
; jump. With a lack of space in $91 we are doing a JSL into the space for death
; tiles since they are being relocated.

org $DB8000
base $9B8000
conditional_pose_routine:
    LDA $09A2         ; get equipped items
    BIT #$0020        ; check for gravity suit
    BNE .equip_check  ; if gravity suit, underwater status is not important
    JSL $90EC58       ; $12 / $14 = Samus' bottom / top boundary position
    LDA $195E         ; get [FX Y position]
    BMI .acid_check   ; if [FX Y position] < 0:, need to check for acid
    CMP $14           ; check FX Y position against Samus's position
    BPL .equip_check  ; above water, so underwater status is not important
    LDA $197E         ; get physics flag
    BIT #$0004        ; if liquid physics are disabled, underwater status is not important
    BNE .equip_check
    BRA .first_pose   ; ok, you're probably underwater at this point

.acid_check:
    LDA $1962
    BMI .equip_check  ; if [lava/acid Y position] < 0, then there is no acid, so underwater status is not important
    CMP $14
    BMI .first_pose   ; if [lava/acid Y position] < Samus' top boundary position, then you are underwater

.equip_check:
    LDA $09A2         ; get equipped items
    BIT #$0008        ; check for screw attack equipped
    BEQ .first_pose   ; if screw attack not equipped, branch out
    BIT #$0200        ; check for space jump
    BEQ .spin_attack  ; if space jump not equipped, branch out

.screw_attack:
    LDA #$0002        ; default to (new) second pose
    STA $0A9A
    RTL

.first_pose:
    LDA #$0001        ; default to first pose, as in classic
    STA $0A9A
    RTL

.spin_attack:
    LDA #$001C        ; skip over to our new spin attack section
    STA $0A9A
    RTL


; Hook the subroutine
;org $91:F634
;    LDA #$0001
;    STA $0A9A  [$7E:0A9A]

org $D1F634
base $91F634
    JSL conditional_pose_routine
    NOP
    NOP
