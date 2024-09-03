#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
 #SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


swipeDirection := ""
^!Tab::
	swipeDirection := "L"
	;SendInput {LWin}{LControl}{Left}
	SendInput ^#{Left}
	swipeDirection := ""

return


swipeDirection := ""
^!+Tab::
	swipeDirection := "R"
	;SendInput {LWin}{LControl}{Right}
	SendInput ^#{Right
	}
	swipeDirection := ""
return