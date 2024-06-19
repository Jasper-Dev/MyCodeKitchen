#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#q::
; DeviceList:= ""
; Loop, % DllCall("waveInGetNumDevs")
; {
;     DllCall("waveInGetDevCaps", "uint", A_Index - 1, "ptr", pCaps, "uint", 260)
;     DeviceList .= NumGet(pCaps, 0, "ptr") "n" 
; }

; MsgBox % "Audio capture devices:n`n" DeviceList
numDevs := DllCall("waveInGetNumDevs")
MsgBox %numDevs%
return