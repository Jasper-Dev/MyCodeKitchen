;v1.2-failed
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
; updateMicColor(master_mute)
;micColor := MicColor.New()
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
; updateMicColor(master_mute)
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return



class MicColor
{
 /*   class httpResponse
    {
        
        httpStatusCode[]
        {
            get {
                return this.httpStatusCode
            }
            set {
                return this.bar := value
            }
        }
        
        httpCookie[]
        {
            get {
                return this.httpStatusCode
            }
            set {
                return this.bar := value
            }
        }

        httpCookieExpire[]
        {
            get {
                return this.httpStatusCode
            }
            set {
                return this.bar := value
            }
        }
        
        New(res)
        {
            this.httpStatusCode := res.status
            this.httpCookie := res.GetResponseHeader("Set-Cookie: ", cookie)
            this.httpCookieExpire := DateParse(StrSplit(this.httpCookie, ";")[1])
            
            Gui, Add, Edit, w800 r10, %  "cookie expire: "  this.httpCookieExpire
            gui, show
        }
        
    }
    */

    New()
    {
        try {
            this.login()
        } catch e {
            ; httpResponse.New()
            Gui, Add, Edit, w800 r10, %  "Error line "  e.Line " what: " e.What " Message given: " e.Message
            gui, show
            return
        }
        this.httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ", cookie)
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
            ;logRes := this.login()
            res2 := this.sendMicColorUpdate(micColor, httpCookie)
            ;  MsgBox, , % res2.status, % res2.GetLastError
        } catch e {
            MsgBox, , "Error", % "Error at line " e.Line ", with message: " e.Message
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
        ;Post request
        oHTTP.Open("POST", URL, false)
        
        ;Add User-Agent header
        oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        ;Add Referer header
        oHTTP.SetRequestHeader("Referer", URL)
        ;Add Content-Type
        oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        ;Send POST request
        
        try {
            oHTTP.Send(PostData)
        } catch e {
            ; oHTTP.status := 408
            Gui, Add, Edit, w800 r1, %  e.Message
            ; Gui, Add, Edit, w800 r1, %  oHTTP.status
            gui, show
            ;TrayTip, % "Error line "  e.Line, % e.Message
            return oHTTP
        }
        
        ; MsgBox, , , % oHTTP.GetLastError()
        ;  MsgBox, , % oHTTP.status, % httpCookie
        return oHTTP
    }
    
    
    ; 0x80072EE2 - timeout
    ; 0x8000000A - data not available
    
    
    
    send(micColor, httpCookie)
    {
        
        
        URL2 := "http://192.168.1.57:8080/editor/updatewidget/276/settings"
        PostData2 := "settings={widgetpref_inactivecolor: """ micColor """}"
        
        oHTTP2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP2.SetProxy(2, "localhost:63025") ; debugging purpose
        ;Post request
        oHTTP2.Open("POST", URL2, False)
        ;Add User-Agent header
        oHTTP2.SetRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
        ;Add Referer header
        oHTTP2.SetRequestHeader("Referer", URL2)
        ;Add Content-Type
        oHTTP2.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        
        oHTTP2.SetRequestHeader("cookie", httpCookie)
        ;Send POST request
        
        oHTTP2.Send(PostData2)
        ;  MsgBox, , , % oHTTP2.GetLastError()
        MsgBox, , % oHTTP2.status, % httpCookie
        Gui, Add, Edit, w800 r10, % oHTTP2.GetAllResponseHeaders() httpCookie
        gui, show
        return oHTTP2
    }
}