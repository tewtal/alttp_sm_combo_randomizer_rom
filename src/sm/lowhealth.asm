
org $D0EA85
base $90EA85

; We are changing the health check so the "low health" alarm is never set, and therefore will not play.
; This is effectively a one-byte change.
RTS

org $D1E6D5
base $91E6D5

; We have to change the check that unpausing the menu does as well, or else the alarm will trigger and never cease playing until
; conditions are satisfied when exiting the menu
RTS
