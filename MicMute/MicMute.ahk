v1.1
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

micColor := MicColor.New()
micColor.update(master_mute)

return

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
micColor.update(master_mute)

return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

class MicColor
{
    httpCookie := ""
    httpCookieExpire := ""

    New()
    {
        this.login()
        MsgBox, , , % this.httpCookie

    }

    update(master_mute)
    {
        micColor := #FFFFFF
        if (master_mute = "Off") {
            micColor := "#FF00FF00"
        } else {
            micColor := "#FFFF0000"
        }
        



        try {
            logRes := this.login()
        } catch e {
            return
        }

       ; res2 := this.sendMicColorUpdate(micColor, httpCookie)

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
            httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ", cookie)
            httpCookieExpire := (StrSplit(httpCookie, ";")[2])
            MsgBox, , % oHTTP2.status, % httpCookie 
            MsgBox, , % oHTTP2.status, % httpCookieExpire
        } catch e {
            MsgBox, , "error"
            return 
        }

        return 
    }

    
    send(micColor, httpCookie)
    {
        
        
        URL2 := "http://192.168.1.57:8080/editor/updatewidget/276/settings"
        PostData2 := "settings={widgetpref_inactivecolor: """ micColor """}"
        
        oHTTP2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP2.SetProxy(2, "localhost:63025") ; debugging purpose
        oHTTP2.Open("POST", URL2, False)
        oHTTP2.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        oHTTP2.SetRequestHeader("Referer", URL2)
        oHTTP2.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        
        oHTTP2.SetRequestHeader("cookie", httpCookie)
        
        oHTTP2.Send(PostData2)
        ;  MsgBox, , , % oHTTP2.GetLastError()
        MsgBox, , % oHTTP2.status, % httpCookie
        Gui, Add, Edit, w800 r10, % oHTTP2.GetAllResponseHeaders() httpCookie
        gui, show
        return oHTTP2
    }
}