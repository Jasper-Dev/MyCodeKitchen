hotkey, $pgDn, keyDelayer
hotkey, $pgUp, keyDelayer

keyDelayer:
    sleep 1000
    thisHotkey := regExReplace(a_thisHotkey, "[^0-9A-Za-z]")
    while getKeyState(thisHotkey, "p")
        send {%thisHotkey%}
return