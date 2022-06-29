;v1.4
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SoundGet, master_mute, , mute, 5
if (master_mute = "Off") {
    Menu, Tray, Icon, Icons/microphone-solid-color.ico, , 1
} else {
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico, , 1
}

Global micColor := New MicColor(master_mute)
;return

^!`:: ;ctrl+alt+` ;<s> Shift Pause Break button is my chosen hotkey </s>
SoundSet, +1, MASTER, mute, 5 ;5 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 5's  <---------IMPORTANT
SoundGet, master_mute, , mute, 5

;ComObjCreate("wscript.shell").SendKeys(Chr(0xAD))

if (master_mute = "Off") {
    ToolTip, Mic On ✔
    SoundPlay, Sounds/unmute.wav
    Menu, Tray, Icon, Icons/microphone-solid-color.ico, , 1
} else {
    ToolTip, Mic Off ❌
    SoundPlay, Sounds/mute.wav
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico, , 1
}



;ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle
SetTimer, RemoveToolTip, 1000

;MsgBox, , , %  "mute is: " master_mute " "
micColor.update(master_mute)

return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return


class MicColor
{
    httpCookie := ""
    httpCookieExpire := 0
    
    __New(master_mute)
    {
        ;MsgBox, , , % this.httpCookieExpire  "   "

        this.update(master_mute)
        
        ;MsgBox, , , % this.httpCookieExpire "   " ; TimeFormat(this.httpCookieExpire, "yyyy-dd-MM HH:mm:ss")
    }
    
    update(master_mute)
    {
        ;MsgBox, , , % "called"
        miconColor  := #FFFFFFFF
        if (master_mute = "Off") {
            miconColor := "#FF00FF00"
        } else {
            miconColor := "#FFFF0000"
        }
        
        FormatTime, CurrentDate, %A_Now%
        EnvAdd, CurrentDate, 0, Seconds
        EnvSub, CurrentDate, 19700101, Seconds
        
        if (CurrentDate >= this.httpCookieExpire) {
            ;MsgBox, , , % "login & send"
            ;MsgBox, , , % "before login" this.httpCookie
            this.login()
            ;MsgBox, , , % "after login" this.httpCookie
            ;MsgBox, , , % "before send" this.httpCookie
            this.send(miconColor)
            ;MsgBox, , , % "after send" this.httpCookie
        } else {
            ;MsgBox, , , % "send"
            ;MsgBox, , , % "before send" this.httpCookie
            this.send(miconColor)
            ;MsgBox, , , % "after send" this.httpCookie
        }
        

        return
    }
    
    login()
    {
        URL := "http://192.168.1.57:8080/login"
        PostData := "inputPassword=sujp12"
        
        oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP.SetProxy(2, "localhost:8888"); debugging
        oHTTP.Option(6) := False
        oHTTP.Open("POST", URL, false)
        oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        oHTTP.SetRequestHeader("Referer", URL)
        oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        
        try {
            oHTTP.Send(PostData)
            this.httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ", cookie)
            
            FormatTime, TomorrowsDate, %A_Now%
            EnvAdd, TomorrowsDate, 0, Seconds
            EnvAdd, TomorrowsDate, 1, Days
            EnvSub, TomorrowsDate, 19700101, Seconds
            this.httpCookieExpire := TomorrowsDate
        } catch e {
            MsgBox, , "error"
            return
        }
        
        return
    }
    
    
    send(miconColor)
    {
        URL2 := "http://192.168.1.57:8080/editor/updatewidget/276/settings" ;276 ;
        PostData2 := "settings={widgetpref_inactivecolor: """ miconColor """}"
        ;M19,11C19,12.19 18.66,13.3 18.1,14.28L16.87,13.05C17.14,12.43 17.3,11.74 17.3,11H19M15,11.16L9,5.18V5A3,3 0 0,1 12,2A3,3 0 0,1 15,5V11L15,11.16M4.27,3L21,19.73L19.73,21L15.54,16.81C14.77,17.27 13.91,17.58 13,17.72V21H11V17.72C7.72,17.23 5,14.41 5,11H6.7C6.7,14 9.24,16.1 12,16.1C12.81,16.1 13.6,15.91 14.31,15.58L12.65,13.92L12,14A3,3 0 0,1 9,11V10.28L3,4.27L4.27,3Z
        oHTTP2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP2.SetProxy(2, "localhost:63025") ; debugging purpose
        oHTTP2.Open("POST", URL2, False)
        oHTTP2.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        oHTTP2.SetRequestHeader("Referer", URL2)
        oHTTP2.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        oHTTP2.SetRequestHeader("cookie", this.httpCookie)
        
        try {
            oHTTP2.Send(PostData2)
        } catch e {
            MsgBox, , "error2"
            return
        }

        return
    }
}


