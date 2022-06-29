#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases. 
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ^F2::
; WinGetPos(WinExist("A"),X,Y,Width,Height,Offset_X,Offset_Y)
; WinMove, A,, 1920+Offset_X,0, 640-(2*Offset_X), 1080 - 30 - Offset_X
; return

; ^F1::
; WinGetPos(WinExist("A"),X,Y,Width,Height,Offset_X,Offset_Y)
; WinMove, A,, Offset_X,0, 1920-(2*Offset_X), 1080 - 30 - Offset_X
; return

^F1::
WinGetActiveStats, WinTitle, Width, Height, X, Y
if WinExist(WinTitle)
{
    ;WinMove, Title,, 1920+Offset_X,0, 640-(2*Offset_X), 1080 - 30 - Offset_X
    ; WinGetPos, X, Y, Width, Height, WinTitle
    desiredWidth := 1920
    desiredHeight := 1040
    desiredX := 0 
    desiredY := 0
    calculatedScreenWidth := (A_ScreenWidth/2) - (Width/2)
    calculatedScreenHeight := (A_ScreenHeight/2) - (Height/2)

    WinMove, %WinTitle%,, desiredX, desiredY, desiredWidth, desiredHeight
    WinGetActiveStats, WinTitle, Width, Height, X, Y
    ; MsgBox, The active window "%WinTitle%" is %A_ScreenWidth% wide`, %Height% tall`, and positioned at %X%`,%Y%.
    ; MsgBox, The active window "%WinTitle%" is %Width% wide`, %Height% tall`, and positioned at %X%`,%Y%.
}
return

^F2::
; WinGetPos, X, Y, Width, Height, WinTitle
WinGetActiveStats, WinTitle, Width, Height, X, Y
if WinExist(WinTitle)
{
    ;WinMove, Title,, 1920+Offset_X,0, 640-(2*Offset_X), 1080 - 30 - Offset_X
    ; WinGetPos, X, Y, Width, Height, WinTitle
    desiredWidth := 1920
    desiredHeight := 1040
    desiredX := (A_ScreenWidth/8) 
    desiredY := 0
    calculatedScreenWidth := (A_ScreenWidth/2) - (Width/2)
    calculatedScreenHeight := (A_ScreenHeight/2) - (Height/2)

    WinMove, %WinTitle%,, desiredX, desiredY, desiredWidth, desiredHeight
    WinGetActiveStats, WinTitle, Width, Height, X, Y
    ; MsgBox, The active window "%WinTitle%" is %A_ScreenWidth% wide`, %Height% tall`, and positioned at %X%`,%Y%.
    ; MsgBox, The active window "%WinTitle%" is %Width% wide`, %Height% tall`, and positioned at %X%`,%Y%.
}
return


^F3::
WinGetActiveStats, WinTitle, Width, Height, X, Y
if WinExist(WinTitle)
{
    ;WinMove, Title,, 1920+Offset_X,0, 640-(2*Offset_X), 1080 - 30 - Offset_X
    ; WinGetPos, X, Y, Width, Height, WinTitle
    desiredWidth := 1920
    desiredHeight := 1040
    desiredX := (A_ScreenWidth/4) 
    desiredY := 0
    calculatedScreenWidth := (A_ScreenWidth/2) - (Width/2)
    calculatedScreenHeight := (A_ScreenHeight/2) - (Height/2)

    WinMove, %WinTitle%,, desiredX, desiredY, desiredWidth, desiredHeight
    WinGetActiveStats, WinTitle, Width, Height, X, Y
    ; MsgBox, The active window "%WinTitle%" is %A_ScreenWidth% wide`, %Height% tall`, and positioned at %X%`,%Y%.
    ; MsgBox, The active window "%WinTitle%" is %Width% wide`, %Height% tall`, and positioned at %X%`,%Y%.
}
return

^F4::
WinGetActiveStats, WinTitle, Width, Height, X, Y
if WinExist(WinTitle)
{
    ;WinMove, Title,, 1920+Offset_X,0, 640-(2*Offset_X), 1080 - 30 - Offset_X
    ; WinGetPos, X, Y, Width, Height, WinTitle
    desiredWidth := 6400
    desiredHeight := 1040
    desiredX := -1920 
    desiredY := 0
    calculatedScreenWidth := A_ScreenWidth
    calculatedScreenHeight := A_ScreenHeight

    WinMove, %WinTitle%,, desiredX, desiredY, desiredWidth, desiredHeight
    WinGetActiveStats, WinTitle, Width, Height, X, Y
    ; MsgBox, The active window "%WinTitle%" is %A_ScreenWidth% wide`, %Height% tall`, and positioned at %X%`,%Y%.
    ; MsgBox, The active window "%WinTitle%" is %Width% wide`, %Height% tall`, and positioned at %X%`,%Y%.
}
return