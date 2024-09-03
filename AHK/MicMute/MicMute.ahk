;v1.5.2
; - Changed micId and audioCable to match with id's on PC

;
; TODO v1.6: 
; - change micId variable to MIC_ID variable
; - change audioCable variable to VIRTUAL_CABLE_ID variable
; - make MIC_ID and VIRTUAL_CABLE_ID variables configurable via tray icon
; - open sound control panel via tray menu
; - figure out a way to keep the mic ID up to date
; - Have the callout in an async method to avoid program hang on quick unmute/mute action
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#InstallKeybdHook
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

micId := 7
audioCable := 8

SoundGet, master_mute, , mute, micId
if (master_mute = "Off") {
    Menu, Tray, Icon, Icons/microphone-solid-color.ico, , 1
} else {
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico, , 1
}

Global micColor := New MicColor(master_mute)
;return

^!`:: ;ctrl+alt+` ;<s> Shift Pause Break button is my chosen hotkey </s>
SoundSet, +1, MASTER, mute, micId ;5 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 5's  <---------IMPORTANT
SoundSet, +1, MASTER, mute, audioCable
SoundGet, master_mute, , mute, micId

;ComObjCreate("wscript.shell").SendKeys(Chr(0xAD))

if (master_mute = "Off") {
    ToolTip, Mic On ✔
    ;SoundPlay, Sounds/unmute.wav
    Menu, Tray, Icon, Icons/microphone-solid-color.ico, , 1
} else {
    ToolTip, Mic Off ❌
    ;SoundPlay, Sounds/mute.wav
    Menu, Tray, Icon, Icons/microphone-slash-solid-color.ico, , 1
}

;ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle
SetTimer, RemoveToolTip, 1000

;micColor.update(master_mute)
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

class MicColor
{
    httpCookie := "No cookies found :("
    httpCookieExpire := 0
    
    __New(master_mute)
    {
        this.update(master_mute)
    }
    
    update(master_mute)
    {
        miconColor  := "#FFFFFFFF"
        if (master_mute = "Off") {
            miconColor := "#FF00FF00"
        } else {
            miconColor := "#FFFF0000"
        }
        
        FormatTime, CurrentDate, %A_Now%
        EnvAdd, CurrentDate, 0, Seconds
        EnvSub, CurrentDate, 19700101, Seconds

        isNoCookieFound := this.httpCookie == "No cookies found :("
        isCookieExpired := CurrentDate >= this.httpCookieExpire
        if (isNoCookieFound || isCookieExpired) {   ; login, if no cookie found or if found cookie expired
            this.login()
        }
        if (!isNoCookieFound && !isCookieExpired) { ; double check, in case login failed
            this.send(miconColor)
        }
        return
    }
    
    login()
    {
        ;URL := "http://192.168.1.111:8080/login"
        ;PostData := "inputPassword=sujp12"
	
	URL := "http://192.168.1.113:8080/login"
        PostData := "inputPassword=274o5y"
        
        oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP.SetProxy(2, "localhost:63025") ; debugging
        oHTTP.Open("POST", URL, false)
        oHTTP.Option(6) := False
        oHTTP.SetTimeouts(1000,1000,1000,1000)
        oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        oHTTP.SetRequestHeader("Referer", URL)
        oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        
        try {
            oHTTP.Send(PostData)
            this.httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ")

            ;Gui, Add, Edit, w800 r10, % this.httpCookie
	    ;Gui, Add, Edit, w800 r10, % oHTTP.GetResponseHeader("Set-Cookie: ")
            ;gui, show

            FormatTime, TomorrowsDate, %A_Now%
            EnvAdd, TomorrowsDate, 0, Seconds
            EnvAdd, TomorrowsDate, 1, Days
            EnvSub, TomorrowsDate, 19700101, Seconds
            this.httpCookieExpire := TomorrowsDate
        } catch e {
            TrayTip , Mic Mute, Couldn`'t login`, dashboard probably offline, 1, 16
            this.httpCookie := "No cookies found :("
        }
        
        return
    }
    
    
    send(miconColor)
    {
        ;URL2 := "http://192.168.1.111:8080/editor/updatewidget/276/settings"
        ;URL2 := "http://192.168.1.113:8080/editor/updatewidget/821/settings"
	URL2 := "http://192.168.1.113:8080/editor/updatewidget/989/settings"
	PostData2 := "settings={widgetpref_inactivecolor: """ miconColor """}" 
	;todo: send different svg path based on mic status :P
        
        oHTTP2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP2.SetProxy(2, "localhost:63025") ; debugging purpose
        oHTTP2.Open("POST", URL2, False)
        oHTTP2.SetTimeouts(1000,1000,1000,1000)
        oHTTP2.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        oHTTP2.SetRequestHeader("Referer", URL2)
        oHTTP2.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        oHTTP2.SetRequestHeader("cookie", this.httpCookie)
        
        try {
            oHTTP2.Send(PostData2)
        } catch e {
            TrayTip , Mic Mute,  Couldn`'t update icon`, dashboard probably offline, 1 , 16
            return
        }
        return
    }
}

