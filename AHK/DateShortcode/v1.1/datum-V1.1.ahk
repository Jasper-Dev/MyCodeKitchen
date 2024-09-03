#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; AutoHotkey-script voor het invoegen van de huidige datum in het formaat 03-05-2023
; wanneer "vdg" wordt ingetypt en gevolgd door een spatie of enter

; 2023-07-10
:*:vdg::
FormatTime, huidigeDatum,, yyyy-MM-dd
SendInput %huidigeDatum%
return

; 2023-07-10
:*:ymd::
FormatTime, huidigeDatum,, yyyy-MM-dd
SendInput %huidigeDatum%
return

; disabled due to possible confusion of the hotkeys
; ; 07-10-2023
; :*:mdy::
; FormatTime, huidigeDatum,, MM-dd-yyyy
; SendInput %huidigeDatum%
; return

; 10-07-2023
:*:dmy::
FormatTime, huidigeDatum,, dd-MM-yyyy
SendInput %huidigeDatum%
return