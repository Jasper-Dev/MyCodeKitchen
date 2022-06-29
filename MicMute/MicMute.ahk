;v1.3
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
        
        MsgBox, , , % this.httpCookieExpire "   " ;TimeFormat(this.httpCookieExpire, "yyyy-dd-MM HH:mm:ss")
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
            ; logRes := this.login()
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
            this.httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ", cookie)
            
            
            ;FormatTime, CurrentDate, %A_NowUTC%,, yyyyMMddHHmmss ;GMT 00:00
            Now := %A_Now%
            FormatTime, CurrentDate, Now ;, %A_NowUTC%             TomorrowsDate := CurrentDate
            EnvAdd, CurrentDate, 0, Seconds
            EnvSub, CurrentDate, 19700101, Seconds

            FormatTime, TomorrowsDate, Now
            EnvAdd, TomorrowsDate, 0, Seconds
            EnvAdd, TomorrowsDate, 1, Days
            EnvSub, TomorrowsDate, 19700101, Seconds
            
            ; EnvAdd, CurrentDate, 4, Hours ;GMT +04:00
            ;MsgBox, % CurrentDate " " TomorrowsDate
            
            currentEpoch := EnvSub, A_NowUTC, 1970, seconds
            this.httpCookieExpire := TomorrowsDate
            
            ; DateParse(StrDelLeft(StrSplit(this.httpCookie, ";")[2], 9))
            ; MsgBox, , % oHTTP2.status, % this.httpCookie
            ; MsgBox, , % oHTTP2.status, % this.httpCookieExpire
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
        ; MsgBox, , % oHTTP2.status, % httpCookie
        Gui, Add, Edit, w800 r10, % oHTTP2.GetAllResponseHeaders() httpCookie
        gui, show
        return oHTTP2
    }
}

TimeFormat(timestamp, format)
{
    ;yyyy-dd-MM HH:mm:ss
    FormatTime, formatted, timestamp, % format
    return formatted
}

StrDelLeft(str, charCount)
{
    StringTrimLeft, output, str, charCount
    return output
}

DateParse(str)
{
    static e2 = "i)(?:(\d{1, 2}+)[\s\.\-\/, ]+)?(\d{1, 2}|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\w*)[\s\.\-\/, ]+(\d{2, 4})"
    str := RegExReplace(str, "((?:" . SubStr(e2, 42, 47) . ")\w*)(\s*)(\d{1, 2})\b", "$3$2$1", "", 1)
    if RegExMatch(str, "i)^\s*(?:(\d{4})([\s\-:\/])(\d{1, 2})\2(\d{1, 2}))?"
    . "(?:\s*[T\s](\d{1, 2})([\s\-:\/])(\d{1, 2})(?:\6(\d{1, 2})\s*(?:(Z)|(\+|\-)?"
    . "(\d{1, 2})\6(\d{1, 2})(?:\6(\d{1, 2}))?)?)?)?\s*$", i)
    d3 := i1, d2 := i3, d1 := i4, t1 := i5, t2 := i7, t3 := i8
    Else If !RegExMatch(str, "^\W*(\d{1, 2}+)(\d{2})\W*$", t)
    RegExMatch(str, "i)(\d{1, 2})\s*:\s*(\d{1, 2})(?:\s*(\d{1, 2}))?(?:\s*([ap]m))?", t)
    , RegExMatch(str, e2, d)
    f = %A_FormatFloat%
    SetFormat, Float, 02.0
    d := (d3 ? (StrLen(d3) = 2 ? 20 : "") . d3 : A_YYYY)((d2 := d2 + 0 ? d2 : (InStr(e2, SubStr(d2, 1, 3)) - 40) // 4 + 1.0) > 0 ? d2 + 0.0 : A_MM)((d1 += 0.0) ? d1 : A_DD) . t1 + (t1 = 12 ? t4 = "am" ? -12.0 : 0.0 : t4 = "am" ? 0.0 : 12.0) t2 + 0.0 . t3 + 0.0
    SetFormat, Float, % f
    Return, d
}