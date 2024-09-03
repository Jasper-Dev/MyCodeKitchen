;
; source: https://www.autohotkey.com/boards/viewtopic.php?t=10388
;

WaitTime := 0.06

Menu Tray, Icon, %A_WinDir%\System32\main.cpl  ; Set icon.
Menu Tray, NoStandard
Menu, Tray, Add, &Tweak Time ..., TweakTime
Menu Tray, Add, Exit, TrayExit
Menu Tray, Tip, Delayed Release

LButton::
Click down
Loop
{
KeyWait, LButton ; waits for the release
KeyWait, LButton, D T%WaitTime% ; waits T seconds for you to press LButton again
If ErrorLevel ; ErrorLevel is 1 if it times out. If the LButton was not pressed again, you likely purposefully released it
   Break ; exits the loop
; If you did press the LButton again, it goes back to the first KeyWait command and waits for another release
}
Click up
return

TrayExit:
ExitApp

TweakTime:
InputBox, WaitTime, Delayed Release - Tweak Time, Enter the time to wait in seconds,,,,,,,, %WaitTime%
Return