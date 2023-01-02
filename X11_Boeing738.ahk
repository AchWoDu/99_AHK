X11_Boeing738_2023_01_01:

Global TEST := False ; Or True ; Keine Programme starten
Global DEBUG := False ;Or True ; Debug anzeigen
Global XP12 := False

Global Aktu_Sim := "X-System"
Global Aktu_Scenario := "Boeing738" ; zum suchen in Load Scenario
Global CMD_File := "X11_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
Global CMD_List := "X11_" Aktu_Scenario "_CMD.txt"

#Include %A_ScriptDir%\X_Boeing.ahk

