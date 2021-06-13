SetTitleMatchMode Regex

GroupAdd NagWindows, ahk_class #32770
GroupAdd NagWindows, ahk_class RarReminder

SetTimer, Nags, 30

; Watch for nag screens
Nags:
    IfWinActive ahk_group, NagWindows
        WinClose
Return