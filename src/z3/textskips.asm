;================================================================================
; Text Removal
;--------------------------------------------------------------------------------
;-- Music restarting at zelda fix
org $05ED10 ; <- 2ED10 - sprite_zelda.asm : 233 - (LDA.b #$19 : STA $012C)
NOP #5
;--------------------------------------------------------------------------------
org $1ECE47 ; <- F4E47 - sprite_crystal_maiden.asm : 220
JML.l MaidenCrystalScript
;--------------------------------------------------------------------------------
org $1ECCEB ; <- F4CEB - sprite_crystal_maiden.asm : 25 ; skip all palette nonsense
JML.l SkipCrystalPalette
;;;org $1ECD39
;;;SkipCrystalPalette:
;--------------------------------------------------------------------------------
org $08C3FD ; <- 443FD - ancilla_receive_item.asm : 89
!MS_GOT = "$7F5031"
LDA #$40 : STA !MS_GOT
;;NOP #6 ; don't set master sword follower
;--------------------------------------------------------------------------------
org $08C5FE ; <- 445FE - ancilla_receive_item.asm : 408
NOP #4
;--------------------------------------------------------------------------------
org $1ED467 ; <- F5467 - sprite_agahnim.asm : 202
NOP #4
;--------------------------------------------------------------------------------
org $1ED4FF ; <- F54FF - sprite_agahnim.asm : 328
NOP #4
;--------------------------------------------------------------------------------
;org $029C94 ; <- 11C94 - Bank02.asm : 5197 (JSL Main_ShowTextMessage)
;NOP #4
;--------------------------------------------------------------------------------
org $029CBD ; <- 11CBD - Bank02.asm : 5227 (JSL Messaging_Text)
STZ $11
NOP #2
;--------------------------------------------------------------------------------
;org $029CD3 ; <- 11CD3 - Bank02.asm : 5237 (BNE BRANCH_BETA)
;db $80 ; BRA
;--------------------------------------------------------------------------------
org $029CDF ; <- 11CDF - Bank02.asm : 5245 (JSL Main_ShowTextMessage)
NOP #4
;--------------------------------------------------------------------------------
org $029CF0 ; <- 11CF0 - Bank02.asm : 5266
STZ $11
NOP #2
;--------------------------------------------------------------------------------
org $05FB70 ; <- 2FB70 - sprite_mad_batter.asm:131 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;--------------------------------------------------------------------------------
org $05FBC2 ; <- 2FBC3 - sprite_mad_batter.asm:195 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;--------------------------------------------------------------------------------
;org $05F16C ; <- 2F16C - sprite_elder.asm : 137 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .dont_show)
;NOP #4
;--------------------------------------------------------------------------------
;org $05F190 ; <- 2F190 - sprite_elder.asm : 170 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
;NOP #4
;--------------------------------------------------------------------------------
;org $05F1A8 ; <- 2F1A8 - sprite_elder.asm : 182 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
;NOP #4
;--------------------------------------------------------------------------------
;org $05F1BC ; <- 2F1BC - sprite_elder.asm : 194 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
;NOP #4
;--------------------------------------------------------------------------------
;org $05F1CE ; <- 2F1CE - sprite_elder.asm : 194 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
;NOP #4
;--------------------------------------------------------------------------------
;-- Old mountain man healing text
org $1EEAD7 ; F6AD7 sprite_old_mountain_man.asm : (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
;--------------------------------------------------------------------------------
;-- Priest healing text
org $05DE11 ; 2DE11 sprite_uncle_and_priest.asm : 720 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .gamma)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
;--------------------------------------------------------------------------------
;-- zelda's heal text
org $05EE38 ; <- 2ee38 sprite_zelda.asm : 474 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
;--------------------------------------------------------------------------------
;-- zelda in jail
org $05ED06 ; <- 2ED06 sprite_zelda.asm : 227 - (JSL Sprite_ShowMessageUnconditional)
STZ $1CE8 : NOP
org $05ED27 ; <- 2ED27 sprite_zelda.asm : 256 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
org $05ED35 ; <- 2ED35 sprite_zelda.asm : 272 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------
;-- sanctuary
org $05DD83 ; <- 2DD83 sprite_uncle_and_priest.asm : 608 - (JSL Sprite_ShowMessageUnconditional)
STZ $1CE8 : NOP
org $05EDC8 ; <- 2EDC8 sprite_zelda.asm : 388 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
org $05DDAB ; <- 2DDAB sprite_uncle_and_priest.asm : 635 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------
;-- Sick Kid
org $06B9C6 ; <- 339C6 sprite_bug_net_kid.asm : 92 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------
;-- Hobo
org $06BE5F ; <- 33E5F sprite_hobo.asm : 121 - (JSL Sprite_ShowMessageUnconditional)
Nop #4
;----------------------------------------------------------
;-- Sahasrahla
org $05F190 ; <- 2F190 sprite_elder.asm : 154 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .dont_show_2) - "Blah blah blah, take the boots"
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $05F212 ; <- 2F212 sprite_elder.asm : 261 - (JSL Sprite_ShowMessageUnconditional) - "Gave you the boots but I'm not doing talking yet"
NOP #4
org $05F1ED ; <- 2F1ED sprite_elder.asm : 225 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Shopkeepers
org $1EEF7C ; <- F6F7C sprite_shopkeeper.asm : 85 (JSL Sprite_ShowMessageUnconditional)
NOP #4
org $1EF375 ; <- F7375 sprite_shopkeeper.asm : 810 (JSL Sprite_ShowMessageUnconditional : JSL ShopKeeper_RapidTerminateReceiveItem)
NOP #8
;----------------------------------------------------------
;-- Bomb shop guy (buying small bombs, and buying big bomb)
org $1EE1C0 ; <- F61C0 sprite_bomb_shop_entity.asm : 120 (JSL Sprite_ShowMessageUnconditional)
NOP #4
org $1EE208 ; <- F6208 sprite_bomb_shop_entity.asm : 178 (JSL Sprite_ShowMessageUnconditional)
NOP #4
;-- Text hook for the actual npc
org $1EE181 ; <- F6181 sprite_bomb_shop_entity.asm : 85 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
;;;JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Alt
;----------------------------------------------------------
;-- Catfish
org $1DE112 ; <- EE112 sprite_great_catfish.asm : 341 (JSL Sprite_ShowMessageMinimal)
NOP #4
;----------------------------------------------------
;-- King Zora
org $059A7D ; <- 29A7D sprite_zora_king.asm : 223 - (JSL Sprite_ShowMessageMinimal)
STZ $1CE8 : NOP
;----------------------------------------------------
;-- Before Agah 1 fight
org $1DD299 ; <- ED299 sprite_chatty_agahnim.asm : 111 (JSL Sprite_ShowMessageMinimal)
NOP #4
org $1DD35E ; <- ED35E sprite_chatty_agahnim.asm : 253 (JSL Sprite_ShowMessageMinimal)
NOP #4
;----------------------------------------------------
;-- Blind Maiden (in jail)
;org $1EE8CD ; <- F68CD sprite_blind_maiden.asm : 18 - (JSL Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak)
;NOP #4
;----------------------------------------------------
;-- Blind (Maiden) in Jail
org $1EE8CD ; <- F68CD sprite_blind_maiden.asm : 18 - (JSL Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak)
JSL Sprite_ShowMessageFromPlayerContact_Edit
;----------------------------------------------------
;-- Kiki
org $1EE3E6 ; <- F63E6 sprite_kiki.asm : 157 pay kiki 10 rupees
STZ $1CE8 : NOP
org $1EE400 ; <- F6400 sprite_kiki.asm : 178 thanks for giving kiki rupees
NOP #4
org $1EE4FB ; <- F64FB sprite_kiki.asm : 340 pay 100 rupees
STZ $1CE8 : NOP
org $1EE523 ; <- F6523 sprite_kiki.asm : 373 kiki will open door
NOP #4

