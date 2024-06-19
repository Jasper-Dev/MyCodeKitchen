#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; coords of the ObjectiveGui
xCoord := 0 ;
yCoord := 0 ;

; size of the ObjectiveGui
guiWidth := 0 ;
guiHeight := 0 ;


; TODO: create a settings file to save settings


; setting: color of ObjectiveGui
GuiColor := "Red" ;"F0F0F0" ;"EEAA99" ; Can be any RGB color 

; setting: border color: Omit to remove border
;GuiBorderColor := "" ;"Black"

; setting: font of ObjectiveGui
; TODO: figure out why no Segoe UI font,
; TODO: maybe use Segoe UI font instead of verdana
GuiFont := "Verdana"

; setting: font color
CustomFontColor :=  "White" ; Can be any RGB color

; setting: font size
CustomFontSize := 32 ; best to set large size (default: '32' point)


; DO NOT CHANGE THESE SETTINGS
GuiFontColor := % "c" . CustomFontColor ;font color needs a 'c' in front
GuiFontSize := % "s" . CustomFontSize ;font size needs a 's' in front
TColor := "867b26" ; setting: Transparancy Color (color will be made transparent below), don't change unless you know what your doing. Default:867b26 (uglybrown)
isQuestionWindowActive := False
global CurrentObjectiveMessage := ""
; END OF NON-CHANGABLE SETTINGS

; TODO save timestamp of objective start
; TODO save timestamp of objective finished

global startTime := ""
global endTime := ""




; TODO function: rightclick icon -> set task (call questionFunction) 
; TODO function: rightclick icon -> Task completed/done 
; function to edit task
#NoTrayIcon  ; Hide initial icon.
Menu Tray, Icon, .\goal16px.png  ; Set icon.
Menu Tray, Icon  ; Show icon.
Menu Tray, NoStandard
Menu Tray, Add, &Task Complete, TrayComplete
Menu Tray, Add, &Edit Task, TrayEdit
Menu Tray, Add, &Configure, TrayConfigure
Menu Tray, Add, E&xit, TrayExit
Menu Tray, Default, &Task Complete
Menu Tray, Click, 2  ; Single-click to configure.
Menu Tray, Tip, Current Objective

Main: 
    Gosub, CreateObjectiveGui


SaveTimestamps(endTime) {
    global startTime
    objMsgText2 := global CurrentObjectiveMessage
    FileAppend, % "Objective: " . objMsgText2 . "`nStart Time: " . startTime . "`nEnd Time: " . endTime . "`n`n", timestamps.txt
}



; TODO create function that saves timestamp of objective start
StartObjective:
    global startTime := A_Now
return

; TODO create function that saves timestamp of objective Finished 
FinishObjective:



return

PomodoroTime := 45 * 60 * 1000 ; 45 minutes in milliseconds

; SetTimer, PomodoroTimer, %PomodoroTime%

PomodoroTimer:
    MsgBox, Time's up! Take a break or start a new task.
return





LoadSettings() {
    global settingsFile := "settings.ini"
    
    ; IniRead, GuiColor, %settingsFile%, Settings, GuiColor, Red
    ; IniRead, CustomFontColor, %settingsFile%, Settings, CustomFontColor, White
    ; IniRead, CustomFontSize, %settingsFile%, Settings, CustomFontSize, 32
}

SaveSettings() {
    global settingsFile
    
    ; IniWrite, %GuiColor%, %settingsFile%, Settings, GuiColor
    ; IniWrite, %CustomFontColor%, %settingsFile%, Settings, CustomFontColor
    ; IniWrite, %CustomFontSize%, %settingsFile%, Settings, CustomFontSize
}




TrayComplete:
    ; TODO play little victory sound


    ; Perform other actions like playing a victory sound
    endTime := A_Now
    SaveTimestamps(endTime)
    ; SaveTimestamps(startTime, endTime)




    ; TODO save objective and finished timestamp to file
 
    ; ObjectiveMessage := AskForObjective()
    ; GuiControl,,ObjectiveMessage, %ObjectiveMessage%
    ; Gosub, ObjectiveGui
    objMsgText := ""
    Gosub, AskForObjective
return

TrayEdit:
    objMsgText := CurrentObjectiveMessage
    Gosub, AskForObjective
return

TrayConfigure:
; TODO add functionality
; TODO create window to configure settings of the program, like color of objective window, color of text, size of window, size of text and enable or disable pomodoro timer settings, 
return


; TODO pomodoro functionality
; TODO function countdown 45 minutes and show message to get a break or do a different task
; TODO functionality + window to keep track of previous tasks and how long they took



