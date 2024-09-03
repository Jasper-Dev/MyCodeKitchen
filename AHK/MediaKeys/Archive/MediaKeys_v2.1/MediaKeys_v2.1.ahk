;v2.0 14:47 2-5-2020
;v2.1 04:09 18-5-2020

; Previous Song
^!Left::  ; "CTRL + ALT + LEFT"
^!F5::    ; "CTRL + ALT + F5"
Send {Media_Prev} 
return

; Play/Pause
^!Down::  ;"CTRL + ALT + DOWN"
^!F6::    ; "CTRL + ALT + F6"
Send {Media_Play_Pause}
return

; Next Song 
^!Right:: ;"CTRL + ALT + RIGHT"
^!F8::    ; "CTRL + ALT + F8"
Send {Media_Next}
return

; Mute volume
;^!0::     ;"CTRL + ALT + 0"  
;Send {Volume_Mute}
;return

; Mute volume (alternative)
Volume_Mute::
^!0::     ;"CTRL + ALT + 0"  
Send ^!{6}
Send ^!{7}
return

; Increase volume
^!=::     ;"CTRL + ALT + Equals"  
Send {Volume_Up}   
return
  
; Decrease volume
^!-::     ;"CTRL + ALT + Minus"  
Send {Volume_Down}
return

;open volume config management
^!9::     ;"CTRL + ALT + 9"  
Run C:\Windows\System32\mmsys.cpl
return
