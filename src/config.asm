; Common Combo Randomizer ROM confiuration flags

org $F47000

; Use "Randomizer Live" features (sd2snes-based communication framework)
; This is required by Multiworld
config_randolive:   ; $F47000
    dw #$0000

; Enable "Multiworld"
config_multiworld:  ; $F47002
    dw #$0000