;org $1EE414 ; <- F6414 sprite_kiki.asm : 193 don't have 10 rupees
;NOP #4
;org $1EE50C ; <- F650C sprite_kiki.asm : 356 don't have 100 rupees
;NOP #4
;----------------------------------------------------
;-- Witch
org $05E4FB ; <- 2E4FB sprite_witch.asm : 165 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
NOP #4
;----------------------------------------------------
;-- Breaking Ganon's Tower Seal
org $08CD3A ; <- 44D3A ancilla_break_tower_seal.asm : 55 (JSL Main_ShowTextMessage)
NOP #4
;----------------------------------------------------
;-- Bombos tablet
org $05F3BF ; <- 2F3BF sprite_medallion_tablet.asm : 254 (JSL Sprite_ShowMessageUnconditional)
;;;JSL.l DialogBombosTablet
;----------------------------------------------------
;-- Ether tablet
org $05F429 ; <- 2F429 sprite_medallion_tablet.asm : 317 (JSL Sprite_ShowMessageUnconditional)
;;;JSL.l DialogEtherTablet
;----------------------------------------------------
;-- Agahnim 1 Defeated
org $068475 ; <- 30475 Bank06.asm : 762 - (JSL Sprite_ShowMessageMinimal)
;;;JSL.l AddInventory_incrementBossSwordLong
;NOP #4
;----------------------------------------------------
;-- Old Mountain Man Encounter Text
org $1EE9BC ; <- sprite_old_mountain_man.asm : 157 - (Sprite_ShowMessageFromPlayerContact)
JSL Sprite_ShowMessageFromPlayerContact_Edit

org $09A67D ; <- 4A67D tagalong.asm : 1152 (JSL OldMountainMan_TransitionFromTagalong)
JML OldMountainMan_TransitionFromTagalong_Edit
;----------------------------------------------------------
;-- Purple Chest Encounter Text
org $1EE0E7 ; <- F60E7 sprite_thief_chest.asm : 16 (JSL Sprite_ShowMessageFromPlayerContact : BCC .didnt_touch)
JSL Sprite_ShowMessageFromPlayerContact_Edit
;----------------------------------------------------------
;-- Middle aged man opens purple chest
org $06BD44 ; <- 33D44 sprite_middle_aged_man.asm : 107 (JSL Sprite_ShowMessageFromPlayerContact : BCC .return)
JSL Sprite_ShowMessageFromPlayerContact_Edit
;----------------------------------------------------------
;-- Smiths
;-- Ribbit
org $06B2AA ; <- 332AA sprite_smithy_bros.asm : 152 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit

