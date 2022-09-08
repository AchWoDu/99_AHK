; _KillAircraft_2021_10_09

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

full_command_line := DllCall("GetCommandLine", "str")

if Not (A_IsAdmin Or RegExMatch(full_command_line, " /restart(?!\S)"))
{
	RunWait, C:\WINDOWS\system32\schtasks.exe /run /tn SkipUAC_KillAircraft ,,Hide UseErrorLevel  

	If !ErrorLevel
		ExitApp

	try
	{
		if A_IsCompiled
			Run *RunAs "%A_ScriptFullPath%" /restart
		else
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
	}

	ExitApp
}

Process, Close ,Set_ComRadio.EXE
Process, Close ,StartAircraft.exe
