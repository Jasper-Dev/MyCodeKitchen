#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



; setting: color of ObjectiveGui
GuiColor := "Red" ;"F0F0F0" ;"EEAA99" ; Can be any RGB color 

; setting: border color: Omit to remove border
;GuiBorderColor := "" ;"Black"

; setting: font of ObjectiveGui
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
; END OF NON-CHANGABLE SETTINGS







; TODO save timestamp of objective start
; TODO save timestamp of objective finished


; TODO function: rightclick icon -> set task (call questionFunction) 
; TODO function: rightclick icon -> Task completed/done 
#NoTrayIcon  ; Hide initial icon.
Menu Tray, Icon  ; Show icon.
Menu Tray, NoStandard
Menu Tray, Add, &Task Complete, TrayComplete
Menu Tray, Add, &Configure, TrayConfigure
Menu Tray, Add, E&xit, TrayExit
Menu Tray, Default, &Task Complete
Menu Tray, Click, 2  ; Single-click to configure.
Menu Tray, Tip, Current Objective

Main: 
    Gosub, CreateObjectiveGui

TrayComplete:
    ; ObjectiveMessage := AskForObjective()
    ; GuiControl,,ObjectiveMessage, %ObjectiveMessage%
    ; Gosub, ObjectiveGui
    Gosub, AskForObjective
return

TrayConfigure:
return



; TODO function countdown 45 minutes and show message to get a break or do a different task


AskForObjective:
    ; make sure only one inputbox is active
    if isQuestionWindowActive
        return

    isQuestionWindowActive := True
    ; function: question -> what is your current objective?
    InputBox, UserInput, Objective, what is your current objective?, , 640, 200
    if ErrorLevel
        MsgBox, CANCEL was pressed.
    else 
        Gui Pseudo:Destroy
        Gui Pseudo:New
        Gui, Pseudo:Font, %GuiFontColor% %GuiFontSize% %GuiFont%
        Gui, pseudo:Add, Text, vpseudotext, %UserInput%
        GuiControlGet, ps, pseudo:Pos, pseudotext
        Gui Pseudo:Show,Hide

        GuiControl Alpha:Text, ObjectiveMessage, %UserInput%
        GuiControl Alpha:Move, ObjectiveMessage, % "h" psH "w" psW
        Gui, Alpha:Add, Text, , % "h" psH " w" psW " y" psY " x" psX
        Gosub, ShowObjectiveGui
        ;WinGetPos,guiX,guiY,guiW,guiH      ; Get window position and dimensions
        ;Gui, Alpha:Destroy
        ; Gui, Add, Text, vObjectiveMessage2, "Hello World!"
        ; GuiControl Alpha:MoveDraw, ObjectiveMessage
        ;  Gui, Alpha:Add,Text, ObjectiveMessage2, %UserInput%
        ;  Gui, Alpha:Add,Text, ObjectiveMessage2, %UserInput%
        ;  Gui, Show, xCenter y10 AutoSize NoActivate *w%A_GuiWidth% *h%A_GuiHeight%
        ; GuiControl alpha:, ObjectiveMessage, % "w".guiW "h".guiH
        ; Gui, alpha:Add, Text, , %guiW%
        ; Gui, alpha:Add, Text, , % "h" guiH " w" guiW " y" guiY " x" guiX
        ; ;Gui, Add, Text, vObjectiveMessage ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.
        ; Gui, Hide
        ; GuiControl, Text, ObjectiveMessage, %UserInput%
        ; ;GuiControl, Resize, ObjectiveMessage
        ; GuiControl alpha:, Resize
        ; ;GuiControlGet T, Pos, Static1
        ; ;GuiControl, Move, ObjectiveMessage, % "h" TH " w" TW
        ;WinMove, alpha:,,, , *Number*, *Number

    isQuestionWindowActive := False
return 

        ;GuiControl, Show, ObjectiveMessage
        ;GuiControl, Text, ObjectiveMessage, %UserInput%
        ;Gui, Show, AutoSize ; NoActivate avoids deactivating the currently active window.
        ;GuiControl, Resize, ObjectiveMessage
        ; Gui, +Resize

; SetTextAndResize(controlID, newText) {

;     Gui Add, Text, R1, %newText%
;     GuiControlGet T, Pos, Static1
;     Gui Destroy

;     GuiControl,, %controlID%, %newText%
;     GuiControl Move, %controlID%, % "h" TH " w" TW
; }

; AskForObjective(){
; ; function: question -> what is your current objective?
; InputBox, UserInput, Objective, what is your current objective?, , 640, 200
; if ErrorLevel
;     MsgBox, CANCEL was pressed.
; else 
;     return %UserInput% 
; }

CreateObjectiveGui:
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
    Gui, Alpha:Add, Text, vObjectiveMessage ;,"this is placeholder text so i can read the variables" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.
    ;Gui, Add, Text, Hidden , "text" ;, %ObjectiveMessage% ; XXXXX YYYYY  ; XX & YY serve to auto-size the window.

    ;SetTimer, UpdateOSD, 200
    ;Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
    Gosub, ShowObjectiveGui
return

ShowObjectiveGui:
    Gui Alpha:Show, xCenter y10 AutoSize NoActivate, Main  ; NoActivate avoids deactivating the currently active window.
return

; ReloadObjectiveGui:
;     GuiControl, Hide, ObjectiveMessage
;     Gui, Show, xCenter y10 AutoSize NoActivate  ; NoActivate avoids deactivating the currently active window.
; return

    ; UpdateOSD:
    ; MouseGetPos, MouseX, MouseY
    ; GuiControl,, MyText, X%MouseX%, Y%MouseY%
    ; return

CancelExit:
TrayExit:
ExitApp