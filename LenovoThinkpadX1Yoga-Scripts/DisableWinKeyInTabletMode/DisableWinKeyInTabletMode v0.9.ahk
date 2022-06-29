#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

$Lwin up:: 
    SysGet, IsLaptopMode, 0x2003
    
    if (IsLaptopMode) {
        ToolTip, % "laptopMode 1 : " . IsLaptopMode
        ;Send {Blind} ;{vk07}
        ;Send {%A_ThisHotkey%}
        Send {LWin}
    } else {
        Tooltip, % "Tabletmode 0 : " . IsLaptopMode
        
    }

    SetTimer, RemorrveToolTip, 1000
    Return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

LWin & r::
send #r
return