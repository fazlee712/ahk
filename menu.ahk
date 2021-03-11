	;#Warn
	#UseHook
	#Persistent
	#SingleInstance Force

	SendMode Input

	tempDir := A_Temp . "\faz-scripts\"
	IfNotExist %tempDir%
	    FileCreateDir %tempDir%

	try FileDelete %tempdir%\cmdout
	try FileDelete %tempdir%\telnet

	#include lib\faz-functions.ahk
	#include lib\RunAsTask.ahk

	if A_ComputerName contains faz-pc
		Menu Tray, NoIcon
	else
	{
		Menu Tray, Icon, Resources\faz-icon.ico
		Menu Tray, Tip , Faz's Utility Script
		Menu Tray, Add
		Menu Tray, Add, Show Menu, ShowMenu
		Menu Tray, Default, Show Menu
	}

	DetectHiddenWindows, On

	SetTimer ScriptHelper, -500

	TargetScriptTitle := "faz-scripts.ahk ahk_class AutoHotkey"
	workPC := "xxxxxxxxxxxx"
	puttyapp := "kitty"

	jAction :=
	jData :=

	IniRead editor, general.ini, Editor-exe, %A_ComputerName%, notepad.exe
	FileReadLine pwd, misc\p, 1

	TSFolder := 
	if A_ComputerName contains %workPC%
		TSFolder := "D:\Drive\XXXXXXXXXXXX Group\Time Sheet\" A_YYYY
	else
		TSFolder := A_MyDocuments "\XXXXXXXXXXXX Group\Time Sheet\" A_YYYY

	FileReadLine vNum, faz-scripts.ahk, 3
	vNum := StrReplace(vNum, ";@Ahk2Exe-SetVersion ","")
	Title := "Faz's Utility Script v" vNum 

	added_swtor := 0

	Menu SM, Add, %Title%, ReloadScript
	Menu SM, Icon, %Title%, Resources\faz-icon.ico
	Menu SM, Add

	Menu SM_Tools, Add, Kill Current App, Tools_KillApp
	Menu SM_Tools, Add, Restart Explorer, Tools_RestartExplorer
	Menu SM_Tools, Add, Flush DNS, Tools_RunFlushDNS
	Menu SM_Tools, Add, IP Address, Tools_GetIP
	Menu SM_Tools, Add
	Menu SM_Tools, Add, Task Manager, Tools_RunTM
	Menu SM_Tools, Add, Resource Monitor, Tools_RunResmon
	Menu SM_Tools, Add, Command Prompt, Tools_RunCMD
	Menu SM_Tools, Add, Control Panel, Tools_RunCP
	Menu SM_Tools, Add
	Menu SM_Tools, Add, Hex to Decimal, Tools_HexToDec
	Menu SM_Tools, Add, Decimal to Hex, Tools_DecToHex
	if A_ComputerName contains faz-pc,%workPC%
	{
		Menu SM_Tools, Add
		Menu SM_Tools, Add, Edit Hotkeys, EditHotkeys
		Menu SM_Tools, Add, Edit Script, EditScript
		Menu SM_Tools, Add, Edit Menu, EditMenu

		Menu SM, Add, 2-Factor Auth, Open_2FA
		Menu SM, Add, WiFi Hotspot, ToggleHotspot
		Menu SM, Icon, Wifi Hotspot, Resources\hotspot.ico
		Menu SM, Add, Connect Pixel Buds to Phone, ConnectBuds
		Menu SM, Icon, Connect Pixel Buds to Phone, Resources\buds.ico
	}
	Menu SM, Add, Editor, Run_Editor
	Menu SM, Icon, Editor, Resources\editor.ico
	Menu SM, Add, Tools, :SM_Tools

	if A_ComputerName contains faz-pc,%workPC%
	{
		if A_ComputerName contains %workPC%
			work_menuName := "SM"
		Else
			work_menuName := "SM_work"

		if A_ComputerName contains %workPC%
			Menu %work_menuName%, Add
		Menu %work_menuName%, Add, %A_ComputerName%, Work_OpenTSFolder
		Menu %work_menuName%, Add
		Menu %work_menuName%, Add, Remote Access, Work_RemoteAccess
		Menu %work_menuName%, Icon, Remote Access, Resources\parsec.ico
		Menu %work_menuName%, Add, AnyDesk, Work_AnyDesk
		Menu %work_menuName%, Icon, AnyDesk, Resources\anydesk.ico
		Menu %work_menuName%, Add
		Menu %work_menuName%, Add, Timesheet, Work_Timesheet
		;Menu %work_menuName%, Icon, Time Sheet, Resources\clock.ico
		Menu %work_menuName%, Add, Work Expenses, Work_Expenses
		;Menu %work_menuName%, Icon, Work Expenses, Resources\expense.ico
		Menu %work_menuName%, Add, Email Files, Work_EmailFiles
		;Menu %work_menuName%, Icon, Email Files, Resources\email.ico
		if A_ComputerName contains %workPC%
		{
			Menu %work_menuName%, Add
			Menu %work_menuName%, Add, eDocs, Work_eDocs
			Menu %work_menuName%, Add, Service Now, Work_ServiceNow
			Menu %work_menuName%, Add
			Menu %work_menuName%, Add, Cisco VPN, Work_VPN
			Menu %work_menuName%, Icon, Cisco VPN, Resources\cisco.ico

			Menu SM_work_PuTTY, Add, Open PuTTY, Work_Putty
			Menu SM_work_PuTTY, Add 
			Menu SM_work_PuTTY, Add, CACS, Work_CACS
			Menu SM_work_PuTTY, Add
			Loop, read, misc\putty
			{
				if A_Index > 1
				{
					ProjectName := StrSplit(A_LoopReadLine, "=")
					ProjectName := ProjectName[1]
					Menu SM_work_PuTTY, Add, %ProjectName%, Work_PuttyConnect
					CustomerList := "belk,fedex,levi,gap"
					Loop, parse, CustomerList, `,
					{
						if ProjectName contains %A_Loopfield%
							try Menu SM_work_PuTTY, Icon, %ProjectName%, Resources\%A_Loopfield%.ico
					}
				}
			}
			Menu SM_work_PuTTY, Add
			Menu SM_work_PuTTY, Add, Add Connection, Work_PuttyAdd
			Menu SM_work_PuTTY, Add, Edit Connections, Work_PuttyEdit
			Menu %work_menuName%, Add, PuTTY, :SM_work_PuTTY
			Menu %work_menuName%, Icon, PuTTY, Resources\putty.ico
		}

		Menu %work_menuName%, Add, RDP, Work_RDP
		Menu %work_menuName%, Add, FTP, Work_FTP
		Menu %work_menuName%, Add
		Menu %work_menuName%, Add, Update Password, Work_UpdatePassword
		Menu %work_menuName%, Icon, Update Password, Resources\password.ico
		;Menu %work_menuName%, Icon, Update Password, Resources\shell32\2391.ico

		try Menu SM, Add, Work, :SM_work 	; Add 'Work' menu item if not on work device
		if A_ComputerName contains %workPC%
			Menu SM, Icon, %A_ComputerName%, Resources\XXXXXXXXXXXX.ico
		Else
			Menu SM, Icon, Work, Resources\XXXXXXXXXXXX.ico
	}

	;GoSub ScriptHelper

	;LAlt & `::
	!Capslock::
	GoSub ShowMenu
	return

	EditHotkeys:
	Run %editor% lib\faz-hotkeys.ahk
	return

	EditScript:
	Run %editor% faz-scripts.ahk
	return

	EditMenu:
	Run %editor% menu.ahk
	return

	ScriptHelper:
	WinGet wList, List, ahk_class AutoHotkey
	if wList < 2
	{
		run %A_AHKPath% "%A_ScriptDir%\faz-scripts.ahk"
		run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
	}
	return

	UpdateScript:
	run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
	run %A_AHKPath% "%A_ScriptDir%\faz-scripts.ahk"
	return

	ReloadScript:
	pMessage("Reloading script!")
	run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
	run %A_AHKPath% "%A_ScriptDir%\faz-scripts.ahk"
	return

	ReloadMenu:
	run %A_AHKPath% "%A_ScriptDir%\menu.ahk"
	return

	DoNothing:
	return

	Tools_KillApp:
	WinGet active_id, ProcessName, A
	run taskkill /f /im %active_id%,,Hide
	return

	Tools_RestartExplorer:
	run taskkill /f /im explorer.exe,,Hide
	sleep 2000
	run explorer.exe
	return

	Tools_RunTM:
	run taskmgr.exe
	return

	Tools_RunResmon:
	run resmon.exe
	return

	Tools_RunCP:
	run Control
	return

	Tools_RunCMD:
	Run *RunAs %comspec%
	return

	Tools_RunFlushDNS:
	run *RunAs %comspec% /c "netsh winsock reset"
	run *RunAs %comspec% /c "ipconfig /flushdns"
	return

	Tools_HexToDec:
	InputBox HexVal, Hex to Decimal, Input Hex value
	MsgBox % "Hex : " HexVal "`nDec : " RunGetOutput("py lib\HexDec.py " HexVal)
	return

	Tools_DecToHex:
	InputBox DecVal, Decimal to Hex, Input Decimal value
	MsgBox % "Dec : " DecVal "`nHex : " RunGetOutput("py lib\DecHex.py " DecVal)
	return

	Tools_GetIP:
	pMessage("Getting IP address...",5000)
	IPaddress := RunGetOutput("curl ifconfig.me")
	Clipboard := IPaddress
	pMessage("IP address:`n" IPaddress,5000)
	return

	ToggleHotspot:
	jMessage := "Toggling Hotspot on phone..."
	jAction := "text=jointextpush"
	GoSub JoinCommand
	return

	ConnectBuds:
	jMessage := "Connecting earbuds to phone..."
	jAction := "text=ConnectBuds"
	GoSub JoinCommand
	return

	Open_2FA:
	jMessage := "Launching Google Authenticator on phone..."
	jAction := "appPackage=com.google.android.apps.authenticator2"
	GoSub JoinCommand
	return

	Run_Editor:
	run %editor%
	return

	JoinCommand:
	    IniRead JoinAPI, general.ini, API, %A_ComputerName%
	    IniRead DeviceID, general.ini, DeviceID, %A_ComputerName%
	    url := "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?" jAction "&deviceId=" DeviceID "&apikey=" JoinAPI
	    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	    whr.Open("POST", url, true)
	    whr.Send(Data)
	    if jMessage <> ""
	    	pMessage(jMessage,3000)
	    jMessage := 
	    jAction :=
	    url :=
	    ; whr :=
	return

	;;;;;;;;;;;;;;;;;;;;;;;;
	;;; WORK SUBROUTINES ;;;
	;;;;;;;;;;;;;;;;;;;;;;;;

	Work_OpenTSFolder:
	run %TSFolder%
	return

	Work_RemoteAccess:
	run % "C:\Program Files\Parsec\parsecd.exe " ((A_ComputerName = "faz-pc") ? ("peer_id=1iF6Jm7zPdsc0fx3c1ndvoI5MEK") : ("peer_id=1iIUAtdvcAlUOrp1OpogjPpLxmf"))
	return

	Work_AnyDesk:
	run % "C:\Program Files (x86)\AnyDesk\AnyDesk.exe " ((A_ComputerName = "faz-pc") ? ("faz.bc@ad") : ("faz.pc@ad"))
	return

	Work_Timesheet:
	WKnum := regexreplace(substr(A_YWeek,5),"^0","")
	InputBox WKnum, Week Number, Enter week number to retrieve,,,,,,,,%WKnum%
	TSFile := "WK" WKnum "_" substr(A_YYYY,3) "_TS_FM.xlsm"
	if ErrorLevel
		Return
	Else
		run %TSFolder%\%TSFile%
	Return

	Work_EmailFiles:
	WKnum :=
	FileSelectFile, list, M, %TSFolder%, Select files to attach
	if ErrorLevel
		Return

	try
		m := ComObjActive("Outlook.Application")
	catch
		m := ComObjCreate("Outlook.Application")
	m := m.CreateItem(0)

	;m := ComObjActive("Outlook.Application").CreateItem(0)
	m.To := "xxxxxxxxxx@XXXXXXXXXXXX.com"
	m.CC := "xxxxxxxxx@xxxxxxxx.com"
	m.Body := "xxxxxx"
	Loop parse, list, `n
	{
		if A_Index != 1
		{
			m.Attachments.Add(TSFolder "\" A_LoopField)
			if WKnum < 1
				WKnum := StrReplace(SubStr(A_LoopField, 3, 2),"_","")
		}
	}
	m.Subject := "Timesheet — week " WKnum ", " A_YYYY
	m.Display
	return

	Work_Expenses:
	ERFile := "WKxx_" substr(A_YYYY,3) "_ER_FM.xlsx"
	run %TSFolder%\%ERFile%
	Return

	Work_eDocs:
	run "D:\eDocs"
	return

	Work_ServiceNow:
	run "https://XXXXXXXXXXXX.service-now.com"
	return

	Work_VPN:
	run taskkill /f /im vpnui.exe,, hide
	sleep 1000
	run "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe", "C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\"
	WinWait ahk_exe vpnui.exe, Please enter your username and password, 5
	if ErrorLevel
		msgbox Timed Out
	else 
		Send %pwd%{Enter}
	return

	Work_CACS:
	try FileDelete %tempDir%\telnet
	run %puttyapp% -load "CACS",, UseErrorLevel, puttyPID
	WinWait ahk_pid %puttyPID%
	SetTimer telnet_loop, 200
	CACS_state := "username"
	telnet_wait := 25
	Return

	telnet_loop:
	telnet_wait -= 1
	FileRead telnetout, %tempDir%\telnet
	if InStr(telnetout,"Welcome") or telnet_wait < 1
	{
		run taskkill /f /pid %puttyPID%,,Hide
		FileDelete %tempDir%\telnet
		CACS_state := "off"
		SetTimer telnet_loop, Off
	}
	else if InStr(telnetout,"Password:") and CACS_state = "password"
	{
		CACS_state := "confirm"
		send %pwd%{enter}
	}
	else if InStr(telnetout,"Username:") and CACS_state = "username"
	{
		CACS_state := "password"
		send 703024{enter}
	}
	return

	Work_RDP:
	run %windir%\system32\mstsc.exe
	return

	Work_FTP:
	run filezilla
	return

	Work_UpdatePassword:
	InputBox pwd, Update Password, Enter new password
	if ErrorLevel
		return
	file := FileOpen("misc\p", "w") 
	file.write(pwd)
	file.close()
	return

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; PuTTY Connection Manager ;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	Work_Putty:
	;run "C:\Program Files\PuTTY\putty.exe"
	run %puttyapp%
	Return

	Work_PuttyEdit:
	run %editor% misc\putty
	return

	Work_PuttyAdd:
	InputBox PuttyName, New PuTTY Connection, Enter project number and name
	InputBox PuttyIP, New PuTTY Connection, Enter username @ IP address
	InputBox PuttyPW, New PuTTY Connection, Enter Password
	IniWrite %PuttyIP% -pw %PuttyPW%, misc\putty, Putty, %PuttyName%
	run %puttyapp% %PuttyIP% -pw %PuttyPW%
	Reload
	return

	Work_PuttyConnect:
	IniRead, puttyinfo, misc\putty, Putty, %A_ThisMenuItem%
	run %puttyapp% %puttyinfo%
	return

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	UpdateCheck := 0
	;IPadded := 0

	ShowMenu:
	FileReadLine SvNum, faz-scripts.ahk, 3
	SvNum := StrReplace(SvNum, ";@Ahk2Exe-SetVersion ","")
	if not vNum = SvNum and not UpdateCheck = 1
	{
		UpdateCheck := 1
		try Menu SM, Insert, 2&, Update Script [%vNum% → %SvNum%], UpdateScript
	}

	Winget Pname, ProcessName, A
	Menu SM_Tools, Rename, 1&, Kill %PName%

	Menu SM, Show
	return
