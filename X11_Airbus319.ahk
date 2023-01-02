X11_Airbus319_2023_01_01:

Global TEST := False ; Or True ; Keine Programme starten
Global DEBUG := False ; Or True ; Debug anzeigen

Global Aktu_Sim := "X-System"
Global XP12 := False
Global Aktu_Scenario := "Airbus319" ; zum suchen in Load Scenario
Global AHK_File := "X11_" Aktu_Scenario ".ahk" ; Test AdminMode 
Global CMD_File := "X_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
Global CMD_List := "X_" Aktu_Scenario "_CMD.txt"

#Include %A_ScriptDir%\X_Airbus319.ahk