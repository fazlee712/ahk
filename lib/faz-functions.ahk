RunGetOutput(command) {
    ComObjCreate("WScript.Shell").Run(comspec . " /c " . command . "|clip", 0, true)
    return %clipboard%
}

RunCmd(command,msg:="") {
    if StrLen(msg) > 0
        pMessage(msg)
    run %comspec% /c %command%,,hide
    return
}

gst() {   ; GetSelectedText or FilePath in Windows Explorer  by Learning one 

	IsClipEmpty := (Clipboard = "") ? 1 : 0
	if !IsClipEmpty {
		ClipboardBackup := ClipboardAll
		While !(Clipboard = "") {
			Clipboard =
			Sleep, 10
		}
	}
	Send, ^c
	ClipWait, 0.1
	ToReturn := Clipboard, Clipboard := ClipboardBackup
	if !IsClipEmpty
	ClipWait, 0.5, 1
	Return ToReturn
}

    pMessage(message,time="") {
    	Tippy(message,time) ; https://github.com/TheBestPessimist/AutoHotKey-Scripts/blob/master/lib/Tippy.ahk
    	return
    }

beep(x)
{
    SoundPlay *%x%
    return
}

UpdateData(section,var,title,message,key,inifile:="general.ini")
{
    if key = 0
        key := %A_ComputerName%
    varfunc := %var%
    InputBox value, %title%, %message%,,,,,,,,%varfunc%
        If !ErrorLevel
            IniWrite %value%, %inifile%, %section%, %key%
    return
}

dblTap(key,delay:=200) 
{
    if (A_PriorHotkey != key or A_TimeSincePriorHotkey > delay)
        return 0
    Else
        return 1
}

HexToDec(hex)
{
    VarSetCapacity(dec, 66, 0)
    , decval := DllCall("msvcrt.dll\_wcstoui64", "Str", hex, "UInt", 0, "UInt", 16, "CDECL Int64")
    , DllCall("msvcrt.dll\_i64tow", "Int64", decval, "Str", dec, "UInt", 10, "CDECL")
    return dec
}

PadNum(piNum, piCharCount)
{
	; http://msdn.microsoft.com/en-us/library/windows/desktop/ms647550
	; Calls the API's wsprintf() to pad the number
	VarSetCapacity(sRet, 20)  ; Ensure the variable is large enough to accept the new string.
	DllCall("wsprintf", "Str", sRet, "Str", "%0" . piCharCount . "d", "Int", piNum, "Cdecl")  ; Requires the Cdecl calling convention.
	return sRet
}

StringStartsWith(ByRef psText, ByRef psSearch)
{
    if (psText != "" && psSearch != "") {
        iSearchLen := StrLen(psSearch)
        if (SubStr(psText, 1, iSearchLen) == psSearch)
            return true
    }
    return false
}

StringEndsWith(ByRef psText, ByRef psSearch)
{
    if (psText != "" && psSearch != "") {
        iTextLen := StrLen(psText)
        iSearchLen := StrLen(psSearch)
        if (SubStr(psText, iTextLen + 1 - iSearchLen, iSearchLen) == psSearch)
            return true
    }
    return false
}

ArrayExtractSE(ByRef paArray, piStart, piEnd:="")
{
    aRet := []
    
    iArrayLength := paArray.Length()
    
    if (iArrayLength == 0)
        return aRet
    
    if (piStart < 1)
        piStart := 1
    else if (piStart > iArrayLength)
        piStart := iArrayLength
    
    if (piEnd == "" || piEnd == 0 || piEnd > iArrayLength)
        piEnd := iArrayLength
    else if (piEnd < 1)
        piEnd := 1
    
    iDiff := (piEnd + 1) - piStart
    
    if (iDiff > 0)
    {
        Loop, % iDiff
        {
            aRet.Push(paArray[piStart + (A_Index - 1)])
        }
    }
    
    return aRet
}

ArrayExtractL(ByRef paArray, piStart, piLen:="")
{
    aRet := []

    iArrayLength := paArray.Length()
    
    if (iArrayLength == 0)
        return aRet
    
    if (piStart < 1)
        piStart := 1
    else if (piStart > iArrayLength)
        piStart := iArrayLength
    
    if (piLen=="" || piLen==0)
    {
        iEnd := iArrayLength
    }
    else
    {
        iEnd := piStart + (piLen - 1)
        if (iEnd > iArrayLength)
            iEnd := iArrayLength
        else if (iEnd < 1)
            iEnd := 1
    }
    
    iDiff := (iEnd + 1) - piStart
    
    if (iDiff > 0)
    {
        Loop, % iDiff
        {
            aRet.Push(paArray[piStart + (A_Index - 1)])
        }
    }
    
    return aRet
}

NoFolders(list)
{
    list := StrSplit(list, "`n")
    newList := []

    for k, filename in list
    {
        if InStr(filename, ".")
            newlist.push(filename)
    }

    str := ""
    for k, v in newList
        str .= v "`n"

    return str
}

JEE_RunGetStdOut(vTarget, vSize:="")
{
    DetectHiddenWindows, On
    vComSpec := A_ComSpec ? A_ComSpec : ComSpec
    Run, % vComSpec,, Hide, vPID
    WinWait, % "ahk_pid " vPID
    DllCall("kernel32\AttachConsole", "UInt",vPID)
    oShell := ComObjCreate("WScript.Shell")
    oExec := oShell.Exec(vTarget)
    vStdOut := ""
    if !(vSize = "")
        VarSetCapacity(vStdOut, vSize)
    while !oExec.StdOut.AtEndOfStream
        vStdOut := oExec.StdOut.ReadAll()
    DllCall("kernel32\FreeConsole")
    Process, Close, % vPID
    return vStdOut
}

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    TimeOutTime := 4000  ; Optional. Milliseconds to wait for response from receiver.ahk. Default is 5000
    ; Must use SendMessage not PostMessage.
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% ; 0x4a is WM_COPYDATA.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    CopyOfData := StrGet(StringAddress)  ; Copy the string out of the structure.
    ; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:
    ;pMessage(A_ScriptName " received the following string:`n"CopyOfData,2000)
    if SubStr(CopyOfData, 1, 5) = "swtor"
		SWTOR_func(CopyOfData)
    return true  ; Returning 1 (true) is the traditional way to acknowledge this message.
}

