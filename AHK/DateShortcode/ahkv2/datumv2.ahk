#Requires AutoHotkey v2.0

; AutoHotkey v2-script voor het invoegen van de huidige datum in het formaat 03-05-2023
; wanneer "vdg" wordt ingetypt en gevolgd door een spatie of enter

hotstring("vdg", "{:}") ; Registreert een hotstring voor "vdg"

huidigeDatum() {
    datum := FormatTime("dd-MM-yyyy")
    return datum
}

OnHotstring(label) {
    if (label == "{:}") {
        SendInput(huidigeDatum())
    }
}
