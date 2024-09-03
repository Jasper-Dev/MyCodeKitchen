#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
#InstallKeybdHook
#InstallMouseHook

; ----

#NoEnv
#SingleInstance force
SetTitleMatchMode, 2

Gui, +AlwaysOnTop
Gui, Font, s12, Arial
Gui, Add, Edit, vOutput w400 h200 ReadOnly, | Key | SC Code | Description `n| --- | ------- | ----------- `n
Gui, Show, , Key Press Logger

SetTimer, InputCapture, 10
SetTimer, CapsLockCapture, 50
return

InputCapture:
Input, keyPressed, L1, {NumpadEnter}
scCode := Format("SC{:03X}", A_EventInfo)
keyDescription := A_EndLabel
if ErrorLevel = "EndKey:{NumpadEnter}"
{
    Gosub, ExportKeyHistory
    return
}
if (keyPressed != "CapsLock") {
    GuiControlGet, Output
    keyPressDetails := "|" . keyPressed . " | " . scCode . " | " . keyDescription . " `n"
    GuiControl, , Output, % Output . keyPressDetails
    keyHistory .= keyPressDetails
}
return

CapsLockCapture:
currentCapsLockState := GetKeyState("CapsLock", "T")
if (currentCapsLockState != prevCapsLockState) {
    prevCapsLockState := currentCapsLockState
    scCode := "SC03A"
    keyDescription := "CapsLock"
    GuiControlGet, Output
    keyPressDetails := "|CapsLock | " . scCode . " | " . keyDescription . " `n"
    GuiControl, , Output, % Output . keyPressDetails
    keyHistory .= keyPressDetails
}
return

ExportKeyHistory:
dateTime := A_Now
FormatTime, dateTime, %dateTime%, yyyyMMddHHmmss
fileName := "keystrokes" . dateTime . ".txt"
FileDelete, %fileName%
FileAppend, | Key | SC Code | Description `n| --- | ------- | ----------- `n%keyHistory%, %fileName%
return

GuiClose:
ExitApp
