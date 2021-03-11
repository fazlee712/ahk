#MaxHotkeysPerInterval 200

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
<!+::NumpadAdd

CapsLock & e::
run %editor%
return

#if A_ComputerName contains faz-pc

Capslock & a::send +#a

#if

CapsLock & F10::
run %A_AHKPath% "%A_ScriptDir%\faz-scripts.ahk"
run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
sleep 100
pMessage("Script could not be reloaded!")
return

CapsLock & F2::
Send %EmailAdd1%
return

CapsLock & r:: ; reddit RemindMe bot
InputBox ReminderData, Reminder Bot, Paste link and enter time
If Not ErrorLevel
{
	ReminderData := StrSplit(ReminderData, " ",,2)
	FinalURL := "https://reddit.com/message/compose/?to=RemindMeBot&subject=Reminder&message=`%5B" . ReminderData[1] . "`%5D`%0A`%0ARemindMe! " . ReminderData[2]
	;Run %FinalURL%
	Run % "https://reddit.com/message/compose/?to=RemindMeBot&subject=Reminder&message=`%5B" . ReminderData[1] . "`%5D`%0A`%0ARemindMe! " . ReminderData[2]
}
return

:c*:]d::
FormatTime CurrentDateTime,, d/M/yy
Send %CurrentDateTime%
return

:c*:]D::
FormatTime CurrentDateTime,, d MMMM yyyy
Send %CurrentDateTime%
return

:*:]t::
FormatTime CurrentDateTime,, H:mm
Send %CurrentDateTime%
return

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
		Run nircmd.exe setdefaultsounddevice "Speakers" 1
		Run nircmd.exe setdefaultsounddevice "Speakers" 2
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

PauseGameMode := False
chosenSpec := 

;;; SWTOR ;;;
#IfWinActive  ahk_exe swtor.exe

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

Capslock & c::
Send {CapsLock Up}
Switch A_ComputerName
{
	case "faz-pc":
		Run SCHTASKS.EXE /RUN /TN "Launch Terminal as Admin",, Hide
	case "LPBC0624":
		Run wt.exe
	default:
		Run cmd.exe
}
return

CapsLock & Left::send #^{Left}
CapsLock & Right::send #^{Right}
CapsLock & Up::send #^d
CapsLock & Down::send #^{F4}

; Open in Text Editor
CapsLock & w::
ClipSaved := ClipboardAll
Clipboard = 
Send ^c
ClipWait 0
Type := FileExist(Clipboard)
;Run % ((Type = "A" || Type = "D") ? (editor " " Clipboard) : (editor))
If Type = A
	Run `"%editor%`" `"%Clipboard%`"
Else
	Run `"%editor%`"
Clipboard := ClipSaved
return

; Volume control
CapsLock & v::
if A_ComputerName contains faz-pc,stefaz S-15,LPBC0624
	send +^!]
else
	run SndVol
return

; Force close foreground executable
CapsLock & F4::
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
CapsLock & F12::
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
	run taskkill /f /im AutoHotkeyU64.exe,, hide
	run taskkill /f /im AutoHotkeyA32.exe,, hide
	run taskkill /f /im AutoHotkeyU32.exe,, hide
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

CapsLock & s::
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
CapsLock & t::
WinGetClass Title, A
Winset Alwaysontop, , A
Winget Title, ProcessName, A
pMessage("Always-on-Top toggled for "Title)
return

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

GetMonitorActiveWindow() {
	;; Get Monitor number at the center position of the Active window.
	WinGetPos x,y,width,height, A
	return GetMonitorAtPos(x+width/2, y+height/2)
}

CapsLock & b::ToggleFakeFullscreen()