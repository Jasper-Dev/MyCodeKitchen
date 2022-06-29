;v1.0
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SoundGet, master_mute, , mute, 5
if (master_mute = "Off"){
    Menu, Tray, Icon, Icons/microphone-solid-color.ico,,1
}Else{
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico,,1
}

^!`:: ;ctrl+alt+` ;<s> Shift Pause Break button is my chosen hotkey </s>

SoundSet, +1, MASTER, mute,5 ;5 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 5's  <---------IMPORTANT
SoundGet, master_mute, , mute, 5

;ComObjCreate("wscript.shell").SendKeys(Chr(0xAD))

if (master_mute = "Off"){
    ToolTip, Mic On ✔
    SoundPlay, Sounds/unmute.wav
    Menu, Tray, Icon, Icons/microphone-solid-color.ico,,1
    
}Else{
    ToolTip, Mic Off ❌
    SoundPlay, Sounds/mute.wav
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico,,1
}
;ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle

SetTimer, RemoveToolTip, 1000
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
