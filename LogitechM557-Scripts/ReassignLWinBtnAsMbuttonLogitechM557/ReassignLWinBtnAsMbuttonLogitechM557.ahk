; #UseHook OFF
; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallMouseHook

; <#::LWin
; return

; ;SC15B is the LWin Button
; SC15B::MButton
; ;MsgBox, %A_ThisHotkey% was pressed.
; return
;#UseHook  ; Force the use of the hook for hotkeys after this point.
;#x::MsgBox, This hotkey will be implemented with the hook.
;#y::MsgBox, And this one too.
;#UseHook off
;#z::MsgBox, But not this one.

SC15B:: ; Replace 159 with your key's value.
MsgBox, %A_ThisHotKey% was pressed.
return