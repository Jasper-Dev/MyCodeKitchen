#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; AutoHotkey-script voor het invoegen van de huidige datum in het formaat 03-05-2023
; wanneer "vdg" wordt ingetypt en gevolgd door een spatie of enter

:*:vdg::
FormatTime, huidigeDatum,, dd-MM-yyyy
SendInput %huidigeDatum%
return