AskForObjective:
    ; make sure only one inputbox is active
    if isQuestionWindowActive
        return

    isQuestionWindowActive := True
    ; function: question -> what is your current objective?
    InputBox, UserInput, Objective, what is your current objective?, , 640, 200,,,,, %objMsgText%
    if ErrorLevel
    {
        ; MsgBox, CANCEL was pressed.
        isQuestionWindowActive := False
        return
    }
    else ; todo if not empty
    {
        ; newtext := CalcTextSize(UserInput)
        Gui Pseudo:New
        Gui, Pseudo:Font, %GuiFontColor% %GuiFontSize% %GuiFont%
        Gui, pseudo:Add, Text, vpseudotext, %UserInput%
        GuiControlGet, ps, pseudo:Pos, pseudotext
        Gui Pseudo:Show,Hide
        Gui Pseudo:Destroy

        CurrentObjectiveMessage := UserInput
        GuiControl Alpha:Text, ObjectiveMessage, %UserInput%
        GuiControl Alpha:Move, ObjectiveMessage, % "h" psH "w" psW
        ; Gui, Alpha:Add, Text, , % "h" psH " w" psW " y" psY " x" psX

        Gosub, ShowObjectiveGui
    }
    isQuestionWindowActive := False
return 


       

CreateObjectiveGui:

; TODO figure out what this code did, and possibly remove it
    ; ; function: show objective on top always visible non clickable
    ; Gui, Alpha: +LastFound +AlwaysOnTop -Caption +ToolWindow ; +ToolWindow avoids a taskbar button and an alt-tab menu item. +border

    ; Gui, Alpha:Color, %GuiColor%
    ; ; Make all pixels of this color transparent and make the text itself translucent (150):
    ; WinSet, TransColor, %TColor% 175

    ; Gui, Alpha:Font, %GuiFontColor% %GuiFontSize% %GuiFont%
    ; Gui, Alpha:Add, Text, vObjectiveMessage gAskForObjective,"this is placeholder text so i can read the variables" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.
    ; ;Gui, Add, Text, Hidden , "text" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.

    ; ;SetTimer, UpdateOSD, 200
    ; ;Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
    ; Gosub, ShowObjectiveGui

    ; Create gui
    Gui Alpha:New
    ; function: show objective on top always visible non clickable
    Gui, Alpha: +LastFound +AlwaysOnTop -Caption +ToolWindow ; +ToolWindow avoids a taskbar button and an alt-tab menu item. +border

    Gui, Alpha:Color, %GuiColor%
    ; Make all pixels of this color transparent and make the text itself translucent (150):
    WinSet, TransColor, %TColor% 175

    Gui, Alpha:Font, %GuiFontColor% %GuiFontSize% %GuiFont%
    ; Gui, Alpha:Add, Text, vObjectiveMessage ;,"this is placeholder text so i can read the variables" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.
    Gui, Alpha:Add, Text, vObjectiveMessage +gDrag, ;,"this is placeholder text so i can read the variables"

    
    ;Gui, Add, Text, Hidden , "text" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.

    ;SetTimer, UpdateOSD, 200
    ;Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
    Gosub, ShowObjectiveGui
return

ShowObjectiveGui:
; DONE hide the window if no text has been put in
    If (CurrentObjectiveMessage = "")
        Gui, Alpha:Hide
    Else
        Gui, Alpha:Show, xCenter y10 AutoSize NoActivate, Main  ; NoActivate avoids deactivating the currently active window.
        ; GuiControl(1, "+MouseClick", "Drag")
return

; ShowObjectiveGui:
;     Gui Alpha:Show, xCenter y10 AutoSize NoActivate, Main  ; NoActivate avoids deactivating the currently active window.
;     ; GuiControl(1, "+MouseClick", "Drag")
; return

    ; TODO make the window draggable to different location

Drag:
    PostMessage, 0xA1, 2, , , A  ; 0xA1 is WM_NCLBUTTONDOWN, 2 is HTCAPTION
return


; TODO figure out what this code did, and possibly remove it
; ReloadObjectiveGui:
;     GuiControl, Hide, ObjectiveMessage
;     Gui, Show, xCenter y10 AutoSize NoActivate  ; NoActivate avoids deactivating the currently active window.
; return

    ; UpdateOSD:
    ; MouseGetPos, MouseX, MouseY
    ; GuiControl,, MyText, X%MouseX%, Y%MouseY%
    ; return



; TODO figure out what this code does, and maybe use it
; Drag:
;     MouseGetPos, startX, startY
;     WinGetPos, , , guiWidth, guiHeight, ahk_id %A_Gui%
;     loop
;     {
;         GuiControlGet, controlX, , 1
;         GuiControlGet, controlY, , 1
;         MouseGetPos, currentX, currentY
;         offsetX := currentX - startX
;         offsetY := currentY - startY
;         newControlX := controlX + offsetX
;         newControlY := controlY + offsetY
;         if (newControlX < 0) || (newControlX + guiWidth > A_ScreenWidth)
;             break
;         if (newControlY < 0) || (newControlY + guiHeight > A_ScreenHeight)
;             break
;         GuiControl, Alpha:Move, 1, %newControlX%, %newControlY%
;         startX := currentX
;         startY := currentY
;     }
; return


CancelExit:
TrayExit:
ExitApp