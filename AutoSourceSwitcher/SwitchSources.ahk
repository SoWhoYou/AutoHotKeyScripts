#SingleInstance, Force
SendMode Event
SetKeyDelay, -1
SetWorkingDir, %A_ScriptDir%
#Persistent

global Switch_Delay := 1
global active := 0
global OBS_Name := "obs64.exe"
global Swap_Delay := (Switch_Delay*1000)

If WinActive("ahk_exe Code.exe") {
	active := 1
} else {
	active := 0
}

Gosub, OBS_Running_Check
SetTimer Main_Script_Loop, %Swap_Delay%

OBS_Running_Check:
IfWinNotExist, ahk_exe %OBS_Name%
	ExitApp
Return

Main_Script_Loop:
Gosub, OBS_Running_Check
Gosub, Is_Code_Active
Return

Is_Code_Active:
If WinActive("ahk_exe Code.exe") {
	Gosub, Switch_to_Code
} else {
	Gosub, Switch_to_Display
}
Return

Switch_to_Code:
If (active = 0) {
	ControlSend, ahk_parent, {F24}, ahk_exe %OBS_Name%
	active := 1
}
Return

Switch_to_Display:
If (active = 1) {
	ControlSend, ahk_parent, {F23}, ahk_exe %OBS_Name%
	active := 0
}
Return

F22::
	SetTimer, Main_Script_Loop, Off
	ControlSend, ahk_parent, {F23}, ahk_exe %OBS_Name%
ExitApp