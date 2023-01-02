X12_Airbus330_2023_01_01:

  Global TEST := False ;Or True ; Keine Programme starten
  Global DEBUG := False ; Or True ; Debug anzeigen

  Global Aktu_Sim := "X-System"
  Global XP12 := True
  Global Aktu_Scenario := "Airbus330" ; zum suchen in Load Scenario
  Global CMD_File := "X12_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "X12_" Aktu_Scenario "_CMD.txt"

  #Include %A_ScriptDir%\X_Airbus330.ahk