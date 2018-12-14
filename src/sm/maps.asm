
; exhirom  ; for crossover
; lorom ; for vanilla SM

; org $82C74D  ; location in Vanilla
org $C2C74D  ; location in Crossover
base $82C74D
; first we set our pointers for map icons
DW Crateria_names
DW Brinstar_names
DW Norfair_names
DW WS_names
DW Maridia_names
DW Tourian_names

; org $82F740
org $C2F740
base $82F740
; we're adding in 2 names for Crateria from vanilla, so we have to move this to free space
; format is XX coordinate, YY coordinate, icon
Crateria_names:
DW $002C,$0070,$005A  ; Brinstar
DW $00B8,$00B8,$005A  ; Brinstar
DW $0110,$0068,$005A  ; Brinstar
DW $0178,$0020,$005C  ; Wrecked Ship
DW $01A0,$0080,$005D  ; Maridia
DW $0080,$0078,$005E  ; Tourian
DW $FFFF

;base off

; org $82C759
org $C2C759
base $82C759
Brinstar_names:
DW $0048,$0008,$0059  ; Crateria
DW $00D0,$0040,$0059  ; Crateria
DW $0128,$0020,$0059  ; Crateria
DW $0140,$0090,$005D  ; Maridia
DW $0148,$00C0,$005B  ; Norfair
DW $FFFF

; we will be adding in both portal locations to Norfair eventually
Norfair_names:
DW $0050,$0008,$005A  ; Brinstar
DW $FFFF

WS_names:
DW $0040,$0080,$0059  ; Crateria
DW $00C0,$0080,$0059  ; Crateria
DW $FFFF

Maridia_names:
DW $0108,$0008,$0059  ; Crateria
DW $0030,$00A0,$005A  ; Brinstar
DW $0078,$00A0,$005A  ; Brinstar
DW $FFFF

Tourian_names:
DW $0098,$0048,$0059  ; Crateria
DW $FFFF

;base off

; padbyte $FF : pad $82C7CB


; these two lines are just the graphics for the portal indicator
; org $9AB2E0  ; location in vanilla SM
org $DAB2E0  ; location in crossover
base $9AB2E0
DB $00,$E0,$60,$95,$7C,$80,$7C,$80,$7C,$80,$7C,$80,$60,$95,$00,$E0

; org $B681C0  ; location in vanilla SM
org $F681C0  ; location in crossover
base $B681C0
DB $00,$E0,$60,$95,$7C,$80,$7C,$80,$7C,$80,$7C,$80,$60,$95,$00,$E0

org $F58000  ; location in crossover
base $B58000
; org $B58000  ; location in vanilla SM

incbin "data/SM_maps.bin"  ; add in all of our necessary map changes
