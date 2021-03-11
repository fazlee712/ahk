;===============================================================================
; Double Tap detection function by the GroggyOtter
; Syntax:
;   DblTap(key [, delay])
;   Key         = Designed to use A_ThisHotkey or, in some situations, A_Label
;   Delay (ms)  = Optional. Max time to register a double tap
; Use:
;   Put DblTap(A_ThisHotkey) anywhere in the body of your hotkey
; Return:
;   Function returns 1 for double tap, 0 if not double tap
; Remarks:
;   ErrorLevel is set to the letter of the key that was matched, if any
;===============================================================================
DblTap(hk, delay:=300){
    ; Track last hotkey pressed
    static  lastKey
    ; Track when last hotkey was pressed
    static  lastKeyTime
    ; Array of all hotkey modifiers
    static  modA        := ["#","!","^","+","<",">","*","~","$"]
    ; Time when hotkey was fired
    thisKeyTime := A_TickCount
    ; Result of double tap
    result              := false
    ; Tracks key when stripping modifiers
    thisKey             := ""
    ; Tracks if hotkey was fired using the up event
    isUp    := (RegExMatch(hk, "i)^.*?\s+Up\s*$") > 0) ? " Up" : ""

    ; Strip Up suffix and white space
    hk      := RegExReplace(hk, "i)^\s*(.*)\s+Up\s*$", "$1")
    ; Get last character
    lastChr := SubStr(hk, 0)
    ; Loop through modifier array
    for index, modifier in modA
        ; Check if lastChr matches the modifier. If yes, then lastChr is the actual key
        if (lastChr = modifier)
            thisKey := lastChr

    ; If thisKey is still blank
    if (thisKey = ""){
        ; Parse through it 1 chr a time
        Loop, Parse, hk
        {
            ; Loop through modifier array and compare the chr to each modifier
            for index, modifier in modA
            {
                ; If there's a match, break loop to skip recording and go to next chr
                if (A_LoopField = modifier){
                    Break
                ; If you get to the last loop iteration and a mod match hasn't happened, add letter to thisKey
                }Else if (A_Index = modA.Length()){
                    thisKey .= A_LoopField
                }
            }
        }
    }

    ; Check if the current key matches the last key.
    ; Time since last hotkey must be less than the max delay
    if ((thisKey . isUp) = lastKey) && ((thisKeyTime - lastKeyTime) < delay)
        ; If yes, set result of double tap to true
        result  := true

    ; Wait for key to be released before updating everything
    KeyWait, % thisKey, % ((isUp = "") ? "D" : "")

    ; Set error level to the key that was used this time
    ErrorLevel  := thisKey . isUp

    ; Update lastKey to thisKey
    lastKey     := thisKey . isUp
    ; Update last hotkey time
    ; If double tap happened, reset time to 0 else update to current tick
    lastKeyTime := ((result = true) ? 0 : A_TickCount)

    ; Return double tap result
    return result
}