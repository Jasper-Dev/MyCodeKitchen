#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^1::
    Send, {Delete}{Delete}{.}{LControl down}{Right}{LControl up}{Delete}{Delete}
Return


^SC056::
    Send, {LControl down}{vkBFsc035}{LControl up}
Return
