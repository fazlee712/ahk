#MaxHotkeysPerInterval 200
#HotkeyModifierTimeout -1

SetNumLockState AlwaysOn

<!1::Numpad1
<!2::Numpad2
<!3::Numpad3
<!4::Numpad4
<!5::Numpad5
<!6::Numpad6
<!7::Numpad7
<!8::Numpad8
<!9::Numpad9
<!0::Numpad0
<!-::NumpadSub
<!+::NumpadAdd

;;;;;;;;;;;;;;;;;;;;;;;;
;;; CAPSLOCK HOTKEYS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

#If GetKeyState("Capslock", "P")

Left::send #^{Left}
Right::send #^{Right}
Up::send #^d
Down::send #^{F4}

;1::F1
;2::F2
;3::F3
;4::F4
;5::F5
;6::F6
;7::F7
;8::F8
;9::F9
;0::F10
;
;a::Home
;d::End

; Windows Terminal Quake Mode (ctrl+`)
q::^`

Backspace::Delete

F10::
run %A_AHKPath% "%A_ScriptDir%\faz-scripts.ahk"
run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
sleep 100
pMessage("Script could not be reloaded!")
return

r:: ; reddit RemindMe bot
InputBox ReminderData, Reminder Bot, Paste link and enter time
If Not ErrorLevel
{
	ReminderData := StrSplit(ReminderData, " ",,2)
	Run % "https://old.reddit.com/message/compose/?to=RemindMeBot&subject=Reminder&message=`%5B" . ReminderData[1] . "`%5D`%0A`%0ARemindMe! " . ReminderData[2]
}
;try Run menu.ahk
;try Reload
return

c::
CurrentExplorerPath := A_Desktop
if explorerHwnd := WinActive("ahk_class CabinetWClass")
{
    for window in ComObjCreate("Shell.Application").Windows
    {
        if (window.hwnd = explorerHwnd)
            CurrentExplorerPath := window.Document.Folder.Self.Path
    }
}
switch A_ComputerName
{
	case "faz-pc", "LPBC0624":
		Run % "wt --startingDirectory """ . CurrentExplorerPath . """"
	default:
		Run % ComSpec . " " . CurrentExplorerPath
}
return

; Open in Text Editor
w::
try Run % """" . editor . """ """ . Explorer_GetSelection() . """"
catch
	msgbox Error
return

e::
run %editor%
return

; Volume control
v::
if A_ComputerName contains faz-pc,stefaz S-15,LPBC0624
	send +^!]
else
	run SndVol
return

; Force close foreground executable
F4::
Winget Pname, ProcessName, A
if close_check
	close_check = 3
Else
	close_check = 1
GoSub ForceClose
return

ForceClose:
switch close_check
{
case 3:
	pMessage("Attempting to close " Pname,1000)
	close_check = 0
	SetTimer ForceClose, Off
	Process close, %Pname%
	return
case 2:
	pMessage("Not closing " Pname "!")
	close_check = 0
	SetTimer ForceClose, Off
	return
case 1:
	SoundPlay *48
	pMessage("Press CapsLock & F4`nto close " Pname,2900)
	close_check = 2
	SetTimer ForceClose, 3000
	return
default:
	close_check = 0
	SetTimer ForceClose, Off
	return
}

; kill all running AHK scripts (Win+F12) 
F12::
if close_check
	close_check = 3
Else
	close_check = 1
GoSub ForceCloseScripts
return

ForceCloseScripts:
switch close_check
{
case 3:
	pMessage("Killing all scripts!")
	Run taskkill /f /im autohotkey.exe,, hide
	Run taskkill /f /im AutoHotkeyU64.exe,, hide
	Run taskkill /f /im AutoHotkeyA32.exe,, hide
	Run taskkill /f /im AutoHotkeyU32.exe,, hide
	close_check = 0
	SetTimer ForceCloseScripts, Off
	ExitApp
	return
case 2:
	pMessage("Not closing scripts!")
	close_check = 0
	SetTimer ForceCloseScripts, Off
	return
case 1:
	SoundPlay *48
	pMessage("Close all scripts?",2900)
	close_check = 2
	SetTimer ForceCloseScripts, 3000
	return
default:
	close_check = 0
	SetTimer ForceCloseScripts, Off
	return
}

; shortcuts

s::
if A_ComputerName contains faz-pc,LPBC0624,stefaz S-15
{
	send ^{F8}
	return
}
OSversion := DllCall("GetVersion") & 0xFF
if OSVersion = 10
	Run explorer.exe ms-screenclip:
else
	Run SnippingTool.exe
return

; Always-on-Top
t::
WinGetClass Title, A
Winset Alwaysontop, , A
Winget Title, ProcessName, A
pMessage("Always-on-Top toggled for " Title)
return

b::ToggleFakeFullscreen()

#if

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END CAPSLOCK HOTKEYS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

^\::Media_Play_Pause
^[::Media_Prev
^]::Media_Next

Scrolllock::
if audio_device = Headset
{
	try 
	{
		Run nircmd.exe setdefaultsounddevice "Laptop" 1
		Run nircmd.exe setdefaultsounddevice "Laptop" 2
		Run nircmd.exe setdefaultsounddevice "Desktop" 1
		Run nircmd.exe setdefaultsounddevice "Desktop" 2
	}
	audio_device = Speakers
}
Else
{
	try
	{
		Run nircmd.exe setdefaultsounddevice "Headset" 1
		Run nircmd.exe setdefaultsounddevice "Headset" 2
	}
	audio_device = Headset
}
pMessage("Audio output: "audio_device)
return

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GAME HOTKEYS HERE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

#MaxThreadsPerHotkey 1

;;; Apex Legends ;;;
#IfWinActive ahk_exe r5apex.exe

toggle:=

F2::
Send {F1}
sleep 20
MouseMove -2,-1,R
sleep 20
Click
return

F5::
Loop 2 {
	send M
	KeyWait M
	Sleep 50
	MouseMove % (toggle:=!toggle) ? 1689 : 1843, 336
	Sleep 50
	Click
	Sleep 50
}
return

;;; SWTOR ;;;
#IfWinActive  ahk_exe swtor.exe

PauseGameMode := False
chosenSpec := 

EnergyLevel :=
PixelChkX := 
PixelChkY :=

if chosenSpec =
IniRead, chosenSpec, misc\swtor.ini, SPECS, %A_ComputerName%
if chosenSpec = ERROR
	pMessage("SPEC MODE ON")
Else
	pMessage("SPEC MODE ON — " chosenSpec)

~`::
if chosenSpec != 
{
	chosenSpec := 
	pMessage("SPEC MODE OFF")
	return
}
else
{
	IniRead, chosenSpec, misc\swtor.ini, SPECS, %A_ComputerName%
	if chosenSpec = ERROR
		pMessage("SPEC MODE ON")
	Else
		pMessage("SPEC MODE ON — " chosenSpec)
	return
}

~$Enter::
if chosenSpec != 
{
	PauseGameMode := chosenSpec
	chosenSpec := 
	pMessage("SPEC MODE PAUSED",500)
	return
}
if PauseGameMode != 
{
	chosenSpec := PauseGameMode
	PauseGameMode :=
	pMessage("SPEC MODE UNPAUSED — " chosenSpec,500)
	return
}
return

~$/::
if chosenSpec != 
{
	PauseGameMode := chosenSpec
	chosenSpec := 
	pMessage("SPEC MODE PAUSED",500)
	return
}
return

~$Escape::
if PauseGameMode != 
{
	chosenSpec := PauseGameMode
	PauseGameMode :=
	pMessage("SPEC MODE UNPAUSED — " chosenSpec,500)
	return
}
return

$1::
Switch chosenSpec
{
case "Sentinel Watchman":
	Send {F3} ; Force melt
	;Send {F4} ; Blade storm
	;Send 5 ; Cauterize
	Send {F2} ; Merciless Slash
	Send +{4} ; Zealous Strike
	Send {F1}
	Send {3} ; Blade Barrage
	Send +{5} ; Overload Saber
	Send {1} ; filler
	return
case "Shadow Kinetic":
	Send +{3}
	send {F2}	; Force potency
	/*
	PixelChkX := A_ScreenWidth / 2 - 143
	PixelChkY := 975
	PixelGetColor, EnergyLevel, PixelChkX, PixelChkY, RGB
	if EnergyLevel != 0x17547D ; Shadow Strike proc
		send 4
	*/
	send 5q
	;send +{q} 	; Spinning kick
	send +{e} 	; Slow time
	send e 		; Force breach
	;send +{f}	; Cascading Debris — only use with stacks
	send 21
	return
case "Shadow Serenity":
	Send 54q1
	return
case "Scoundrel Ruffian":
	send 5e21
	return
case "Mercenary Arsenal":
	Send {F1}
	send 51
	return
case "Vanguard Plasmatech":
	PixelChkX := A_ScreenWidth / 2 - 125
	PixelChkY := 940
	PixelGetColor, EnergyLevel, PixelChkX, PixelChkY, RGB
	if EnergyLevel = 0x00101E ; Low energy 
		send e521
	else
		send e52[1
	return	
case "Vanguard Tactics":
	PixelChkX := A_ScreenWidth / 2 - 125
	PixelChkY := 940
	PixelGetColor, EnergyLevel, PixelChkX, PixelChkY, RGB
	if EnergyLevel = 0x302F1A
		send et45[1
	else
		send et451
	return
default:
	send 1
	return
}


$2::
Switch chosenSpec
{
case "Vanguard Tactics":
	PixelGetColor, EnergyLevel, 1155, 940, RGB
	if EnergyLevel = 0x302F1A
		send 5e21
	else
		send 5e1
	return
case "Mercenary Arsenal":
	Send 2[
	return
default:
	send 2
	return
}


$3::
Switch chosenSpec
{
case "Shadow Kinetic":
	send +{3}
	send {F2}
	send e
	send +{e}
	send 3
	return
case "Mercenary Arsenal":
	;send e3
	Send 3
	return
default:
	send 3
	return
}

$WheelUp::
Switch chosenSpec
{
case "Shadow Kinetic":
	Send +{x}
	return
default:
	send {WheelUp}
	return
}

$WheelDown::
Switch chosenSpec
{
case "Shadow Kinetic":
	Send +{2}
	Send {WheelDown}
	return
case "Vanguard Tactics":
	Send +{2}
	Send {WheelDown}
default:
	send {WheelDown}
	return
}

$f::
Switch chosenSpec
{
case "Mercenary Arsenal":
	send f
	Send +{f}
	return
default:
	send f
	return
}

$r::
Switch chosenSpec
{
case "Shadow Kinetic":
	Send +{q}
	Send r
	return
default:
	send r
	return
}

#IfWinActive

#MaxThreadsPerHotkey 2

;;;;;;;;;;;;;;;;;;;;;;;;
;;; END GAME HOTKEYS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

/*
Capslock & c::
pMessage("1. " ClipList[1] "`n2. " ClipList[2] "`n3. " ClipList[3] "`n4. " ClipList[4] "`n5. " ClipList[5],3000)
return

Capslock & 1::Send % ClipList[1]
Capslock & 2::Send % ClipList[2]
Capslock & 3::Send % ClipList[3]
Capslock & 4::Send % ClipList[4]
Capslock & 5::Send % ClipList[5]
*/
