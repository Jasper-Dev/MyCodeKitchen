#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Gui 1:Add, CheckBox, w115 y10 vOptDM, Dialog Model
; Gui 1:Add, CheckBox, w115 vOptBS, Subroutine Set
; Gui 1:Add, CheckBox, w115 vOptDS Checked, Data Section
; Gui 1:Add, CheckBox, w115 vOptDX, Dialog Box
; Gui 1:Add, CheckBox, w115 y10 x+5 vOptFD, Buffer
; Gui 1:Add, CheckBox, w115 y+6 vOptRUS, Standard Text
; Gui 1:Add, CheckBox, w115 y+6 vOptAll, Tout sauf StdTxt
; Gui 1:Add, CheckBox, w115 y+6 vOptAllRUS, Tout

; Gui 1:Add, Button, w90 y10 vStartSearch Default, Rechercher
; Gui 1:Add, Button, w90 y+10, Construire index
; Gui 1:Add, Button, w90 y+10, Afficher l'index
; Gui 1:Add, Button, w90 y+10, Extracteur
; Gui 1:Add, Text, x10 yp-15, Recherche dans un répertoire spécifique :

; Gui 1:Add, DropDownList, vDirSpec w75, C:\|D:\||E:\
; Gui 1:Add, Text, , Texte recherché (mot complet, exemple : test ne ramènera pas tests) :
; Gui 1:Add, Edit, vSearch w335, Texte
; Gui 1:Add, CheckBox, x10 vReBuild, Remplacer fichiers déjà indexés
; Gui 1:Add, CheckBox, x10 vNoCache Checked, Ne pas utiliser de cache
; Gui 1:Add, Button, x+150 yp-10 w50 gQuitter, Quitter

; Gui 1:Show

; Return

; GuiEscape:
; GuiClose:
; Quitter:
; ExitApp

;activex gui - test  joedf - 2014/07/04


; myGui()

; myGui()

; {
;     static thisVar, thatVar
;     gui, SomeGuiName: new
;     gui, Default
;     gui, +LastFound
;     gui, add, groupbox, w250 h130, example
;     gui, add, text, xm12 ym30 section, this Label
;     gui, add, text, xm12 yp+30, that label
;     gui, add, button, yp+30 gDone, Ok
;     gui, add, edit, ys ym30 vthisVar, 
;     gui, add, edit, yp+30  vthatVar, 
;     gui, add, button, yp+30  gguiclose, cancel
;     gui, show, , gui in a function
;     return winexist()
    
    
    
;     Done:
        
;         {
            
;             gui, submit, nohide
            
;             ListVars
            
;             msgbox your values `nthisVar :%thisVar%`nthatVar :%thatVar%
            
;         return
        
;     }
    
    
    
;     guiclose:
        
;         {
            
;             gui, destroy
            
;             ExitApp
            
;         return
        
;     }
; }

; Gui, new

; gui, add, text, , Prefix:
; gui, add, edit, ym

; gui, add, text, , Suffix:
; gui, add, edit, ym

; Gui, Add, Button, default xm, OK  ; xm puts it at the bottom left corner.

; gui, show
; Return


Gui, Margin, 10, 10
; droplist 
    ;   Numbers
    ;   Dates
Gui, Add, DropDownList, vDirSpec w75 xm ym, Numbers||Dates

;path

; prefix
Gui, Add, Text, xp+0 yp+31 w25 +center, Prefix:
Gui, Add, Edit, xp+35 w275 vPrefixVal gPrefixTxtBox Limit255 
Gui, Add, Text, w300 vPrefixTxtBox
; suffix



;       result

; starting number

; steps of number 







; Gui, Add, Text, x26 y487 w300 h30 vTextVar, A sample text content




Gui, Add, Edit
Gui, Add, UpDown, ym vMyUpDown Range1-100,

; Gui, Add, button, yp+30 gChangeText, Testerder
Gui, Show, w320 h240

Return

; Gui, Margin, 10, 10
; Gui, Add, Text, xm ym w80 vRed, Black Text
; Gui, Add, Text, xm y+20 w80 vRed2, Black Text
; Gui, Add, Text, xm y+20 w80, Black Text
; Gui, Add, Button, xm y+20 w80 gRed, Red
; Gui, Add, Button, x+10 yp w80 gBlack, Black
; Gui, Show, AutoSize
; return

; Red:
;     GuiControl, +cDA4F49, Red
;     GuiControl,, Red, Red Text
; return

; Black:
;     GuiControl, +c000000, Red
;     GuiControl,, Red, Black Text
; return

PrefixTxtBox:
    Gui, Submit, NoHide
    ; GuiControl, +cDA4F49, Red
    GuiControl,, PrefixTxtBox, %PrefixVal%
return

GuiEscape:
GuiClose:
ButtonCancel:
ExitApp  ; All of the above labels will do this.