X12_Boeing738_2023_01_01:

Global TEST := False ; Or True ; Keine Programme starten
Global DEBUG := False ;Or True ; Debug anzeigen
Global XP12 := True

Global Aktu_Sim := "X-System"
Global Aktu_Scenario := "Boeing738" ; zum suchen in Load Scenario
Global AHK_File := "X12_" Aktu_Scenario ".ahk" ; Test AdminMode 
Global CMD_File := "X_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
Global CMD_List := "X_" Aktu_Scenario "_CMD.txt"

#Include %A_ScriptDir%\X_Boeing738.ahk