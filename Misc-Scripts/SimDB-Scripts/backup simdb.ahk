#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

dash := new Dashboard();



class Dashboard
{
    httpCookie := "No cookies found :("
    httpCookieExpire := 0
    
    originalDash := 0

    __New(originalDash)
    {
        this.originalDash := originalDash
    }
    
    duplicateToDash(dupliDash){
        dupliDash
    }

    saveToFile(){

    }

    restoreFromFile(){

    }


    update(master_mute)
    {

        FormatTime, CurrentDate, %A_Now%
        EnvAdd, CurrentDate, 0, Seconds
        EnvSub, CurrentDate, 19700101, Seconds

        isNoCookieFound := this.httpCookie == "No cookies found :("
        isCookieExpired := CurrentDate >= this.httpCookieExpire
        if (isNoCookieFound || isCookieExpired) {   ; only login, if no cookie or if cookie expired
            this.login()
        }
        if (!isNoCookieFound && !isCookieExpired) { ; double check, in case login failed
            this.send(miconColor)
        }
        return
    }
    
    login()
    {
        URL := "http://192.168.1.57:8080/login"
        PostData := "inputPassword=sujp12"
        
        oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ;oHTTP.SetProxy(2, "localhost:8888"); debugging
        oHTTP.Open("POST", URL, false)
        oHTTP.Option(6) := False
        oHTTP.SetTimeouts(1000,1000,1000,1000)
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
            TrayTip , Mic Mute, Couldn`'t login`, dashboard probably offline, 1, 16
            this.httpCookie := "No cookies found :("
        }
        
        return
    }
    
    
    send(miconColor)
    {
        URL2 := "http://192.168.1.57:8080/editor/updatewidget/276/settings"
        PostData2 := "settings={widgetpref_inactivecolor: """ miconColor """}"
        
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