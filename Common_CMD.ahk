; Common_CMD_2022_09_09
; 
; Checklisten
;
Else If (CMD_Text="preflight procedure") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _Preflight_Procedure, %Checklist_Delay%
  }
}
Else If (CMD_Text="preflight checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _Preflight_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="preflight is ok") {

  Auto_Baro := True

  PreflightProc_Ok := True
  PreflightCheck_Ok := True
  BeforeTaxi_Ok := False
  BeforeTakeOff_Ok := False
  AfterTakeOff_Ok := False
  BeforeApproach_Ok := False
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="before taxi checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _BeforeTaxi_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="before taxi is ok") {

  Auto_Baro := True

  PreflightProc_Ok := True
  PreflightCheck_Ok := True
  BeforeTaxi_Ok := True
  BeforeTakeOff_Ok := False
  AfterTakeOff_Ok := False
  BeforeApproach_Ok := False
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="before take off checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _BeforeTakeOff_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="before take off is ok") {

  Auto_Baro := True

  PreflightProc_Ok := True
  PreflightCheck_Ok := True
  BeforeTaxi_Ok := True
  BeforeTakeOff_Ok := True
  AfterTakeOff_Ok := False
  BeforeApproach_Ok := False
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="after take off checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _AfterTakeOff_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="after take off is ok") {

  Auto_Baro := True

  PreflightProc_Ok := True
  PreflightCheck_Ok := True
  BeforeTaxi_Ok := True
  BeforeTakeOff_Ok := True
  AfterTakeOff_Ok := True
  BeforeApproach_Ok := False
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="before approach checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _BeforeApproach_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="before approach is ok") {

  Auto_Baro := True

  PreflightProc_Ok := True
  PreflightCheck_Ok := True
  BeforeTaxi_Ok := True
  BeforeTakeOff_Ok := True
  AfterTakeOff_Ok := True
  BeforeApproach_Ok := True
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

  Err := _Text_to_Speech(CMD_Text)		
}
Else If (CMD_Text="before landing checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _BeforeLanding_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="after landing checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _AfterLanding_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="parking checklist") {

  If Not (CheckList_Active Or RightPedal_Pressed)
  {
    CheckList_Active := True
    SetTimer, _Parking_Checklist, %Checklist_Delay%
  }
}
Else If (CMD_Text="auto checklist") {

  Gosub Auto_Checklists
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="checklist break") {

  CheckList_Break := True
}
Else If (CMD_Text="checked") {

  If CheckList_Active
    CheckItem_Ok := True
}
Else If (CMD_Text="yes") {

  If CheckList_Active
    CheckItem_Ok := True
}
Else If (CMD_Text="okay") {

  If CheckList_Active
    CheckItem_Ok := True
}
;
; Allgemein
;
Else If (CMD_Text="press 0") {

  Send 0 ; {Numpad0}
  ; Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="press 1") {

  Send 1 ; {Numpad1}
  ; Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="press 2") {

  Send 2 ; {Numpad2}
  ; Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="press 3") {

  Send 3 ; {Numpad3}
  ; Err := _Text_to_Speech(CMD_Text)
}
; Else If (CMD_Text="press 4") {
; {
; Send 4 ; {Numpad4}
; ; Err := _Text_to_Speech(CMD_Text)
; }
; Else If (CMD_Text="press 5") {
; {
; Send 5 ; {Numpad5}
; ; Err := _Text_to_Speech(CMD_Text)
; }
; Else If (CMD_Text="press 6") {
; {
; Send 6 ; {Numpad6}
; ; Err := _Text_to_Speech(CMD_Text)
; }
; Else If (CMD_Text="press 7") {
; {
; Send 7 ; {Numpad7}
; ; Err := _Text_to_Speech(CMD_Text)
; }
; Else If (CMD_Text="press 8") {
; {
; Send 8 ; {Numpad8}
; ; Err := _Text_to_Speech(CMD_Text)
; }
; Else If (CMD_Text="press 9") {
; {
; Send 9 ; {Numpad9}
; ; Err := _Text_to_Speech(CMD_Text)
; }
Else If (CMD_Text="speech mute") {

  If Not Speech_On
  {
    Speech_Mute := True
    Err := ToolTipEx("M", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S") 
  }
}
Else If (CMD_Text="speech unmute") {

  Speech_Mute := False

  If Not Speech_On
    Err := ToolTipEx(,,, 5)
}
Else If (CMD_Text="speech on") {

  SoundBeep, 400, 30
  Send {Media_Play_Pause} ; Discord (Micro aus)

  Speech_Mute := False
  Speech_On := True

  SoundGet, SoundVol_On
  SoundSet, SoundVol_Off

  Err := ToolTipEx("S", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S")

  Speech_Found := False
  s.Listen(True)

  Err := ToolTipEx("?> ", x_Tooltip1, y_Tooltip1, 1, HFONT, "Lime", "Black", "", "S")

  SetTimer, Close_SpeechRec, %CloseSpeech_Delay%
}
Else If (CMD_Text="speech off") {

  SoundBeep, 400, 30
  Send {Media_Play_Pause} ; Discord (Micro aus)

  Speech_On := False
  SoundSet, SoundVol_On

  Err := ToolTipEx(,,, 5)

  Gosub Close_SpeechRec
}
Else If (CMD_Text="headset output") {

  cSpeaker.AudioOutput := cAudioOutputs.Item(Headset_OutputDevice)

  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="monitor output") {

  cSpeaker.AudioOutput := cAudioOutputs.Item(Monitor_OutputDevice)

  Err := _Text_to_Speech(CMD_Text)
}
; Else If (CMD_Text="change input device") { ; AKI: TODO:
; {
; InputDevice := Not InputDevice
; msgbox Input %inputdevice%
; s := New SpeechRecognizer
; Err := _Text_to_Speech(CMD_Text)
; }
Else If (CMD_Text="remove flightplans") {

  Gosub, DeleteFlightPlans
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="debug on") {

  DEBUG := True
  SetTimer, Show_DEBUG_Info, %Show_DEBUG_Info_Delay%
}
Else If (CMD_Text="debug off") {

  DEBUG := False
  SetTimer, Show_DEBUG_Info, Off
  ToolTipEx(,,, 10)
}
Else If (CMD_Text="reset status bar") {

  loop ,%MAX_TOOLTIPS%
    TTex_oFSVAR[A_Index ] := 999
}
Else If (CMD_Text="move status bar") {

  if (TTex_xVersatz < MoveStatusBar_RL)
  {
    TTex_xVersatz := TTex_xVersatz + MoveStatusBar_RL

    x_ToolTip1 := x_ToolTip1 + MoveStatusBar_RL ; SpeechRec-Command-Anzeigen
    x_ToolTip2 := x_ToolTip2 + MoveStatusBar_RL ; ATC-Anzeige
    x_ToolTip3 := TTex_xVersatz 				 ; Checklist_ITEM (unter der StatusBar)
    x_ToolTip4 := x_ToolTip4 + MoveStatusBar_RL ; 
    x_ToolTip5 := x_ToolTip5 + MoveStatusBar_RL ; 'M' Speech_Mute und 'S' Speech_On; und 'SetComX'
    x_ToolTip6 := x_ToolTip6 + MoveStatusBar_RL ; _Message()
    x_ToolTip7 := x_ToolTip7 + MoveStatusBar_RL ; !!! ToolTip -> (Zeitzähler CMD_Process) Common_CMD.ahk
    x_ToolTip8 := x_ToolTip8 + MoveStatusBar_RL ; !!! ToolTip -> (Zeitzähler AircraftScenario) ShowDEBUGInfo
    x_ToolTip9 := x_ToolTip9 + MoveStatusBar_RL ; _Error_Message()
    x_ToolTip10 := x_ToolTip10 + MoveStatusBar_RL ; !!! ToolTip -> Show_DEBUG_Info
  }	
  Else
  {
    TTex_xVersatz := TTex_xVersatz - MoveStatusBar_RL

    x_ToolTip1 := x_ToolTip1 - MoveStatusBar_RL ; SpeechRec-Command-Anzeigen
    x_ToolTip2 := x_ToolTip2 - MoveStatusBar_RL ; ATC-Anzeige
    x_ToolTip3 :=TTex_xVersatz					 ; Checklist_ITEM (unter der StatusBar)
    x_ToolTip4 := x_ToolTip4 - MoveStatusBar_RL ; 
    x_ToolTip5 := x_ToolTip5 - MoveStatusBar_RL ; 'M' Speech_Mute und 'S' Speech_On; und 'SetComX'
    x_ToolTip6 := x_ToolTip6 - MoveStatusBar_RL ; _Message()
    x_ToolTip7 := x_ToolTip7 - MoveStatusBar_RL ; !!! ToolTip -> (Zeitzähler CMD_Process) Common_CMD.ahk
    x_ToolTip8 := x_ToolTip8 - MoveStatusBar_RL ; !!! ToolTip -> (Zeitzähler AircraftScenario) ShowDEBUGInfo
    x_ToolTip9 := x_ToolTip9 - MoveStatusBar_RL ; _Error_Message()
    x_ToolTip10 := x_ToolTip10 - MoveStatusBar_RL ; !!! ToolTip -> Show_DEBUG_Info
  }	

  _Message("", 0)
  _Error_Message("", 0)

  loop ,%MAX_TOOLTIPS%
    TTex_oFSVAR[A_Index ] := 999
}
Else If (CMD_Text="desktop 2") {

  Send {Ctrl Down}{LWin Down}{right}{Ctrl Up}{LWin Up}
  ActivateSimWin := False
}
Else If (CMD_Text="auto baro on") {

  Auto_Baro := True
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="auto baro off") {

  Auto_Baro := False
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="pause on") {

  send p
}
Else If (CMD_Text="pause off") {

  send p
}
Else If (CMD_Text="training on") {

  TRAINING_active := True
}
Else If (CMD_Text="training off") {

  TRAINING_active := False
}
Else If (CMD_Text="snap shot") {

  Send {LWin Down}{Alt Down}{PrintScreen}{Alt Up}{LWin Up}
}
Else If (CMD_Text="switch gamebar on") {

  Send {LWin Down}g{LWin Up}
}
Else If (CMD_Text="gamebar off") {

  Send {LWin Down}g{LWin Up}
}
; 
; show
;
Else If (CMD_Text="show commands") {

  Run, %Chrome_Tab1%D:\Games\99_AHK\CMD_Lists\%CMD_List%

  ActivateSimWin := False
}
Else If (CMD_Text="show links") {

  Run, %Chrome_Tab1%D:\Games\10_FS_LINKS

  ActivateSimWin := False
}
Else If (CMD_Text="show charts") {

  Run, %Chrome_Tab1%%VATSIM_Charts%
  Run, %Chrome_Tab1%%ChartFox%
  Run, %Chrome_Tab1%%IVAO_Charts%

  Run, D:\Games\00_FS_ORDNER\60_CHARTS\
  ActivateSimWin := False
}
Else If (CMD_Text="show diverses") {

  Run, D:\Games\00_FS_ORDNER\Diverses.odt

  ActivateSimWin := False
}
Else If (CMD_Text="show formulas") {

  Run, D:\Games\00_FS_ORDNER\Formeln.ods

  ActivateSimWin := False
}
Else If (CMD_Text="show simbrief") {

  WinActivate, SimBrief.com

  If Not WinExist("SimBrief Downloader")
  {
    ; _message("Open SimBrief!",3)
    Run, "C:\Users\achim\AppData\Local\Programs\SimBrief Downloader\SimBrief Downloader.exe"
    Run, %Chrome_Tab1%%SimBrief_Web%
  }
  Else
    WinActivate, SimBrief Downloader

  ActivateSimWin := False
}
Else If (CMD_Text="show VATSIM map") {

  Run %Chrome_Tab1%%VATSIM_Map%

  ActivateSimWin := False
}
Else If (CMD_Text="show IVAO map") {

  Run %Chrome_Tab1%%IVAO_Map%

  ActivateSimWin := False
}
Else If (CMD_Text="show little nav map") {

  If Not WinExist("Little Navmap")
  {
    _message("Starte Little Navmap!",3)
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_LittleNM,,Hide
  }

  WinActivate, Little Navmap
  ActivateSimWin := False
}
Else If (CMD_Text="show active sky") {

  If (Aktu_Sim = XPLANE) And Not WinExist("Active Sky")
  {
    _Message("Starte ActiveSkyXP!", 3)
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_ActiveSkyXP,,Hide	
  }

  If (Aktu_Sim = P3DV4) And Not WinExist("Active Sky")
  {
    _Message("Starte ActiveSkyP3D!", 3)
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_ActiveSky,,Hide
  }

  WinActivate, Active Sky
  ActivateSimWin := False
}
Else If (CMD_Text="show vaBase") {

  ; vabase anzeigen/ oder FP laden vabase starten und FP laden
  If WinExist("vaBase Live")
  {
    WinActivate, vaBase Live
  }
  Else
  {
    _Message("vaBase nicht gestartet!?", 3)
  }

  ActivateSimWin := False
}
Else If (CMD_Text="show team speak") {

  If Not WinExist("TeamSpeak 3")
  {
    ; _message("Open TeamSpeak 3!",3)
    Run, "D:\Games\TeamSpeak 3 Client\ts3client_win64.exe",,,TeamSpeak3_PID
  }

  WinActivate, TeamSpeak 3
  ActivateSimWin := False
}
Else If (CMD_Text="show discord") {

  If Not WinExist("Discord")
  {
    _message("Open Discord!",3)
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_Discord,,Hide
  }

  WinActivate, Discord
  ActivateSimWin := False
}
Else If (CMD_Text="show aircraft type") {

  AC_TYPE_read := True
  ; _Message("Active is: " Aktu_Sim " mit " Aktu_Scenario " und " ATC_str, 0)
  ActivateSimWin := False
}
;
; goto
;
Else If (CMD_Text="goto VATSIM") { ; TODO:

  If IVAO_active
  {
    _Error_Message("IVAO is active!", 3)
  }
  Else
  {
    VATSIM_active := True
    IVAO_active := False

    ; Problem Fahrwerke XCSL/BlueBell TODO:

    ; über VATSIM_IVAO_Switch.lua XUIPC-plugin neu starten (LVARS neu einlesen)
    If (Aktu_Sim == XPLANE)
    {
      Gosub Stop_Aircraft_Scenario		
      Send {Ctrl Down}{Alt Down}{NumpadDiv}{Alt Up}{Shift Up}{Ctrl Up}
      sleep, 3000	
      Gosub Start_Aircraft_Scenario		
    }	

    ; Process, Close ,PilotUI.exe
    ; Process, Close ,Pilot_core_fs2020.exe

    If (Aktu_Sim = MSFS) ; TODO: Admin Mode????
      Run, D:\Games\VATSIM\VPilot\VPilot.exe

    If (Aktu_Sim == P3DV4)
      Run, D:\Games\VATSIM\VPilot\VPilot.exe ; TODO: Admin Mode????

    If (Aktu_Sim == XPLANE)
      ; Run, D:\Games\VATSIM\XPilot\XPilot.exe  ; TODO: Admin Mode????
    Run, C:\Program Files\xPilot\xPilot.exe

  }

  ActivateSimWin := False
}
Else If (CMD_Text="goto IVAO") {

  If VATSIM_active
  {
    _Error_Message("VATSIM is active!", 3)
  }
  Else
  {
    IVAO_active := True
    VATSIM_active := False

    ; über VATSIM_IVAO_Switch.lua XUIPC-plugin neu starten (LVARS neu einlesen)
    If (Aktu_Sim == XPLANE)
    {
      Gosub Stop_Aircraft_Scenario		
      Send {Shift Down}{Ctrl Down}{Alt Down}{NumpadDiv}{Alt Up}{Shift Up}{Ctrl Up}
      sleep, 3000	
      Gosub Start_Aircraft_Scenario		
    }	

    ; Process, Close ,VPilot.exe ; bei P3D & MSFS
    ; Process, Close ,XPilot.exe ; bei XP

    If (Aktu_Sim == MSFS)
    {
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_IVAO_MSFS_Core,,Hide
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_IVAO_MSFS,,Hide
    }

    If (Aktu_Sim == P3DV4)
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_IVAO_P3D,,Hide

    If (Aktu_Sim == XPLANE)
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_IVAO_XP,,Hide
  }		

  ActivateSimWin := False
}
Else If (CMD_Text="goto air fox") {

  ; https://www.airfox-virtual.de/site_pilot_functions/dispatch.php
  ; https://www.airfox-virtual.de/authentication/login.php?logout=yes

  Gosub LoadAktuFlightPlan

  If (FP_Departure = "")
  {
    _Message("No Flightplan loaded!", 10)
  }
  Else
  {
    ; Airfox Web login

    Run %Chrome_Tab1%%AirFox_Web_Logout%
    sleep,2000
    send {TAB 10}{Enter}
    sleep,2000
    send ^w ; close Tab

    ; Vorhandenen Charter ggf. entfernen

    Run %Chrome_Tab1%%AirFox_Web_Charter_Kill%
    sleep,2000
    Send, {Tab 7}{Enter}
    sleep,2000
    send ^w ; close Tab

    ; Charter buchen

    Run %Chrome_Tab1%%AirFox_Web_Charter%
    sleep,2000
    Send, {Tab 7}{Enter}{Down}{Enter}
    sleep,2000
    Send, {Tab 7}%FP_Departure%{Tab}%FP_Destination%
    sleep,2000
    Send, {Tab 2}%FP_AircraftICAO%{Tab}%FP_Paxe%{Tab}%FP_Cargo%
    sleep,2000
    Send, {Tab}{Enter} ; Flug prüfen
    sleep,2000
    Send, { Tab 14}{Enter} ; Flug buchen
    ; sleep,2000
    ; send ^w ; close Tab

    ; vaBase beenden und wieder starten

    ; _message("Close vaBase!",3)			
    Process, Close, vaBaseLive.exe

    While WinExist("vaBase Live")
      _Message("Waiting for closing VABase!", 1)

    ; _message("Start vaBase!",3)			
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_vaBaseLive,,Hide

    While Not WinExist("vaBase Live")
      _Message("Waiting for VABase is ready!", 1)

    WinActivate, vaBase Live
    sleep 500

    ; Login vaBase ausführen
    Send {Tab 4}
    Send AFX6
    Send {Tab}
    sleep 100
    Send achim.wolberg@gmail.com
    Send {Tab}
    sleep 100
    Send AchWo123
    Send {Tab 2}
    sleep 100
    Send {Enter}
    sleep 1000

    ; dann Flightplan und Route einfügen
    Send {Tab 6}%FP_FlightLevel%
    sleep 100
    Send {Tab 1}%FP_Route%
  }

  ActivateSimWin := False
}	
Else { ; Ende der großen If-Abfrage

  Err := _Text_to_Speech("Say it again!") ; sollte eigentlich nicht vorkommen/ Ende für SPEECH_INIT Loop !!!!!
}

If Not ActivateSimWin
  ActivateSimWin := True
Else

WinActivate, %Aktu_Sim%
WinActivate, ahk_class %Aktu_Sim%

; Damit auch "nicht speech" Befehle angezeigt werden
If Speech_ON
  Err := ToolTipEx("?> " Old_CMD_Text, x_Tooltip1, y_Tooltip1, 1, HFONT, "Lime", "Black", "", "S")
Else
  Err := ToolTipEx("!> " Old_CMD_Text, x_Tooltip1, y_Tooltip1, 1, HFONT, "WHITE", "Black", "", "S")

CMD_Text := ""

DEBUG_CMD_Process += 1000
CP_EndTime := A_TickCount - CP_StartTime
