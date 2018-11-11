;Fix for escape bomb block softlock by Capn
;Hijack the door ASM
org $cfe4cf
base $8fe4cf
	jsr NewShaftDoorASM
	rts

;Free space at ec00
org $cfec00
base $8fec00
NewShaftDoorASM:
	;Start with Original ASM functions
	php
	%a8()
	lda #$01
	sta $7ecd38
	lda #$00
	sta $7ecd39
	;Set all blocks in RAM to air
	;Got lucky here that asm code is done after tile loading ^_^
	%a16()
	lda #$00ff
	sta $7f3262
	sta $7f3264
	sta $7f32c2
	sta $7f32c4
	sta $7f3322
	sta $7f3324
	sta $7f3382
	sta $7f3384
	plp
	rts
