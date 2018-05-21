exhirom

; --- Macros and stuff ---
incsrc "macros.asm"                         ; Useful macros
incsrc "sram.asm"                           ; SRAM Variable definitions

; --- Common code ---
incsrc "common.asm"                         ; Common routines
incsrc "credits.asm"                        ; Common credits scroller
incsrc "spc_play.asm"                       ; Common SPC player

; --- Super Metroid code ---            
incsrc "sm/hirom.asm"                       ; Super Metroid ExHiROM patch
incsrc "sm/transition.asm"                  ; Super Metroid Transition patch
incsrc "sm/teleport.asm"                    ; Super Metroid Teleport patch
incsrc "sm/randomizer/randomizer.asm"       ; Super Metroid Randomizer patches
incsrc "sm/items.asm"                       ; Super Metroid ALTTP Items patch
incsrc "sm/ending.asm"                      ; Super Metroid Ending conditions
incsrc "sm/newgame.asm"                     ; Super Metroid New Game Initialization
incsrc "sm/nofanfare.asm"                   ; Super Metroid Remove Item fanfares

; --- ALTTP code ---
incsrc "z3/hirom.asm"	                    ; ALTTP ExHiROM patch
incsrc "z3/transition.asm"                  ; ALTTP Transition patch
incsrc "z3/teleport.asm"                    ; ALTTP Teleport patch
incsrc "z3/randomizer/randomizer.asm"       ; ALTTP Randomizer patches (github.com/mmxbass/z3randomizer)
incsrc "z3/items.asm"                       ; ALTTP Super Metroid Items
incsrc "z3/ending.asm"                      ; ALTTP Ending Conditions
incsrc "z3/newgame.asm"                     ; ALTTP New Game Initialization
