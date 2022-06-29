#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

/*
showWindow(1st, 2nd, 3rd, 4th, 5th){
Gui, Add, Button, vLogin, login
Gui, Show
return
}
*/

InputBox, objective, objective, Enter objective.
if ErrorLevel
    ExitApp
else
    sendData(objective)
return

sendData(objective)
{
    URL := "http://192.168.1.57:8080/login"
    PostData := "inputPassword=sujp12"
    
    oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    ;oHTTP.SetProxy(2, "localhost:63025")
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
    oHTTP.Send(PostData)
    ;Get received data
    httpCookie := oHTTP.GetResponseHeader("Set-Cookie: ", cookie)
    
    
    /*
    ;Gui, Add, Edit, w800 r15, % oHTTP.setcoo
    Gui, Add, Text, , login
    Gui, Add, Edit, w800 r1, % oHTTP.status " " oHTTP.statusText
    Gui, Add, Edit, w800 r10, % oHTTP.GetAllResponseHeaders()
    Gui, Add, Edit, w800 r2, % httpCookie
    Gui, Add, Edit, w800 r15, % oHTTP.ResponseText
    
    ;return __SESSION_ID__
    ;return
    */
    
    ;setObjective(){
    
    ;objective := "test"
    URL2 := "http://192.168.1.57:8080/editor/updatewidget/310/settings"
    PostData2 := "settings={widgetpref_text: """ objective """}"
    
    oHTTP2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    ;oHTTP2.SetProxy(2, "localhost:63025")
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
    ;Get received data
    /*
    Gui, Add, Text, , change objective
    Gui, Add, Edit, w800 r1, % oHTTP2.status " " oHTTP2.statusText
    Gui, Add, Edit, w800 r5, % oHTTP2.GetAllResponseHeaders()
    Gui, Add, Edit, w800 r30, % oHTTP2.ResponseText
    Gui, Show
    */
    return
}

GuiClose:
    ExitApp
    