;-- Ask us to do anything
org $06B418 ; <- 33418 sprite_smithy_bros.asm : 371 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .player_didnt_speak)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit

;-- Your sword is tempered!
org $06B538 ; <- 33538 sprite_smithy_bros.asm : 602 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .no_player_dialogue)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit

;-- Brought dwarf home
org $06B438 ; <- 33438 sprite_smithy_bros.asm : 399 (JSL Sprite_ShowMessageUnconditional)
NOP #4

;-- 10 rupees to temper
org $06B470 ; <- 33470 sprite_smithy_bros.asm : 447 (JSL Sprite_ShowMessageUnconditional)
NOP #4

;-- Yes, I'm sure
org $06B495 ; <- 33495 sprite_smithy_bros.asm : 479 (JSL Sprite_ShowMessageUnconditional)
NOP #4

;-- We'll take your sword
org $06B4F3 ; <- 334F3 sprite_smithy_bros.asm : 556 (JSL Sprite_ShowMessageUnconditional)
JSL ItemSet_SmithSword
;NOP #4

;-- Smiths can't make your sword any stronger
org $06B4A1 ; <- 334A1 sprite_smithy_bros.asm : 491 - (Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Not enough magic text
org $07B0CC ; <- 3B0CC Bank07.asm : 7767 - (JSL Main_ShowTextMessage)
NOP #4
;----------------------------------------------------------
;-- Witch's Assistant
org $05F8E7 ; <- 2F8E7 sprite_potion_shop.asm : 603 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $05F8F5 ; <- 2F8F5 sprite_potion_shop.asm : 620 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
;----------------------------------------------------------
;-- Bottle Vendor
org $05EAE3 ; <- 2EAE3 sprite_bottle_vendor.asm : 104 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_converse)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $05EB03 ; <- 2EB03 sprite_bottle_vendor.asm : 129 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Digging Game Guy
org $1DFC76 ; <- EFC76 sprite_digging_game_guy.asm : 46 (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .return)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $1DFCA6 ; <- EFCA6 sprite_digging_game_guy.asm : 89 (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Flute Boy
org $06B078 ; <- 33078 sprite_flute_boy.asm : 244 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $06B0AF ; <- 330AF sprite_flute_boy.asm : 308 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- 300 rupee npcs
org $1EF047 ; <- F7047 sprite_shopkeeper.asm : 227 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing) (probably)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
;----------------------------------------------------------
;-- Chest Game Guy
org $1EEFBF ; <- F6FBF sprite_shopkeeper.asm : 121 - (JSL Sprite_ShowSolicitedMessageIfPlayerFacing : BCC BRANCH_ALPHA)
JSL Sprite_ShowSolicitedMessageIfPlayerFacing_Edit
org $1EEFE0 ; <- F6FE0 sprite_shopkeeper.asm : 144 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Desert Palace plaque (opening desert with book)
org $1EE0D2 ; <- F60D2 Sprite_Hylian_Plaque.asm : 127 - (JSL Sprite_ShowMessageUnconditional)
NOP #4
;----------------------------------------------------------
;-- Uncle gives sword
org $05DF34 ; <- 2DF34 sprite_uncle_and_priest.asm : 961 - (JSL Sprite_ShowMessageFromPlayerContact : BCC .player_not_close_2)
JSL Sprite_ShowMessageFromPlayerContact_Edit
;----------------------------------------------------------

;===================================
;-- Escort Text
;-- dw coordinate, coordinate, flag, text message number, tagalong number
;===================================
org $09A4C2 ; <- 4A4C2 tagalong.asm : 967 - (.room_data_1)
dw $1EF0, $0288, $0001, $0097, $00F0 ; Old man first text after encounter text
dw $1E58, $02F0, $0002, $0098, $00F0 ; Old man "dead end" (when you run to the pot)
dw $1EA8, $03B8, $0004, $0099, $00F0 ; Old man "turn right here"
dw $0CF8, $025B, $0001, $001F, $00F0 ; Zelda "there's a secret passage"
dw $0CF8, $039D, $0002, $001F, $00F0 ; Zelda "there's a secret passage"
dw $0C78, $0238, $0004, $001F, $00F0 ; Zelda "there's a secret passage"
dw $0A30, $02F8, $0001, $0020, $00F0 ; Zelda "we can push this"
dw $0178, $0550, $0001, $0021, $00F0 ; Zelda "pull the lever"
dw $0168, $04F8, $0002, $0028, $00F0 ; Zelda room before sanctuary
dw $1BD8, $16FC, $0001, $0122, $00F0 ; Blind (maiden) "don't take me outside!"
dw $1520, $167C, $0001, $0122, $00F0 ; Blind (maiden) "don't take me outside!"
dw $05AC, $04FC, $0001, $0027, $00F0 ; Zelda in the water room