SWTOR_func(Data)
{
    ImportedData := StrSplit(Data, "_")
    if ImportedData[4] = "SPEC"
    {
        IniWrite % ImportedData[5], misc\swtor.ini, SPECS, % ImportedData[3]
        pMessage(ImportedData[3] ": " ImportedData[5])
        chosenSpec := ImportedData[5]
    }
}

SWTOR_readSpec()
{
    IniRead, chosenSpec, misc\swtor.ini, SPECS, %A_ComputerName%
    if chosenSpec = ERROR
    {
        pMessage("SPEC MODE ON")
        return
    }
    Else
    {
        pMessage("SPEC MODE ON — " chosenSpec)
        return
    }
}

ToggleFakeFullscreen()
{
    CoordMode Screen, Window
    static WINDOW_STYLE_UNDECORATED := -0xC40000
    static savedInfo := Object() ;; Associative array!
    Winget id, ID, A
    if (savedInfo[id])
    {
        inf := savedInfo[id]
        WinSet Style, % inf["style"], ahk_id %id%
        WinMove ahk_id %id%,, % inf["x"], % inf["y"], % inf["width"], % inf["height"]
        savedInfo[id] := ""
    }
    else
    {
        savedInfo[id] := inf := Object()
        WinGet ltmp, Style, A
        inf["style"] := ltmp
        WinGetPos ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
        inf["x"] := ltmpX
        inf["y"] := ltmpY
        inf["width"] := ltmpWidth
        inf["height"] := ltmpHeight
        WinSet Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
        mon := GetMonitorActiveWindow()
        SysGet mon, Monitor, %mon%
        WinMove A,, %monLeft%, %monTop%, % monRight-monLeft, % monBottom-monTop
    }
}

GetMonitorAtPos(x,y) 
{
    ;; Monitor number at position x,y or -1 if x,y outside monitors.
    SysGet monitorCount, MonitorCount
    i := 0
    while(i < monitorCount)
    {
        SysGet area, Monitor, %i%
        if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom )
        {
            return i
        }
        i++
    }
    return -1
}

GetMonitorActiveWindow() 
{
    ;; Get Monitor number at the center position of the Active window.
    WinGetPos x,y,width,height, A
    return GetMonitorAtPos(x+width/2, y+height/2)
}

Explorer_GetSelection() {
   WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
   if (winClass ~= "Progman|WorkerW")
      oShellFolderView := GetDesktopIShellFolderViewDual()
   else if (winClass ~= "(Cabinet|Explore)WClass") {
      for window in ComObjCreate("Shell.Application").Windows
         if (hWnd = window.HWND) && (oShellFolderView := window.document)
            break
   }
   else
      Return
   
   for item in oShellFolderView.SelectedItems
      result .= (result = "" ? "" : "`n") . item.path
   if !result
      result := oShellFolderView.Folder.Self.Path
   Return result
}

GetDesktopIShellFolderViewDual() 
{
    IShellWindows := ComObjCreate("{9BA05972-F6A8-11CF-A442-00A0C90A8F39}")
    desktop := IShellWindows.Item(ComObj(19, 8)) ; VT_UI4, SCW_DESKTOP                
   
    ; Retrieve top-level browser object.
    if ptlb := ComObjQuery(desktop
        , "{4C96BE40-915C-11CF-99D3-00AA004AE837}"  ; SID_STopLevelBrowser
        , "{000214E2-0000-0000-C000-000000000046}") ; IID_IShellBrowser
    {
        ; IShellBrowser.QueryActiveShellView -> IShellView
        if DllCall(NumGet(NumGet(ptlb+0)+15*A_PtrSize), "ptr", ptlb, "ptr*", psv) = 0
        {
            ; Define IID_IDispatch.
            VarSetCapacity(IID_IDispatch, 16)
            NumPut(0x46000000000000C0, NumPut(0x20400, IID_IDispatch, "int64"), "int64")
           
            ; IShellView.GetItemObject -> IDispatch (object which implements IShellFolderViewDual)
            DllCall(NumGet(NumGet(psv+0)+15*A_PtrSize), "ptr", psv
                , "uint", 0, "ptr", &IID_IDispatch, "ptr*", pdisp)
           
            IShellFolderViewDual := ComObjEnwrap(pdisp)
            ObjRelease(psv)
        }
        ObjRelease(ptlb)
    }
    return IShellFolderViewDual
}

IfMod(BaseAction) ; Allows modifiers with chords (a & b::)
{
    if GetKeyState("Shift", "P")
        ModKeys .= "+"
    if GetKeyState("Ctrl", "P")
        ModKeys .= "^"
    if GetKeyState("Alt", "P")
        ModKeys .= "!"
    send % ModKeys . BaseAction
}

isCursorShown()
{
StructSize := A_PtrSize + 16
VarSetCapacity(InfoStruct, StructSize)
NumPut(StructSize, InfoStruct)
DllCall("GetCursorInfo", UInt, &InfoStruct)
Result := NumGet(InfoStruct, 8)
if Result > 1
    Return 1
else
    Return 0
}

#include lib\Tippy.ahk
