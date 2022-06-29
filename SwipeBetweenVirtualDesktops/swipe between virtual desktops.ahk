#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

swipeDirection := ""

^!Tab::
	swipeDirection := "L"
return

^!+Tab::
	swipeDirection := "R"
return

$Enter::
	if (not swipeDirection) {
		SendInput {Enter}
	} else if (swipeDirection = "L") {
		SendInput ^#{Left}
	} else if (swipeDirection = "R") {
		SendInput ^#{Right}
	}
	swipeDirection := ""
return