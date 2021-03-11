;@Ahk2Exe-SetName Faz's Utility Script
;@Ahk2Exe-SetDescription by Fazlee
;@Ahk2Exe-SetVersion 26.1
;@Ahk2Exe-SetCopyright (c) 2021`, Fazlee Majeed
;@Ahk2Exe-SetOrigFilename faz-scripts.ahk

#UseHook
SendMode Input  			; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
SetTitleMatchMode RegEx

#SingleInstance Force
#MaxThreadsPerHotkey 2
#Persistent
#NoTrayIcon

Global ClipList = ["","","","",""]

OnClipboardChange("ClipChanged")

FileReadLine v_num, faz-scripts.ahk, 3
v_num := StrReplace(v_num, ";@Ahk2Exe-SetVersion ","")

FileGetTime v_date, %A_ScriptFullPath%
FormatTime v_date, v_date, d MMMM yyyy

SetCapsLockState AlwaysOff
SetNumLockState AlwaysOn

OnMessage(0x4a, "Receive_WM_COPYDATA")  ; 0x4a is WM_COPYDATA

CoordMode Mouse, Client
EnvGet doc, doc

SoundPlay %A_Windir%\media\Speech On.wav
pMessage("Faz's Utility Script v" v_num "`n" v_date "`n`nFazlee Majeed`n✉ xxxxxxx@xxxxxxxx.com",3000)

;; Get account owner to share data across devices and allow multiple users to have their own data
IniRead AccountOwner, general.ini, Account-Owners, %A_UserName%, %A_Space%
If !AccountOwner
{
	UpdateData("Account-Owners",A_UserName,"Account Owner","Please enter owner name for this account:`n`n"A_UserName,A_UserName)
	IniRead AccountOwner, general.ini, Account-Owners, %A_UserName%, %A_Space%
}

;; Load default text editor, unique to device (hardware)
IniRead editor, general.ini, Editor-exe, %A_ComputerName%, notepad.exe

i := 1
While i < 5
{
	; Read email addresses from general.ini
	VarName := "EmailAdd" . i
	IniRead %VarName%, general.ini, %AccountOwner%, email%i%, %A_Space%

	; Read street addresses from general.ini
	VarName := "Address" . i
	IniRead %VarName%, general.ini, %AccountOwner%, address%i%, %A_Space%
	StringReplace %VarName%, %VarName%, |, `n, All
	i++
}
VarName :=

;; Check for primary email and mailing address and prompt if missing
If !EmailAdd1
	UpdateData(AccountOwner,"EmailAdd1","E-Mail Address","E-mail address not foundfor this account`n`nEnter your preferred e-mail address`n`nHotkey: @@","email1")
If !Address1
	UpdateData(AccountOwner,"Address1","Main Address","Address not found for this account`nEnter your preferred main address`nUse | to indicate new line`n`nHotkey: add1","Address1")

i := 1
While i < 5
{
	; Read email addresses from general.ini
	VarName := "EmailAdd" . i
	IniRead %VarName%, general.ini, %AccountOwner%, email%i%, %A_Space%

	; Read street addresses from general.ini
	VarName := "Address" . i
	IniRead %VarName%, general.ini, %AccountOwner%, address%i%, %A_Space%
	StringReplace %VarName%, %VarName%, |, `n, All
	i++
}
VarName :=

CapsLock:: ; double tap capslock
if not dblTap("CapsLock")
	return
CapsState := GetKeyState("CapsLock", "T")
;SetCapsLockState % !GetKeyState("CapsLock", "T")
if CapsState = 0
    SetCapsLockState AlwaysOn
else
    SetCapsLockState AlwaysOff 
pMessage("Caps Lock " ((CapsState = 0) ? ("ON") : ("OFF")),500)
return

; Clipboard manager & cleanup
ExcludeList = "stadia.com"
ClipChanged(cbType) {
	; URL cleanup
	if SubStr(Clipboard, 1, 4) = "http" and not RegExMatch(Clipboard, "stadia.com")
		Clipboard := RegExReplace(Clipboard, "(?:\?|\&|\/)(?:_ga|lipi|utm|ref|cgid|ie=|t-id|igshid|ascsubtag|hc_ref|coliid|at_|_trkparms|gclid|fbclid|ncid|vero_|sr_|__|pf_rd_p|hash|feature=|skidn|ssPageName|_pos).*","")
	ClipWait
	; Push new clipboard to history (capslock & 1—5)
	if Clipboard != ClipList[1]
	{
		ClipList.Insert(1,Clipboard)
		ClipList.remove(6)
	}
	return
}

#include lib\faz-hotkeys.ahk
#include lib\faz-hotstrings.ahk
#include lib\faz-functions.ahk

#include lib\autocorrect.ahk
#include lib\Tippy.ahk
