/*
	Mouse bindings
*/

GroupAdd Ignored, ahk_class Respawn001
GroupAdd Ignored, ahk_exe swtor.exe

#ifWinActive ahk_group Ignored

~MButton & WheelUp::
~RButton & WheelUp::
Send {Volume_Up}
return

~MButton & WheelDown::
~RButton & WheelDown::
Send {Volume_Down}
return

~RButton & XButton1::
send ^+{Tab}
return

~RButton & XButton2::
send ^{Tab}
return

#if