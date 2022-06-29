#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


$F2::
InputBox, startNumber , "Initial Number", "Fill in the number to start with."
currentNumber := startNumber
InputBox, endNumber , "loop count", "Fill in the number you want to count to."

While, (currentNumber <= endNumber)  
{
    Sleep 1000
    Send, %currentNumber%
    currentNumber := (currentNumber + 1)
    SendInput {enter}
}
return

^Esc::ExitApp    ; <- Ctrl+Esc to kill the script