Common_2022_12_28:

DEV_MAIN_INIT_VARs:

  If False ; Or True ; = ExitApp zum testen setzen
  {
    MsgBox, Commen.ahk ExitApp zum Test
    ExitApp, 0
  }

  Global TEST := False ; Or True ; keine Programme starten, oder in Aircraft File setzen
  Global DEBUG := False ; Or True ; Debug anzeigen, oder in Aircraft File setzen

  ; ListHotkeys
  ; #KeyHistory

  #SingleInstance, Force
  #Warn ; Enable warnings to assist with detecting commonerrors.
  #NoEnv ; Leere Variablen werden nicht länger überprüft, ob sie Umgebungsvariablen sind (für alle neuen Skripte empfohlen).
  #Persistent ; Hält ein Skript dauerhaft aufrecht (bis der Benutzer das Skript schließt oder ein ExitApp vorkommt).

  #WinActivateForce ; TODO:

  ; SetBatchLines, 10ms
  ; SetFormat, float, 0.0

  SetTitleMatchMode, 2 ; Übereinstimmungsverhalten des Fenstertitel-Parameters / 2 = Fenstertitel an beliebiger Stelle
  DetectHiddenText, On ; findet versteckte Fenstertitel
  DetectHiddenWindows, On

  SetWorkingDir, %A_ScriptDir% ; Ensures a conistent starting directory.
  SendMode, Event ; =STANDARD Modus ; Mode "Input" funktionert nicht mit P3D

  SetKeyDelay, 20, 30 ; 10, 20 MsgBox A_KeyDelay : %A_KeyDelay% A_KeyDuration: %A_KeyDuration
  SetKeyDelay, 20, 60 ; 10, 20 MsgBox A_KeyDelay : %A_KeyDelay% A_KeyDuration: %A_KeyDuration

  CoordMode, ToolTip, Screen ; |Window|Client] für Maus Aktionen

DEV_Global_VARs:

  Global DEBUG_CMD_Process := 0
  Global DEBUG_Aircraft_Scenario := 0
  Global DEBUG_Read_FS_VARS := 0
  Global DEBUG_Write_Statusbar := 0
  Global DEBUG_Is_CheckItem := 0
  Global DEBUG_CMD := 0

  Global CP_LastTime 	:= 0 ; CMD_Process A_TickCount -> ToolTip Nr.7 in "Common_CMD.ahk"
  Global ACS_LastTime := 0 ; Aircraft_Scenario A_TickCount -> ToolTip Nr.8 im "Aircraft.ahk"

  Global MSFS 		:= "Microsoft Flight Simulator"
  Global P3DV4 		:= "Lockheed Martin® Prepar3D® v4"
  Global XPLANE 	:= "X-System"

  Global Running_Sim 	:= "" ; aktuell geladener Sim (wird in _Is_any_Sim_active() gesetzt )

  Global FSUIPC_LibPfad := "D:\Diverses\FSUIPC\UIPC32_SDK_C\FSUIPC_User" ; 32 BIT
  ; Global FSUIPC_LibPfad := "D:\Diverses\FSUIPC\UIPC64_SDK_C\Lib64_source\FSUIPC_User64" ; 64 BIT

  Global AHK_Path := "D:\Games\99_AHK\"
  Global BIN_Path := AHK_Path "bin\"

  Global CMD_File_Path := AHK_Path ; Datei mit den verfügbaren SpeechRec-Kommandos
  Global CMD_List_Path := AHK_Path "CMD_Lists\"

  Global Aircraft_LOG_File 	:= BIN_Path "StartAircraft.log"

  Global Common_CMD_File 		:= "Common_CMD.ahk" ; include gemeinsame Commands
  Global Common_CMD_MS_File 	:= "Common_CMD_MS.ahk" ; include gemeinsame MSFS Commands
  Global Common_CMD_P3D_File 	:= "Common_CMD_P3D.ahk" ; include gemeinsame P3D Commands
  Global Common_CMD_XP_File 	:= "Common_CMD_XP.ahk" ; include gemeinsame XPlane Commands

  Global COMPILER_Path := "C:\Programme\AutoHotkey\Compiler\"
  Global AHK_EXE := COMPILER_Path "Ahk2Exe.exe"
  Global AHK_Compiler := COMPILER_Path "Unicode 32-bit.bin"
  Global FILE_ICON := "D:\Diverses\Clipart\IconLib\ico\48x48\symbols\pictograms-road_signs-airplane_roadsign.ico"

  Global Flightplan_Path := "D:\Games\00_FS_ORDNER\50_FLIGHT_PLANS\"

  Global SoundVol_On := 25 ; in % von voller Lautstärke
  Global SoundVol_Off := 10 ; in % von voller Lautstärke

  Global FileName := ""
  Global Zeile := ""
  Global Index := 0
  Global x := 0
  Global Err := 0
  Global dwResult := 0

  Global CMD_Text := ""
  Global Old_CMD_Text := ""
  Global NoWinactivate := False ; fuer Befehle wo der Focus nicht auf den Sim zurückgesetzt werden soll
  Global ActivateSimWin := True ; fuer Befehle wo der Focus nicht auf den Sim zurückgesetzt werden soll

  Global Screen7_On 	:= False ; wird bei MSFS2020 gebraucht
  Global Aktu_Screen 	:= 5 ; Main Panel/ NumpadClear
  Global Last_Screen 	:= 8

  Global KillAll_On := False ; True wenn H_EndApp_KillAll angesprungen wurde

  Global FSUIPC_Ok := False ; True, wenn "FSUIPC Open" aktive ist

  Global RightPedal_pressed := False ; Verhindert Checklistenstart und ComX Start bei gedrückter ATC

  Global BlinkerChar := "" ; Blinker für Anzeige TooTip
  Global NumLockChar := "" ; Anzeige des NumLock Zustandes

  Global Listen_On= False ; Spracherkennung (Function speechRec) active or not active
  Global Speech_On := False ; Spracherkennung bleibt an
  Global Speech_Found := False ; wird in Interrupt Routine auf on gesetzt
  Global Speech_Mute := False ; keine Checklisten vorlesen

DEV_VATSIM_IVAO_Switch:

  Global TRAINING_active 	:= False ; TeamSpeak only Nutzen

  ; zum umbenennen des IVAO Plugins
  Global IVAO_winXpl_Pfad := "J:\X-Plane 11\Resources\plugins\IVAO_pilot\64\"

  If FileExist("D:\Games\99_AHK\bin\GoTo_IVAO.dat") {
    Global ATC_str 		 := "IVAO-ATC"
    Global IVAO_active 	 := True Or WinExist("IVAO Pilot Client")
    Global VATSIM_active 	 := False Or WinExist("vPilot") Or WinExist("xPilot")
    FileMove, %IVAO_winXpl_Pfad%win.xpl.xorg, %IVAO_winXpl_Pfad%win.xpl
  }
  Else {
    Global ATC_str 		 := "VATSIM-ATC"
    Global VATSIM_active := True Or WinExist("vPilot") Or WinExist("xPilot")
    Global IVAO_active 	 := False Or WinExist("IVAO Pilot Client")
    FileMove, %IVAO_winXpl_Pfad%win.xpl, %IVAO_winXpl_Pfad%win.xpl.xorg ; .xorg wird vom Orgnizer erkannt/genutzt
  }

DEV_Output_Devices:

  Global Boxen 		 	 := 0
  Global Headset		 	:= 3
  Global Monitor_Rechts := 2
  Global Monitor_Mitte 	:= 1

  Global Boxen_OutputDevice 	:= Boxen ; text to speech
  Global Headset_OutputDevice := Headset ; text to speech
  Global Monitor_OutputDevice := Monitor_rechts ; text to speech

  Global Headset_InputDevice 	:= 0 ; speech input

DEV_Browser_VARs:

  Global Brave := "C:\Program Files\BraveSoftware\Brave-Browser\Application\Brave.exe"
  Global Edge	:= "microsoft-edge:"

  ; Global Chrome_Exe	:= "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
  Global Chrome_Exe 	:= "C:\Program Files\Google\Chrome\Application\chrome.exe"
  Global Chrome_User1	:= "--user-data-dir=c:\Users\achim\AppData\Local\Google\Chrome\user1"
  Global Chrome_User2	:= "--user-data-dir=C:\Users\achim\AppData\Local\Google\Chrome\user2"
  Global Chrome_User3	:= "--user-data-dir=C:\Users\achim\AppData\Local\Google\Chrome\user3"

  Global Chrome_Maximize	:= "--start-maximized"
  Global Chrome_NewWindow	:= "--new-window"
  Global Chrome_App		:= "--app="

  ; Browserfenster User1 (linkes Hauptfenster)
  Global Chrome_wSize1	:= "--window-size=1120,1000"
  Global Chrome_wPos1		:= "--window-position=-1920,-1"
  Global Chrome_New1	:= Chrome_Exe " " Chrome_User1 " " Chrome_NewWindow " " Chrome_wSize1 " " Chrome_wPos1 " "
  Global Chrome_Tab1	:= Chrome_Exe " " Chrome_User1 " "

  ; FBWFMC Fenster 1 und
  Global FBW_FMC := "http://192.168.1.100:8380/interfaces/mcdu/"
  Global Chrome_wSize_FBW_CDU1 := "--window-size=420,665"
  Global Chrome_wPos_FBW_CDU1	 := "--window-position=-820,400"
  Global Chrome_FBW_CDU1	 := Chrome_Exe " " Chrome_User2 " " Chrome_App FBW_FMC " " Chrome_wPos_FBW_CDU1 " " Chrome_wSize_FBW_CDU1

  ; WebFMC Fenster 1 und 2
  Global Web_FMC := "http://192.168.1.100:9090"
  Global Chrome_wSize_CDU1 := "--window-size=420,665"
  Global Chrome_wPos_CDU1	 := "--window-position=-820,400"
  Global Chrome_CDU1		 := Chrome_Exe " " Chrome_User2 " " Chrome_App Web_FMC " " Chrome_wPos_CDU1 " " Chrome_wSize_CDU1

  Global Chrome_wSize_CDU2 := "--window-size=420,665"
  Global Chrome_wPos_CDU2	 := "--window-position=-420,400"
  Global Chrome_CDU2		 := Chrome_Exe " " Chrome_User3 " " Chrome_App Web_FMC " " Chrome_wPos_CDU2 " " Chrome_wSize_CDU2

  ; http-Pfade
  Global VATSIM_Web	 := "https://vatsim-germany.org/"
  Global VATSIM_Charts := "https://vatsim-germany.org/pilots/aerodromes"
  Global VATSIM_Map	 := "http://simaware.ca/" ; oder "" oder "http://www.vattastic.com" "https://v2preview.vattastic.com/"
  Global VATSIM_Map_str := "SimAware"

  Global IVAO_Web		:= "https://de.ivao.aero/"
  Global IVAO_Charts 	:= "https://divisioncenter.ivao-de.net/charts"
  Global IVAO_Map 	:= "https://webeye.ivao.aero" ; oder ""
  Global IVAO_Map_str := "IVAO Webeye"

  Global SimBrief_Web	:= "https://www.simbrief.com/system/dispatch.php"

  Global AirFox_Web 		:= "http://www.airfox-virtual.de/"
  Global AirFox_Web_Login := "https://www.airfox-virtual.de/authentication/login.php?crew"
  Global AirFox_Web_Logout := "https://www.airfox-virtual.de/site_pilot_functions/pilot_centre.php?function=logout"
  Global AirFox_Web_Charter := "https://www.airfox-virtual.de//site_pilot_functions/book_charter_flight.php"
  Global AirFox_Web_Charter_Kill := "https://www.airfox-virtual.de/site_pilot_functions/dispatch.php"
  ; Strg-w -> Tab schließen

  ; Global ONLINE_Map	:= "https://vau.aero/fsmap/?osm&vatsim"
  ; Global ONLINE_Map_str	:= "VATSIM Map"
  ; Global ONLINE_Map	:= "https://fly.volanta.app/map"
  ; Global ONLINE_Map_str := "Volanta"

  Global ChartFox	:= "https://chartfox.org/"

DEV_Timer_VARs:

  Global ButtonWait_Delay := 60 ; 2ter Buttondruck Erkennung
  Global POV_Delay := 100 ; 100 für POV/ Aircraft.ahk benötigt
  Global Checklist_Delay := 300 ; 300 wird in Common_CMD benötigt
  Global CMDProcess_Delay := 100 ; 100
  Global AircraftScenario_Delay := 900 ; 900
  Global Is_SIM_active_Delay := 5000 ; 5000 test auf FS active
  Global CloseSpeech_Delay := 3000 ; 3000 beendet Speech Erkennung
  Global Check_ARCARS_Error_Win_Delay := 60000
  Global Show_DEBUG_Info_Delay := 1000

  ; DEV_Aircraft_Scenario_VARs:

  Global AC_TYPE := "" ; ICAO Wert
  Global AC_TYPE_read := True ; wir nach erstem read auf False gesetzt

  Global Auto_Baro := False ; Schaltet automatisch von QNH auf STD
  Global InTrans := False
  Global AboveTrans := False
  Global BelowTrans := False
  Global PassingFL080 := False

  Global TempoLow := 40 ; Taxi Tempomat in km/h
  Global TempoHigh := 60 ; Taxi Tempomat in km/h

DEV_Checklisten_VARs:

  Global PreflightProc_Ok := False ; Or True
  Global PreflightCheck_Ok := False ; Or True
  Global BeforeTaxi_Ok := False ; Or ; True
  Global BeforeTakeOff_Ok := False ; Or True
  Global AfterTakeOff_Ok := False ; Or True
  Global BeforeApproach_Ok := False ; Or True
  Global BeforeLanding_Ok := False ; Or True
  Global AfterLanding_Ok := False ; Or True
  Global Parking_Ok := False ; Or True

  Global CheckList_Break := False ; zZ. Control + ShiftHold
  Global CheckList_Active := False ; Wenn Checklisten Abfrage aktiv
  Global CheckItem_Active := False ; Wenn Checklisten Item Abfrage aktiv
  Global CheckItem_Ok := False ; Wenn Checklisten Item mit Ok beantwortet wurde

DEV_Flightplan_VARs:

  Global FP_CallSign := "AFX6" ; bleibt unverändert

  ; LoadAktuFlightPlan aus xml-Datei
  Global FP_Airline := "AFX"
  Global FP_FlightNumber := "6"

  Global FP_FlightRules := ""
  Global FP_AircraftICAO := ""
  Global FP_Departure := ""
  Global FP_DepTime := ""
  Global FP_Route := ""
  Global FP_Destination := ""
  Global FP_FlightLevelType := ""
  Global FP_FlightLevel := ""

  Global FP_Paxe := ""
  Global FP_Cargo := ""

  ; Global FP_Speed := ""

  ; https://en.wikipedia.org/wiki/Equipment_codes
  ; https://mediawiki.ivao.aero/index.php?title=Flight_plan_equipment_methodology
  ; Global FP_Equipment := "" ; z.B. SFG
  ; Global FP_Transponder := "" ; z.B. C

  ; LoadVatsimFlightPlan
  Global FlightType := ""
  Global Equipment := ""
  Global CruiseAltitude := ""
  Global CruiseSpeed := ""
  Global DepartureAirport := ""
  Global DestinationAirport := ""
  Global AlternateAirport := ""
  Global Route := ""
  Global Remarks := ""
  Global IsHeavy := ""
  Global EquipmentPrefix := ""
  Global EquipmentSuffix := ""
  Global DepartureTime := ""
  Global EnrouteHours := ""
  Global EnrouteMinutes := ""
  Global FuelHours := ""
  Global FuelMinutes := ""
  Global VoiceType := ""

DEV_Hotkey_VARs:

  ; *	 = wird immer ausgelöst auch wenn modifikaton
  ; $  = keine rekursion
  ; ~  = Taste weiterleiten
  ; +  = [Shift]-Taste
  ; ^  = [Ctrl]-Taste
  ; !  = [QALT]-Taste
  ; #  = [Win] -Taste
  ; <# = [Left Win Taste]

  ; 1JoyX Wireless Gamepad
  ; 3JoyX HOTAS (Hands On Throttle And Stick)
  ; 4JoyX Arduino

  ; Hotkey, SC03A, H_Ok ; CapsLock unabhängig ob Ctrl, Shift etc. gedrückt sind

  ; SpeechRec
  Global T_LeftPedal := "4Joy7" ; Arduino
  Hotkey %T_LeftPedal%, H_SpeechRec ; lang macht SpeechRec on

  Global T_LeftPedal2 := "3Joy3" ; HOTAS
  Hotkey %T_LeftPedal2%, H_SpeechRec ; lang macht SpeechRec on

  Global T_LeftPedal3 := "XButton2" ; MOUSE vorne
  Hotkey %T_LeftPedal3%, H_SpeechRec

  ; ATC
  Global T_RightPedal := "4Joy8" ; Arduino
  Hotkey %T_RightPedal%, H_ATC

  Global T_RightPedal2 := "3Joy4" ; HOTAS
  Hotkey %T_RightPedal2%, H_ATC

  Global T_RightPedal3 := "XButton1" ; MOUSE hinten
  Hotkey %T_RightPedal3%, H_ATC

  ; ChecklistOK or Break
  Hotkey Browser_Stop, H_Checkitem_Ok ; SharpKeys/ Capslock
  Hotkey +Browser_Stop, H_Checklist_Break ; SharpKeys/ Shift+Capslock

  Global T_Checkitem_Ok2 := "4Joy9" ; Arduino
  Hotkey %T_Checkitem_Ok2%, H_Checkitem_Ok ; lang macht Checklist-Break

  Global T_Checkitem_Ok3 := "3Joy1" ; HOTAS
  Hotkey %T_Checkitem_Ok3%, H_Checkitem_Ok ; lang macht Checklist-Break

  ; LittleNavMap
  Hotkey LControl & ^, H_LNM_IFR 	; IFR-Makro
  Hotkey LShift & ^, H_LNM_VFR 	; VFR-Makro

  ; SetCom Freq
  Hotkey LShift & RShift, H_SetCom1 ; com1
  Hotkey RShift & LShift, H_SetCom2 ; com2

  ; App handling
  Hotkey +Esc, H_ResetApp ; SHIFT + ESC
  Hotkey ^Esc, H_EndApp	; CTRL  + ESC
  Hotkey ^!Esc, H_EndApp_KillAll ; CTRL + ALT + ESC

  ; Menu
  Hotkey ~^MButton, H_Start_Menu ; Ctrl + Mittlerer Maus

DEV_ToolTip_VARs:

  ; !! VARs aus Aircraft-Files

  ; Sprachbefehl-Anzeige
  ; Global x_Versatz := 0 ; -1920 <-0-> +1920
  ; Global y_Versatz := 0

  ; Status- und Checklist-Anzeige
  ; Global TTex_xVersatz := 348 ; -1920 <-0-> +1920
  ; Global TTex_yVersatz := 0

  Global MoveStatusBar_RL := 1920 ; TODO: -1920 <-0-> +1920

  Global x_ToolTip1 := x_Versatz +24 	; SpeechRec-Command-Anzeigen
  Global x_ToolTip2 := x_Versatz +24		; ATC-Anzeige
  Global x_ToolTip3 := TTex_xVersatz 	; Checklist_ITEM (unter der StatusBar)
  Global x_ToolTip4 := x_Versatz +24		; Use Garmin
  Global x_ToolTip5 := x_Versatz +1 	; 'M' Speech_Mute und 'S' Speech_On; und 'SetComX'
  Global x_ToolTip6 := x_Versatz	+700	; _Message()
  Global x_ToolTip7 := x_Versatz +24 	; !!! ToolTip -> (Zeitzähler CMD_Process) Common_CMD.ahk
  Global x_ToolTip8 := x_Versatz +24 	; !!! ToolTip -> (Zeitzähler AircraftScenario) ShowDEBUGInfo
  Global x_ToolTip9 := x_Versatz +700 	; _Error_Message()
  Global x_ToolTip10 := x_Versatz +24 	; !!! ToolTip -> Show_DEBUG_Info

  ; !! StatusBar ToolTip für Write_Statusbar()
  ; TTex_Nr := 11 							; Array fängt bei 11 an
  ; TTex_StartPos[TTex_Nr] := TTex_xVersatz 	; x Startposition wird festgelegt
  ; TTex_xVersatz := TTex_xVersatz + 0 		; STATUSBAR Versatz in Aircraft-Dateien
  ; TTex_yVersatz := TTex_yVersatz + 0		; STATUSBAR Versatz in Aircraft-Dateien

  Global y_ToolTip1 := y_Versatz			; Sprachbefehl Anzeigen
  Global y_ToolTip2 := y_Versatz 		; ATC-Anzeige
  Global y_ToolTip3 := TTex_yVersatz +26 ; Checklist_ITEM (unter der STATUSBAR)
  Global y_ToolTip4 := y_Versatz +26		; Use Garmin
  Global y_ToolTip5 := y_Versatz 		; für 'M' Speechmute; 'S' Speech_On; und 'SetComX'
  Global y_ToolTip6 := y_Versatz +26		; _Message()
  Global y_ToolTip7 := y_Versatz +250 	; !!! ToolTip -> (Zeitzähler CMD_Process) Common_CMD.ahk
  Global y_ToolTip8 := y_Versatz +226 	; !!! ToolTip -> (Zeitzähler AircraftScenario) ShowDEBUGInfo
  Global y_ToolTip9 := y_Versatz +72 	; _Error_Message()
  Global y_ToolTip10 := y_Versatz +52 	; !!! ToolTip -> Show_DEBUG_Info

  ; !! Init für ToolTipEx()
  Global HFONT := _GetHFONT("s12", "Courier New") ; Standart = s8

  ; !! Init für ToolTipEx()
  Global MAX_TOOLTIPS := 40 ; maximum number of ToolTips to appear simultaneously

  ; !! Init für ToolTipEx()
  Global TT := Object()
  Loop, %MAX_TOOLTIPS%
    TT[A_Index] := {HW: 0, IC: 0, TX: ""}

  ; VARs aus Aircraft-Files

  ; TTex_FontB := 10 ; Spaltbreite 7
  ; TTex_FontS := 13 ; Breite eines Buchstabens
  ; TTex_Nr := 11 ; Statusbar fängt bei 11 an
  ; TTex_StartPos[TTex_Nr] := TTex_xVersatz ; x Startposition wird festgelegt

  ; STATUSBAR -> Enthält die x Startposition der nächsten TTex Anzeige
  Global TTex_StartPos := Object()
  loop ,%MAX_TOOLTIPS%
    TTex_StartPos[A_Index ] := 0

  ; STATUSBAR -> Enthält die alten FSVAR Werte vom vorherigen Durchlauf
  Global TTex_oFSVAR := Object()
  Loop ,%MAX_TOOLTIPS%
    TTex_oFSVAR[A_Index ] := 999

  ; AQUA BLACK BLUE FUCHSIA GRAY GREEN LIME MAROON NAVY OLIVE PURPLE RED SILVER TEAL WHITE YELLOW
  Global ItemColor := Object()
  Loop ,10
    ItemColor[A_Index ] := "YELLOW" ; A_Index beginnt immer mit 1

  ItemColor[10] := "WHITE"
  ItemColor[11] := "RED"
  ItemColor[12] := "WHITE"
  ItemColor[13] := "GREEN"
  ItemColor[14] := "WHITERED"
  ItemColor[15] := "BLUE"
  ItemColor[16] := "WHITE"
  ItemColor[17] := "MAGENTA"

DEV_Menu_VARs:

  ; !!Hotkey H_Start_Menu startet Menu

  MenuTitle	:= "--------------------" ; You can set any title here for the menu
  UMDelay	:= 20 ; Delay after which the menu is shown

  ; Create / Edit Menu Items here.
  ; You can use spaces in values (MenuItems) but not in section names.
  ; Don't worry about the order, the menu will be sorted (disabled).
  ; Dynamic menuitems here

  ; Syntax: Dyn# := "MenuItem|Window title"
  Global Dyn1 := "#Lockheed_DYN|Lockheed"
  Global Dyn2 := "#XPlane_DYN|X-System"
  Global Dyn3 := "#Notepad_DYN|Notepad"

  Global DynCount := 4 ; Anzahl + 1

  Global MenuItemsCount := 12 + DynCount ; Anzahl MenuItems + DynCount

  ; DEV_Menu_Items:

  Global MenuItems :=	"#_ABBRUCH
    /#_IVAO_web
    /#_VATSIM_web
    /#_Frei1
    /#_Frei2
    /#_VATSIM_Charts
    /#_IVAO_Charts
    /#_JEPP_int_Charts
    /#_IVAO_Routes
    /#_FS_Links
    /#_FS_Docs
    /#_Games
    /#_Lw_J
    /#_Del_Flightplans"

DEV_START:

  If _Is_any_Sim_active() {
    If Not (Aktu_Sim = Running_Sim) {
      MsgBox, 00, Warning!, Wrong Sim. Terminate App!,10
      ExitApp
    }
  }

  SetNumLockState Off

  Send {LWin Down}{Ctrl Down}{Left}{LWin Up}{Ctrl Up} ; Desktop zurücksetzen

  SoundGet, SoundVol_On ; aktuelle Lautstärke lesen

  FileDelete, %Aircraft_LOG_File%

  Gosub BETA_TEST ; normalerweise RETURN

  _Message("Start " Aktu_Sim " with " Aktu_Scenario " and " ATC_str, 0)
  _Aircraft_Log("Starte " Aktu_Sim " mit " Aktu_Scenario)

  _Aircraft_Log("Gosub Check_AdminMode")
  Gosub Check_AdminMode

  ; ExitApp, 0

  _Aircraft_Log("Gosub MACRO_INIT")
  Gosub MACRO_INIT

  _Aircraft_Log("Gosub AIRCRAFT_INIT") ; Proc in der Aircraft Datei
  Gosub AIRCRAFT_INIT

  _Aircraft_Log("Gosub SPEECH_INIT")
  Gosub SPEECH_INIT

  _Aircraft_Log("Gosub Kill_Apps_before_SIM")
  Gosub Kill_Apps_before_SIM

  If _Is_any_Sim_active() {
    _Aircraft_Log(Aktu_Sim " already active")

    TrayTip, FlightSim ,%Aktu_Sim%`nis already active.`nChecklists have been reset!, 3, 2

    _Aircraft_Log("Gosub Start_Aircraft_Scenario") ; startet FSUIPC und dann Aircraft_Scenario
    Gosub Start_Aircraft_Scenario
  }
  Else {
    _Aircraft_Log("No Sim is active")

    _Aircraft_Log("Gosub Start_Apps_before_SIM")
    Gosub Start_Apps_before_SIM

    _Aircraft_Log("Gosub SIM_INIT")
    Gosub SIM_INIT

    _Aircraft_Log("Gosub Start_Aircraft_Scenario")
    Gosub Start_Aircraft_Scenario

    _Aircraft_Log("Gosub Start_Apps_after_UIPC")
    Gosub Start_Apps_after_UIPC
  }

  ; SetTimer, Check_ARCARS_Error_Win, %Check_ARCARS_Error_Win_Delay%; !!!gibt Probleme

  SetTimer, POV, %POV_Delay%

  _Message("Es geht los...:-))",3)
  _Aircraft_Log("Es geht los...:-))")

  If DEBUG
    SetTimer, Show_DEBUG_Info, %Show_DEBUG_Info_Delay%

  If TEST {
    _Message("TESTMODUS ACTIVE!", 5)
    _Aircraft_Log("TESTMODUS ACTIVE!")
  }

DEV_SkipUAC_REMARKS:

; SkipUAC_IVAO_P3D.xml
; SkipUAC_Swift.xml
; SkipUAC_ActiveSky.xml
; SkipUAC_ActiveSkyXP.xml
; SkipUAC_IVAO_XP.xml
; SkipUAC_XP11.xml
; SkipUAC_LittleNM.xml
; SkipUAC_vaBaseLive.xml
; SkipUAC_CameraPos.xml
; SkipUAC_P3DV4.xml
; SkipUAC_Discord.xml
; SkipUAC_Send_Win_ESC.xml
; SkipUAC_IVAO_MSFS.xml
; SkipUAC_SimACARS.xml
; SkipUAC_IVAO_MSFS_Core.xml
; SkipUAC_StartAircraft.xml

Return

DEV_normale_Menu_Items:

#_ABBRUCH:
  {
    Return
  }
#_IVAO_web:
  {
    Run, %Brave% %IVAO_Web%
    Return
  }
#_VATSIM_web:
  {
    Run, %Brave% %VATSIM_Web%
    Return
  }
#_Frei1:
  {
    Return
  }
#_Frei2:
  {
    Return
  }
#_VATSIM_Charts:
  {
    Run, %Brave% %VATSIM_Charts%
    Return
  }
#_IVAO_Charts:
  {
    Run, %Brave% %IVAO_Charts%
    Return
  }
#_JEPP_Int_Charts:
  {
    Run, Explorer "D:\Games\00_FS_ORDNER\60_CHARTS\JEPP_INT\"
    Return
  }
#_IVAO_Routes:
  {
    Run, %Chrome% " https://www.ivao.aero/db/route/default.asp"
    Return
  }
#_FS_Links:
  {
    Run, Explorer "D:\Games\10_FS_LINKS\"
    Return
  }
#_Del_Flightplans:
  {
    Gosub, DeleteFlightPlans
    Return
  }
#_FS_Docs:
  {
    run, Explorer "D:\Games\00_FS_ORDNER\10_DOCS"
    Return
  }
#_Games:
  {
    Run, Explorer "d:\Games\"
    Return
  }
#_Lw_J:
  {
    Run, Explorer "J:\"
    Return
  }

; DEV_dynamische_Menu_Items:

#Lockheed_DYN: ; DYN1
  {
    _Message("DEV_dynamische_Menu_Items! Seems like it works!", 4)
    Return
  }
#XPlane_DYN: ; DYN2
  {
    _Message("DEV_dynamische_Menu_Items! Seems like it works!", 4)
    Return
  }
#Notepad_DYN: ; DYN3
  {
    _Message("DEV_dynamische_Menu_Items! Seems like it works!", 4)
    Return
  }
Return

H_Get_Menu_Item:

  HotKey, ~LButton, Off

  If Not WinActive(MenuTitle) {
    ToolTip
    Return
  }

  CoordMode, Mouse, Relative
  MouseGetPos, mX, mY
  ToolTip

  mY -= 3		; 3	space after which first line starts
  mY /= 15	; 13	space taken by each line

  ; MsgBox, 0, Info, 1) Pos %mY% von %numItems%, 2

  If (mY = 0)
    Return

  If (mY > numItems)
    Return

  ; MsgBox, 0, Info, 2) Pos %mY% von %numItems%, 2

  StringTrimLeft, TargetSection, MenuItem%mY%, 0
  StringReplace, TargetSection, TargetSection, %a_space%,, A

  Gosub %TargetSection%
Return

H_Start_Menu: ; M-Button with delay

  SetTitleMatchMode, 2 ; Falls es 3 ist. Diese Einstellung gilt nur für diesen Thread.

  HowLong := 0
  Loop
  {
    HowLong ++
    Sleep, 10
    GetKeyState, MButton, MButton, P
    IfEqual, MButton, U, Break
  }

  If (HowLong < UMDelay)
    Return

  ; prepares dynamic menu
  DynMenu := ""
  Loop
  {
    If (a_index = DynCount)
      Break

    ; Ifqual, Dyn%a_index%,, Break

    StringGetPos, ppos, dyn%a_index%, |
    StringLeft, item, dyn%a_index%, %ppos%
    ppos += 2
    StringMid, win, dyn%a_index%, %ppos%, 1000

    If WinActive(win)
      DynMenu = %DynMenu%/%item%
  }

  ; Joins sorted main menu and dynamic menu
  ; Sort, MenuItems, D/
  TempMenu = %MenuItems%%DynMenu%

  ; clears earlier entries
  Loop
  {
    If (a_index = MenuItemsCount)
      Break
    ; IfEqual, MenuItem%a_index%,, Break

    MenuItem%a_index% =
  }

  ; creates new entries
  Loop, Parse, TempMenu, /
  {
    MenuItem%a_index% = %a_loopfield%
  }

  ; creates the menu
  Menu = %MenuTitle%
  numItems := 0

  Loop
  {
    If (a_index = MenuItemsCount)
      Break

    ; IfEqual, MenuItem%a_index%,, Break

    numItems ++
    StringTrimLeft, MenuText, MenuItem%a_index%, 0
    Menu = %Menu%`n%MenuText%
  }

  ; MouseGetPos, mX, mY
  mx := -180
  mY := 0

  ; Hotkey wird in H_Get_Menu_Item wieder deaktiviert!
  HotKey, ~LButton, H_Get_Menu_Item
  HotKey, ~LButton, On

  ToolTip, %Menu%, %mX%, %mY%

  WinActivate, %MenuTitle%
Return

BETA_TEST:
; hh := "115"
; MsgBox % Format("{:04}", hh)

; Beta_Test wird immer aufgerufen!
; MsgBox Beta_Test Hallo
; ExitApp
Return

Check_AdminMode:
  ; AutoHotkeySC.bin
  ; Ansi 32-bit.bin
  ; Unicode 32-bit.bin
  ; Unicode 64-bit.bin

  Aircraft := StrReplace(CMD_File, ".ahk" , ".exe") ; Name aus Aircraft-Datei erstellen

  ; _Message("AircraftFile= " Aircraft " " A_ScriptName " " CMD_File, 15)
  ; _Message("AircraftFile= " Aircraft " " A_ScriptName " " CMD_File, 15)
  ; _Message("AircraftFile= " Aircraft " " CMD_File " " A_ScriptName, 30)

  If (A_ScriptName == CMD_File) ; Wenn es noch .ahk file -> .exe compilieren?
  {
    ; _Message("?" Aircraft A_ScriptName CMD_File, )

    RunWait, C:\WINDOWS\system32\schtasks.exe /run /tn SkipUAC_KillAircraft
    Sleep, 1000

    FileDelete, %BIN_Path%StartAircraft.exe
    Sleep, 1000

    ;  _Message("StartAircraft.exe gelöscht??", 10)

    RunWait, %AHK_EXE% /in "%AHK_Path%%CMD_File%" /out "%BIN_Path%%Aircraft%" /bin "%AHK_Compiler%" /icon "%FILE_ICON%"

    FileCopy, %BIN_Path%%Aircraft%, %BIN_Path%StartAircraft.exe

    ; _Message("StartAircraft.exe erstellt!!", 10)

    ; mit admin Rechten H_Start_Menu

    SkipUAC := "SkipUAC_StartAircraft"
    RunWait, C:\WINDOWS\system32\schtasks.exe /run /tn %SkipUAC%,,Hide UseErrorLevel

    If !ErrorLevel ; wenn kein Fehler und somit SkipUAC vorhanden war
      ExitApp
    Else
      _Error_Message("SkipUAC_StartAircraft faild", 10)

  }

  if Not A_IsAdmin
  {
    MsgBox, 0x31,,"Program is not running as administrator. To continue anyway, click OK. Otherwise click Cancel."

    IfMsgBox Cancel
    ExitApp

  }
Return

_Search_XML_Item(File, StartLineNr, ItemStr) { ; LineNr

  local Line := ""
  local LineNr := StartLineNr

  While Not (InStr(Line, ItemStr) Or ErrorLevel)
    FileReadLine, Line, %File%, LineNr++

  If ErrorLevel
  {
    _Error_Message("Search_XML_Item: Not found after Line/Item: " StartLineNr " / " ItemStr " in: " Filename, 5)
    Return 1
  }

  Return --LineNr
}

_Get_XML_Item(File, LineNr) { ; ItemStr

  local Line := ""

  FileReadLine, Line, %File%, LineNr

  If ErrorLevel {
    _Error_Message("Get_XML_Item: Error Line " LineNr , 5)
    Return ""
  }

  local Pos1 := InStr(Line, ">",,, 1) + 1
  local Pos2 := InStr(Line, "<",,, 2)

  ; _Message(SubStr(Line, Pos1, Pos2-Pos1), 5)

  Return SubStr(Line, Pos1, Pos2-Pos1)
}

LoadVatsimFlightPlan:

  ; D:\Games\IVAO\Flightplans\*.fpl
  ; D:\Games\VATSIM\Flightplans\*.vfp

  Loop Files, D:\Games\VATSIM\Flightplans\*.vfp, R
    FileName := A_LoopFileFullPath ; A_LoopFileName

  ; MsgBox FileName : %FileName%

  Line := ""

  FileReadLine, Line, %FileName%, 1
  If ErrorLevel
  {
    _Error_Message("VATSIM FP nicht gefunden", 5)
    Return
  }
  Else
  {
    ; MsgBox Line gelesen: %Line%

    Line 	:= Substr(Line, InStr(Line, "FlightType"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    FlightType := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %FlightType%

    Line 	:= Substr(Line, InStr(Line, "Equipment"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    Equipment := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %Equipment%

    Line 	:= Substr(Line, InStr(Line, "CruiseAltitude"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    CruiseAltitude := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %CruiseAltitude%

    Line 	:= Substr(Line, InStr(Line, "CruiseSpeed"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    CruiseSpeed := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %CruiseSpeed%

    Line 	:= Substr(Line, InStr(Line, "DepartureAirport"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    DepartureAirport := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %DepartureAirport%

    Line 	:= Substr(Line, InStr(Line, "DestinationAirport"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    DestinationAirport := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %DestinationAirport%

    Line 	:= Substr(Line, InStr(Line, "AlternateAirport"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    AlternateAirport := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %AlternateAirport%

    Line 	:= Substr(Line, InStr(Line, "Route"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    Route := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %Route%

    Line 	:= Substr(Line, InStr(Line, "Remarks"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    Remarks := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %Remarks%

    Line 	:= Substr(Line, InStr(Line, "IsHeavy"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    IsHeavy := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %IsHeavy%

    Line 	:= Substr(Line, InStr(Line, "EquipmentPrefix"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    EquipmentPrefix := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %EquipmentPrefix%

    Line 	:= Substr(Line, InStr(Line, "EquipmentSuffix"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    EquipmentSuffix := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %EquipmentSuffix%

    Line 	:= Substr(Line, InStr(Line, "DepartureTime"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    DepartureTime := Format("{:04}", SubStr(Line, Pos1, Pos2-Pos1))

    ; MsgBox %DepartureTime%

    Line 	:= Substr(Line, InStr(Line, "EnrouteHours"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    EnrouteHours := Format("{:02}", SubStr(Line, Pos1, Pos2-Pos1))

    ; MsgBox %EnrouteHours%

    Line 	:= Substr(Line, InStr(Line, "EnrouteMinutes"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    EnrouteMinutes := Format("{:02}", SubStr(Line, Pos1, Pos2-Pos1))

    ; MsgBox %EnrouteMinutes%

    Line 	:= Substr(Line, InStr(Line, "FuelHours"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    FuelHours := Format("{:02}", SubStr(Line, Pos1, Pos2-Pos1))

    ; MsgBox FuelHours:%FuelHours%

    Line 	:= Substr(Line, InStr(Line, "FuelMinutes"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    FuelMinutes := Format("{:02}", SubStr(Line, Pos1, Pos2-Pos1))

    ; MsgBox %FuelMinutes%

    Line 	:= Substr(Line, InStr(Line, "VoiceType"), StrLen(Line))
    Pos1 := InStr(Line, """",,, 1) + 1
    Pos2 := InStr(Line, """",,, 2)
    VoiceType := SubStr(Line, Pos1, Pos2-Pos1)

    ; MsgBox %VoiceType%
  }

; Err := _Text_to_Speech("VATSIM Flightplan loaded!")
Return

LoadAktuFlightPlan:

  FP_FlightRules := "IFR"
  FormatTime, FP_DepTime,, HHMM
  FP_FlightLevelType := "F"

  FP_Departure := ""

  Loop Files, %Flightplan_Path%*.xml, R ; Durchsucht D:\Games\00_FS_ORDNER\50_FLIGHT_PLANS\
  {
    FileName := A_LoopFileFullPath ; A_LoopFileName
  }

  ; MsgBox FileName : %FileName%

  Index := 1
  Index := _Search_XML_Item(FileName, Index, "<general>")
  If Index = 1
    Return ; dann wurde nichts gefunden
  Else
  {
    Index := _Search_XML_Item(FileName, Index, "<icao_airline>")
    FP_Airline := _Get_XML_Item(FileName, Index) ; ItemStr
    ; MsgBox FP_Airline: %FP_Airline%

    Index := _Search_XML_Item(FileName, Index, "<flight_number>")
    FP_FlightNumber := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_FlightNumber: %FP_FlightNumber%

    Index := _Search_XML_Item(FileName, Index, "<initial_altitude>")
    FP_FlightLevel := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_FlightLevel: %FP_FlightLevel%

    Index := _Search_XML_Item(FileName, Index, "<route_ifps>")
    FP_Route := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_Route: %FP_Route%
  }

  Index := _Search_XML_Item(FileName, Index, "<origin>")
  If Index = 1
    Return ; dann wurde nichts gefunden
  Else
  {
    Index := _Search_XML_Item(FileName, Index, "<icao_code>")
    FP_Departure := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_Departure: %FP_Departure%
  }

  Index := _Search_XML_Item(FileName, Index, "<destination>")
  If Index = 1
    Return ; dann wurde nichts gefunden
  Else
  {
    Index := _Search_XML_Item(FileName, Index, "<icao_code>")
    FP_Destination := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_Destination: %FP_Destination%
  }

  Index := Index + 1000

  Index := _Search_XML_Item(FileName, Index, "<aircraft>")
  If Index = 1
    Return ; dann wurde nichts gefunden
  Else
  {
    Index := _Search_XML_Item(FileName, Index, "<icaocode>")
    FP_AircraftICAO := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_AircraftICAO: %FP_AircraftICAO%
  }

  Index := _Search_XML_Item(FileName, Index, "<weights>")
  If Index = 1
    Return ; dann wurde nichts gefunden
  Else
  {
    Index := _Search_XML_Item(FileName, Index, "<pax_count>")
    FP_Paxe := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_Paxe: %FP_Paxe%

    Index := _Search_XML_Item(FileName, Index, "<cargo>")
    FP_Cargo := _Get_XML_Item(FileName, Index)
    ; MsgBox FP_Cargo: %FP_Cargo%
  }

Return

DeleteFlightPlans:

  ;"D:\Games\00_FS_ORDNER\50_FLIGHT_PLANS\"
  FileDelete, %Flightplan_Path%*.pln
  FileDelete, %Flightplan_Path%*.xml
  FileDelete, %Flightplan_Path%*.html
  FileDelete, %Flightplan_Path%*.flp
  FileDelete, %Flightplan_Path%FlightPlanPDF\*.pdf

  ; Online
  FileDelete, D:\Games\IVAO\Flightplans\*.fpl
  FileDelete, D:\Games\VATSIM\Flightplans\*.vfp

  ; MSFS
  FileDelete, I:\WpSystem\S-1-5-21-746773014-728480166-310642377-1001\AppData\Local\Packages\Microsoft.FlightSimulator_8wekyb3d8bbwe\LocalState\FlightPlans\*.pln
  FileDelete, C:\Users\achim\AppData\Local\Packages\Microsoft.FlightSimulator_8wekyb3d8bbwe\LocalState\_FlightPlans\*.pln
  FileDelete, C:\Users\achim\AppData\Local\Packages\Microsoft.FlightSimulator_8wekyb3d8bbwe\LocalState\*.pln

  ; P3D
  FileDelete, C:\Users\achim\Documents\Prepar3D v4 Files\*.pln
  FileDelete, J:\Lockheed Martin\Prepar3D v4\PMDG\FLIGHTPLANS\777\*.rte
  FileDelete, J:\Lockheed Martin\Prepar3D v4\PMDG\FLIGHTPLANS\*.rte
  FileDelete, C:\Users\achim\Documents\Aerosoft\General\A3XX Flightplans\*.flp

  ; XPlane11
  FileDelete, J:\X-Plane 11\Output\FMS plans\*.fms
  FileDelete, J:\X-Plane 11\Aircraft\JD330XP11\FlightPlans\*.txt

  ; XPlane12
  FileDelete, J:\X-Plane 11\Output\FMS plans\*.fms
  FileDelete, J:\X-Plane 11\Aircraft\JD330XP11\FlightPlans\*.txt

Return

LNM_Check_SaveWin:

  Loop 10 {
    If WinActive("Little Navmap - Flugplan im")
      Break
    Sleep, 300
  }

  Send {Enter}

  Sleep,500
Return

H_LNM_IFR:

  ; Wird nur benötigt, wenn ACARS Macro genutzt wird

  If Not WinActive("Little Navmap")
  {
    ; _Message("For IFR-plans activate Little Navmap first!")
    Err := _Text_to_Speech("For IFR-plans activate Little Navmap first!")
    Return
  }

  Gosub, LoadAktuFlightPlan ; Felder für ACARS Macro laden

  WinActivate, Little Navmap

  ; FP_FlightLevel und IVR in LNM-Felder eintragen
  Send {Shift Down}{Home}{Shift Up}
  Sleep, 500
  Send %FP_FlightLevel%
  Send {Tab}I

  WinActivate, Active Sky
Return

H_LNM_VFR:

  ; Wird nur benötigt, wenn VATSIM Macro genutzt wird

  If Not WinActive("Little Navmap")
  {
    Err := _Text_to_Speech("For VFR-plans activate Little Navmap first!")
    Return
  }

  Gosub, LoadVatsimFlightPlan

; FP_FlightRules := "VFR"
; FormatTime, FP_DepTime,, HHMM
; FP_FlightLevelType := "F"

; ; FP_CallSign := "AFX6"
; ; FP_Airline := "AFX"
; ; FP_FlightNumber := "6"

; FP_FlightLevel := 2000 ; wird überschrieben
; FP_Route := "DCT"
; ; FP_Departure := "EDDL"  ; wird überschrieben
; ; FP_Destination := "EDLW"  ; wird überschrieben

; FP_Speed := "130"

; ; https://en.wikipedia.org/wiki/Equipment_codes
; ; https://mediawiki.ivao.aero/index.php?title=Flight_plan_equipment_methodology
; FP_Equipment := "SFG"
; FP_Transponder := "C"

; FP_Paxe :="1"
; FP_Cargo :="10"

Return

H_ResetApp:
  ; Hotkey Shift+Esc

  Run, "%AHK_Path%%CMD_File%"

ExitApp

H_EndApp:
  ; Hotkey Ctrl+Esc

  Send {Alt Up}{Shift Up}{Ctrl Up}
  Run, "C:\Program Files\AutoHotkey\AutoHotkeyU32.exe" "d:\diverses\scripte_AHK\PRIVATE.ahk"
; Run, "C:\Program Files\Google\Drive\googledrivesync.exe"

ExitApp

H_EndApp_KillAll:
  ; Hotkey Ctrl+Alt+Esc

  KillAll_On := True

  Send {Alt Up}{Shift Up}{Ctrl Up} ; sicher ist sicher :-)

  SoundBeep, 600, 200
  SoundBeep, 400, 500

  MsgBox, 4100, Warning!, Terminate all FS-processes?, 10


  If true { ; wegen Warn... und Formatter
    IfMsgBox, No
    Return
    Else
      MsgBox, ,OK, Terminate all FS-processes! Bye..., 3

  }

  SetNumLockState On

  If Not TEST {
    If WinExist(VATSIM_Map_str) {
      ; _Message("VATSIM map found!",3)
      WinActivate, %VATSIM_Map_str%
      Sleep, 1000
      send {ALT Down}{F4}{ALT Up}
    }

    If WinExist(IVAO_Map_str) {
      ; _Message("IVAO map found!",3)
      WinActivate, %IVAO_Map_str%
      Sleep, 1000
      send {ALT Down}{F4}{ALT Up}
    }

    If WinExist("SimBrief.com") {
      ; _Message("SimBrief.com found!",3)
      WinActivate, SimBrief.com
      Sleep, 1000
      send {ALT Down}{F4}{ALT Up}
    }

    While WinExist("WebFMC") {
      ; _Message("WebFMC found!",3)
      WinActivate, WebFMC
      Sleep, 1000
      send {ALT Down}{F4}{ALT Up}
    }

    If WinExist("Active Sky") {
      WinActivate, Active Sky
      Sleep, 1000
      Send {ALT Down}{F4}{ALT Up}
      Send {Enter} ; Nachfrage "wirklich"
    }

    Process, Close, SimBrief Downloader.exe

    Process, Close, LittleNavMap.exe
  }

  ; MSFS Files
  Process, Close, FlightSimulator.exe
  Process, Close, FSUIPC7.exe

  ; P3D Files
  Process, Close, P3D.exe
  Process, Close, Prepar3D.exe
  Process, Close, SimObjectDisplayEngine.exe ; SODE
  Process, Close, CameraPositionX_P3D_V4.exe
  ; Process, Close, AS_P3Dv4.exe
  ; Process, Close, AS Cloud Art.exe

  ; XPlane Files
  Process, Close, X-Plane.exe
  Process, Close, X-Plane.exe

  ; VATSIM Files
  Process, Close, VPilot.exe
  Process, Close, XPilot.exe

  ; IVAO Files
  Process, Close, PilotUI.exe
  Process, Close, Pilot_core_fs2020.exe

  Run, "C:\Program Files\AutoHotkey\AutoHotkeyU32.exe" "d:\diverses\scripte_AHK\PRIVATE.ahk"
; Run, "C:\Program Files\Google\Drive\googledrivesync.exe"

ExitApp

H_CheckList_Break:
  If Not WinActive(Aktu_Sim) {
    WinActivate, %Aktu_Sim%
    WinActivate, ahk_class %Aktu_Sim%
  }

  Err := _CMD("checklist break")

Return

H_CheckItem_Ok:

  If Not WinActive(Aktu_Sim) {
    WinActivate, %Aktu_Sim%
    WinActivate, ahk_class %Aktu_Sim%
  }

  x := 0
  While GetKeyState(T_Checkitem_Ok2) OR GetKeyState(T_Checkitem_Ok3)
  {
    Sleep, ButtonWait_Delay

    x++

    If (x = 10) {
      Err := _CMD("checklist break")
      Return
    }
  }

  Err := _CMD("okay")
  Err := _Text_to_Speech("okay")

; SoundBeep, 200, 40

Return

H_ATC:
  ; IVAO Altitude on		-> RControl
  ; VATSIM vPilot	on		-> RControl
  ; VATSIM xPilot	on		-> RControl - y
  ; DISCORD push to mute	-> Shift+Control + q
  ; Team Speak3	on		-> AltGr

  ; DISCORD Voice aus		-> Media_Play_Pause (used in "speech on/off")

  If Not WinActive(Aktu_Sim) {
    WinActivate, %Aktu_Sim%
    WinActivate, ahk_class %Aktu_Sim%
  }

  If Speech_On
    Err := _CMD("speech off")

  s.Listen(False)

  If TRAINING_active {
    ATC_str := "Training_TS"
    Send {RAlt Down}
  }
  Else {
    If VATSIM_active {
      ATC_str := "VATSIM-ATC"

      If (Aktu_Sim == XPLANE)
        Send {RCtrl Down}{y down}
      Else
        Send {RCtrl Down}
    }
    Else {
      If IVAO_active {
        ATC_str := "IVAO-ATC"
        Send {RCtrl Down}
      }
      Else {
        ATC_str := "ATC_ON"
      }
    }
  }

  Send {Shift down}{Ctrl down}{q down} ; DISCORD push to mute on

  SoundBeep, 700, 30
  SoundGet, SoundVol_On
  SoundSet, SoundVol_Off

  Err := ToolTipEx( ATC_str, x_Tooltip2, y_Tooltip2, 2, HFONT, "Lime", "Black", "", "S")

  While (GetKeyState(T_RightPedal, "P") And Not GetKeyState(T_LeftPedal, "P"))
    Sleep, 500

  While (GetKeyState(T_RightPedal2, "P") And Not GetKeyState(T_LeftPedal2, "P"))
    Sleep, 500

  While (GetKeyState(T_RightPedal3, "P"))
    Sleep, 500

  Send {RCtrl Up}{y up}
  Send {RAlt Up} ; Training/ TS3
  Send {Shift up}{Ctrl up}{q up} ; DISCORD push to mute off

  SoundSet, SoundVol_On

  Err := ToolTipEx(,,, 2)
Return

H_SpeechRec:

  ; IVAO Altitude on		-> RControl
  ; VATSIM vPilot	on		-> RControl
  ; VATSIM xPilot	on		-> RControl - y
  ; DISCORD push to mute	-> Shift+Control + q
  ; Team Speak3	on		-> AltGr

  ; DISCORD Voice aus		-> Media_Play_Pause (used in "speech on/off")

  If Not FSUIPC_Ok ; Or Speech_On
    Return

  Prellen := True
  SoundBeep, 400, 30

  If Not WinActive(Aktu_Sim)
  {
    WinActivate, %Aktu_Sim%
    WinActivate, ahk_class %Aktu_Sim%
  }

  x := 0
  While (GetKeyState(T_LeftPedal) OR GetKeyState(T_LeftPedal2))
  {
    Sleep, ButtonWait_Delay

    x++

    If x = 10
    {
      Gosub Close_SpeechRec

      If Speech_On
        Err := _CMD("speech off")
      Else
        Err := _CMD("speech on")

      Return
    }
  }

  If Listen_On ; dann ist Speech ON
  {
    Return
  }

  SoundGet, SoundVol_On
  SoundSet, SoundVol_Off

  Speech_Found := False
  s.Listen(True)

  Err := ToolTipEx("?> ", x_Tooltip1, y_Tooltip1, 1, HFONT, "Lime", "Black", "", "S")

  Send {Shift Down}{Ctrl Down}{q down} ; DISCORD Micro Off

  SetTimer, Close_SpeechRec, %CloseSpeech_Delay%

Return

Close_SpeechRec:

  If Not (Speech_Found OR Speech_On) {
    Old_CMD_Text := ""
  }
  ; If GetKeyState(T_LeftPedal) Or GetKeyState(T_LeftPedal2) Or Speech_On
  If Speech_On {
    s.Listen(True)
    Err := ToolTipEx("?> " Old_CMD_Text, x_Tooltip1, y_Tooltip1, 1, HFONT, "Lime", "Black", "", "S")
  }
  Else {
    SetTimer,, Off
    SoundSet, SoundVol_On

    s.Listen(False)
    Err := ToolTipEx("!> " Old_CMD_Text, x_Tooltip1, y_Tooltip1, 1, HFONT, "White", "Black", "", "S")

    Send {q up}{Ctrl up}{Shift up} ; DISCORD Micro On
  }

Return

_IsBlank(x) {
  If (x = " ") ; Frequenzeingabe abbrechen
  {
    SetNumLockState Off
    SetTimer, Aircraft_Scenario, On
    Err := ToolTipEx(,,,5)

    SoundBeep, 250, 880
    Return 1
  }
  Return 0
}

H_SetCom1:

  If RightPedal_pressed ; Wenn ATC on
    Return

  If (Aktu_Sim == "X-System")
    Err := _Set_XP_Com(0x5530, 1)
  Else
    Err := _Set_P3D_Com(0x311A, 1)

  If Speech_Mute
    Err := ToolTipEx("M", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S")

  If Speech_On
    Err := ToolTipEx("S", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S")
Return

H_SetCom2:

  If RightPedal_pressed ; Wenn ATC on
    Return
  If (Aktu_Sim == "X-System")
    Err := _Set_XP_Com(0x5534, 2)
  Else
    Err := _Set_P3D_Com(0x311C, 2)

  If Speech_Mute
    Err := ToolTipEx("M", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S")

  If Speech_On
    Err := ToolTipEx("S", x_Tooltip5, y_Tooltip1, 5, HFONT, "Lime", "Black", "", "S")
Return

_Set_P3D_Com(ComOffsStby, Com) {
  Local ComStby := 0x1800
  Local ComActu := 0x1800
  Local ComX := 0x1800

  SetTimer, Aircraft_Scenario,Off
  SetNumLockState On

  Err := ToolTipEx("1", x_ToolTip5, y_ToolTip5, 5, HFONT, "RED", "withe", "", "S")
  SoundBeep, 250, 80
  While True
  {
    Input x, L1 ; x00.000

    If _IsBlank(x)
      Return

    If (x = "1")
    {
      ComX := 0x1800
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", uint, 0x034E, uint, 2, uint, &ComActu, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("2", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")
  ; s := format("{1:x}", ComX)
  ; _Message("0x1" s, 0)

  While True
  {
    Input x, L1 ; 0x0.000

    If _IsBlank(x)
      Return

    If (x >= "1") And (x <= "3")
    {
      If (x >= "2") And (x <= "3")
        ComX := 0x1000 * x
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("3", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  If (ComX = 0x1800)
    ComX := 0x1000

  While True
  {
    Input x, L1 ; 00x.000

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9") And Not ((ComX = 0x3000) And (x > 6))
    {
      If (ComX > 0x1000)
      {
        ComX := ComX + (0x0100 * x)
        Break
      }

      If (x = "8") Or (x = "9")
      {
        ComX := 0x1000 + (0x0100 * x)
        Break
      }
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("4", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  While True
  {
    Input x, L1 ; 000.x00

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9")
    {
      ComX := ComX + (0x0010 * x)
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("5", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  While True
  {
    Input x, L1 ; 000.0x0

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9")
    {
      ComX := ComX + (0x0001 * x)
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("6", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  Input x, L1 ; 000.00x funktioniert bei P3D nicht

  ; If (x >= "0") And (x <= "9")
  ; {
  ; ComX := ComX + x
  ; transform, ComStby, chr, %ComX%
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
  ; }

  If (Com == 1)
  {
    Err := ToolTipEx("?", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

    Input x, L1 T2

    If (x >= " ")
    {
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x034E, uint, 2, uint, &ComStby, uint, &dwResult)
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

      SoundBeep, 250, 80
      SoundBeep, 250, 80

      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComActu, uint, &dwResult)
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

      ; Err := _CMD("Switch Radio")
    }
    else SoundBeep, 250, 80

    }

  SetNumLockState Off
  SetTimer, Aircraft_Scenario, On
  Err := ToolTipEx(,,,5)
  Return 0
}

_Set_XP_Com(ComOffsStby, Com) {

  Local ComStby := 0x1800
  Local ComActu := 0x1800
  Local ComX := 0x1800

  SetTimer, Aircraft_Scenario, Off
  SetNumLockState On

  Err := ToolTipEx("1", x_ToolTip5, y_ToolTip5, 5, HFONT, "RED", "withe", "", "S")
  SoundBeep, 250, 80

  While True
  {
    Input x, L1 ; x00.000

    If _IsBlank(x)
      Return

    If (x = "1")
    {
      ComX := 18000
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("2", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")
  ; s := format("{1:x}", ComX)
  ; _Message("0x1" s, 0)

  While True
  {
    Input x, L1 ; 0x0.000

    If _IsBlank(x)
      Return

    If (x >= "1") And (x <= "3")
    {
      If (x >= "2") And (x <= "3")
        ComX := 10000 * x

      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("3", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  If (ComX = 18000)
    ComX := 10000

  While True
  {
    Input x, L1 ; 00x.000

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9") And Not ((ComX = 3000) And (x > 6))
    {
      If (ComX > 10000)
      {
        ComX := ComX + (1000 * x)
        Break
      }

      If (x = "8") Or (x = "9")
      {
        ComX := 10000 + (1000 * x)
        Break
      }
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("4", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  While True
  {
    Input x, L1 ; 000.x00

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9")
    {
      ComX := ComX + (100 * x)
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("5", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  While True
  {
    Input x, L1 ; 000.0x0

    If _IsBlank(x)
      Return

    If (x >= "0") And (x <= "9")
    {
      ComX := ComX + (10 * x)
      Break
    }

    SoundBeep, 250, 880
  }

  transform, ComStby, chr, %ComX%
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

  Err := ToolTipEx("6", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

  Input x, L1 ; 000.00x

  If (x >= "0") And (x <= "9")
  {
    ComX := ComX + x
    transform, ComStby, chr, %ComX%

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, ComOffsStby, uint, 2, uint, &ComStby, uint, &dwResult)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
  }

  If (Com == 1)
  {
    Err := ToolTipEx("?", x_Tooltip5, y_Tooltip5, 5, HFONT, "RED", "withe", "", "S")

    Input x, L1 T2

    If (x >= " ")
    {
      ComActu := COM1_ACT_F - 100000

      NumPut(ComActu, ComActu, 0, "int")
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x5530, int, 4, int, &ComActu, int, &dwResult) ; Com1 Standby
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

      SoundBeep, 250, 80
      SoundBeep, 250, 80
      sleep,500

      NumPut(ComX, ComX, 0, "int")
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x5538, int, 4, int, &ComX, int, &dwResult) ; Com1 Actu
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

      ; Err := _CMD("Switch Radio")

    }
    else SoundBeep, 250, 80
    }

  SetNumLockState Off
  SetTimer, Aircraft_Scenario, On
  Err := ToolTipEx(,,,5)
  Return 0
}

Kill_Apps_before_SIM:

  _Aircraft_Log("START -> Kill_Apps_before_SIM")

  _Aircraft_Log("close AutoHotkey.exe")
  Process, Close, AutoHotkey.exe ; !!!
  Sleep, 300

  _Aircraft_Log("close AutoHotkeyU32.exe")
  Process, Close, AutoHotkeyU32.exe ; !!!
  Sleep, 300

  _Aircraft_Log("close AutoHotkeyU32.exe")
  Process, Close, AutoHotkeyU64.exe ; !!!
  Sleep, 300

  _Aircraft_Log("close fdm.exe")
  Process, Close, fdm.exe ; Downloadmanager
  Sleep, 300

  _Aircraft_Log("close PowerToys.exe")
  Process, Close ,PowerToys.exe
  Sleep, 1000

  ; _Aircraft_Log("close googledrivesync.exe")
  ; Process, Close, googledrivesync.exe ; 2x sonst funktioniert es nicht
  ; Sleep, 300

  ; Process, Close, KeePass.exe

  _Aircraft_Log("DONE -> Kill_Apps_before_SIM")
Return

Start_Apps_before_SIM:

  _Aircraft_Log("START -> Start_Apps_before_SIM")

  If Not TEST
  {
    _Aircraft_Log("remove flightplans")
    Gosub, DeleteFlightPlans

    If (ATC_str == "IVAO-ATC") {
      _Aircraft_Log("show IVAO map")
      Err := _Cmd("show IVAO map")
    }
    Else {
      _Aircraft_Log("show VATSIM map")
      Err := _Cmd("show VATSIM map")
    }

    _Aircraft_Log("show simbrief")
    Err := _Cmd("show simbrief")

    _Aircraft_Log("show commands")
    Err := _CMD("show commands")

    ; _Aircraft_Log("login air fox")
    ; Err := _CMD("login air fox")

    _Aircraft_Log("show little nav map")
    Err := _CMD("show little nav map")
  }

  _Aircraft_Log("DONE -> Start_Apps_before_SIM")

Return

Start_Apps_after_UIPC:

  _Aircraft_Log("START -> Start_Apps_after_UIPC")

  If Not TEST
  {
    If VATSIM_active
    {
      _Aircraft_Log("goto VATSIM")
      Err := _CMD("goto VATSIM")
    }

    If IVAO_active
    {
      _Aircraft_Log("goto IVAO")
      Err := _CMD("goto IVAO")
    }

    ; If Not XP12 {
    _Aircraft_Log("show active sky")
    Err := _CMD("show active sky")
    ; }
  }

  _Aircraft_Log("DONE -> Start_Apps_after_UIPC")

Return

SIM_INIT:

  TrayTip, FlightSim ,%Aktu_Sim% mit %ATC_str%`n%Aktu_Scenario%,3,1
  
  _Message("Waiting for the Sim...", 0)
  
  If (Aktu_Sim = MSFS) ; MSFS2020 wird gestartet
  {
    ; Run, D:\Games\10_FS_LINKS\95_MSFS_Run ; TODO: richtig starten
    Run, cmd.exe /C start shell:AppsFolder\Microsoft.FlightSimulator_8wekyb3d8bbwe!App -FastLaunch

    Loop 100
    {
      Process, Exist, FlightSimulator.exe

      If ErrorLevel
        Break
      Else
        Sleep, 1000
    }

    If NOT ErrorLevel
    {
      MsgBox %MSFS% konnte nicht gestartet werden!
      ExitApp,
    }

    ; _Aircraft_Log( MSFS " is active")

    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_FSUIPC_MSFS,,Hide,MSFS_PID
    _Aircraft_Log("FSUIPC7.exe ist gestartet")

    ; Run, D:\Games\FSUIPC_MSFS\FSUIPC7.exe
    ; Sleep, 1000
    ; Process, Exist ,FSUIPC7.exe
    ; If ErrorLevel
    ; {
    ; 	; Process, Close ,FSUIPC7.exe
    ; 	_Aircraft_Log("FSUIPC7 Process nicht erkannt!")
    ; 	MsgBox FSUIPC Process nicht erkannt!
    ; }
  }

  If (Aktu_Sim = P3DV4) ; P3D wird gestartet
  {
    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_P3DV4,,Hide,P3DV4_PID

    Loop 100
    {
      Process, Exist, Prepar3D.exe
      If ErrorLevel
        Break
      Else
        Sleep, 1000
    }

    If NOT ErrorLevel
    {
      MsgBox %P3DV4% konnte nicht gestartet werden!
      ExitApp,
    }

    ; _Aircraft_Log( P3DV4 " is active")

    Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_CameraPos,,Hide
    _Aircraft_Log( "CameraPos is active")

    ; If Not TEST
    ; {
    ; 	Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_ActiveSky,,Hide,P3D_PID
    ; 	_Aircraft_Log( "ActiveSky is active")
    ; }
  }

  If (Aktu_Sim = XPLANE) ; X-Plane wird gestartet
  {
    
    If XP12
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_XP12,,Hide,XP12_PID
    Else
      Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_XP11,,Hide,XP11_PID

    Loop 100
    {
      Process, Exist, X-Plane.exe
      If ErrorLevel
        Break
      Else
        Sleep, 1000
    }

    If NOT ErrorLevel
    {
      MsgBox %XPLANE% konnte nicht gestartet werden!
      ExitApp,
    }

    ; _Aircraft_Log( XPLANE " is active")

    ; If Not TEST
    ; {
    ; 	Run, C:\WINDOWS\system32\schtasks.exe /Run /tn SkipUAC_ActiveSkyXP,,,ActiveSkyXP_PID
    ; 	_Aircraft_Log( "ActiveSkyXP is active")
    ; }
  }

  _Aircraft_Log(Aktu_Sim " is active! DONE -> SIM_INIT")
Return

_Make_CMD_File(FileName) {
  Static Start_Else := "Else If (CMD_Text="
  Static Start_Send := "Send"
  Static End_Loop := "Say it again"
  Static Remark := "; "

  Local Zeile := ""
  Local CMD_Str := ""
  Local Z_Nr := 0

  Loop {
    FileReadLine, Zeile, %FileName%, %A_Index% ; definiert im jeweiligen Hauptfile
    If ErrorLevel
      break

    If InStr(Zeile, End_Loop)
      break

    If InStr(Zeile, Start_Else) And Not (InStr(Zeile, Remark) = 1)
    {
      Pos1 := InStr(Zeile, """",,, 1) + 1
      Pos2 := InStr(Zeile, """",,, 2)

      CMD_Str := SubStr(Zeile, Pos1, Pos2 - Pos1)

      SpeechCommands.Insert(CMD_Str) ; Fügt diese Zeile ans Array für die Spracherkennung an

      ; FileAppend , %CMD_File% / %A_Index% / %CMD%`n, %CMD_List%
      Z_Nr := Format("{1:4}", A_Index)

      FileAppend, %Z_Nr%`t/%FileName%`t`t%CMD_Str%`n, %CMD_List_Path%%CMD_List%
    }

    ; IfInString, Zeile , %Start_Send% ; Send erkennen und auch ins CMD File einfügen
    ; FileAppend , %Zeile%`n, %CMD_List%
  }

  Return 0
}

SPEECH_INIT:

  ; Text to Speech Object erstellen
  Global cSpeaker := ComObjCreate("SAPI.SpVoice")
  Global cAudioOutputs := cSpeaker.GetAudioOutputs() ; obtain list of audio Output (ISpeechObjectTokens object)

  cSpeaker.AudioOutput := cAudioOutputs.Item(Boxen_OutputDevice) ; wird in "text to speech" überschriene

  ; Speech to Text Object erstellen
  Global s := New SpeechRecognizer
  ; Global v := New CustomSpeech ; create the custom speech recognizer

  ; Array für Speech to Text erstellen
  Global SpeechCommands := Object()

  FileDelete, %CMD_List_Path%%CMD_List% ; Alte Kommando Liste löschen ( z.B. "P_Boing737_CMD.csv")

  ; Neue SpeechCommands Array und ...CMD.csv erstellen
  Err := _Make_CMD_File(CMD_File_Path CMD_File) ; Kommandos aus Aircraft File (z.B. "P_Boing737.ahk") holen.

  If (Aktu_Sim = MSFS)
    Err := _Make_CMD_File(CMD_File_Path Common_CMD_MS_File) ; Sim spezifische Kommandos an Liste anhängen

  If (Aktu_Sim = XPLANE)
    Err := _Make_CMD_File(CMD_File_Path Common_CMD_XP_File) ; Sim spezifische Kommandos an Liste anhängen

  If (Aktu_Sim = P3DV4)
    Err := _Make_CMD_File(CMD_File_Path Common_CMD_P3D_File) ; Sim spezifische Kommandos an Liste anhängen

  Err := _Make_CMD_File(CMD_File_Path Common_CMD_File) ; allgemeine Kommandos an Liste anhängen

  ; irgend wann mal...TODO:
  ; Err := _Write_Aircraft_Info(CMD_List_Path CMD_List)

  ; s.Recognize(True)
  s.Recognize(SpeechCommands) ; Alle zu erkennenden Kommandos initialisieren
  s.Listen(False)

Return

_Is_any_Sim_active() {
  Process, Exist, FlightSimulator.exe
  If ErrorLevel
  {
    Running_Sim := MSFS
    Return True
  }

  Process, Exist, X-Plane.exe
  If ErrorLevel
  {
    Running_Sim := XPLANE
    Return True
  }

  Process, Exist, Prepar3D.exe
  If ErrorLevel
  {
    Running_Sim := P3DV4
    Return True
  }

  Return False
}

Is_aktu_Sim_closed:

  If (Aktu_Sim = MSFS)
  {
    Process, Exist, FlightSimulator.exe
    If Not ErrorLevel
    {
      ; SetTimer, Is_aktu_Sim_closed, Off
      Gosub Stop_Aircraft_Scenario
      TrayTip, %Aktu_Sim%, is closed.`n%Aktu_Scenario% file will also be closed!, 3,2
      Sleep, 3000
      Goto H_EndApp_KillAll
    }
  }

  If (Aktu_Sim = XPLANE)
  {
    Process, Exist, X-Plane.exe
    If Not ErrorLevel
    {
      ; SetTimer, Is_aktu_Sim_closed, Off
      Gosub Stop_Aircraft_Scenario
      TrayTip, %Aktu_Sim%, is closed.`n%Aktu_Scenario% file will also be closed!, 3,2
      Sleep, 3000
      Goto H_EndApp_KillAll
    }
  }

  If (Aktu_Sim = P3DV4)
  {
    Process, Exist, Prepar3D.exe
    If Not ErrorLevel
    {
      ; SetTimer, Is_aktu_Sim_closed, Off
      Gosub Stop_Aircraft_Scenario
      TrayTip, %Aktu_Sim%, is closed.`n%Aktu_Scenario% file will also be closed!, 3,2
      Sleep, 3000
      Goto H_EndApp_KillAll
    }
  }

Return

Start_Aircraft_Scenario:

  Err := VarSetCapacity(dwResult, 4) ; 4
  dwResult := 0

  Err := VarSetCapacity(SIM_ANY, 4) ; 4
  SIM_ANY := 0

  ; Verhindert, dass DllCall() die Library in der Schleife laden muss.
  hModule := DllCall("LoadLibrary", "Str", FSUIPC_LibPfad, "Ptr")

  While (Not FSUIPC_Ok)
  {
    Gosub Is_aktu_Sim_closed

    x := x + 1

    _Message("Waiting for FSUIPC connect... ",2)

    FSUIPC_Ok := DllCall(FSUIPC_LibPfad . "\FSUIPC_Open", uint, SIM_ANY, uint, &dwResult)
    Sleep, 1000
  }

  SetTimer, Is_aktu_Sim_closed, %Is_SIM_active_Delay%

  SetTimer, Aircraft_Scenario, %AircraftScenario_Delay%
Return

Stop_Aircraft_Scenario:

  SetTimer, Is_aktu_Sim_closed, Off
  SetTimer, Aircraft_Scenario, Off

  FSUIPC_Ok := DllCall(FSUIPC_LibPfad . "\FSUIPC_Close", uint, &dwResult)

  ; Zum Freigeben des Speichers kann die DLL nach ihrer Verwendung entladen werden.
  FSUIPC_Ok := DllCall("FreeLibrary", "Ptr", hModule)

  FSUIPC_Ok := False

Return

Auto_Checklists:
  Auto_Baro := True

  PreflightProc_Ok := False
  PreflightCheck_Ok := False
  BeforeTaxi_Ok := False
  BeforeTakeOff_Ok := False
  AfterTakeOff_Ok := False
  BeforeApproach_Ok := False
  BeforeLanding_Ok := False
  AfterLanding_Ok := False
  Parking_Ok := False

Return

_Is_CheckItem(CheckItem) {
  DEBUG_Is_CheckItem++

  CheckItem_Active := True
  CheckItem_Break := False
  CheckItem_Ok := False

  Err := ToolTipEx("?> " CheckItem " ", x_Tooltip3, y_Tooltip3, 3, HFONT, "Lime", "Black", "", "S")

  Err := _Text_to_Speech(CheckItem)

  ; SoundBeep, 200, 30

  If InStr(CheckItem, "complete")
  {
    Sleep 3000 ; Checklistenende 3 Sekunden anzeigen
  }
  Else
  {
    While (Not(CheckItem_Ok Or CheckList_Break)) ; Wird im CMD _Process entsprechend gesetzt
      Sleep, 500
  }

  Err := ToolTipEx(,,, 3)

  DEBUG_Is_CheckItem += 1000

  If (CheckList_Break)
  {
    _Text_to_Speech("checklist break!")
    CheckList_Break := False
    CheckItem_Active := False
    Return 0
  }
  Else
  {
    CheckItem_Ok := False
    CheckItem_Active := False
    Return 1
  }

  Return 0
}

_CMD(What) {
  Local t

  DEBUG_CMD++

  ; _Message("Start _CMD",0)

  t := 0
  While (CMD_Text <> "")
  {
    If t = 100 ; 500
    {
      _Message("_CMD(What): Wait for more than 2 Sec. RETURN!!", 10)
      Return
    }
    t = t + 1
    Sleep, 20
  }
  ; _Message("After While _CMD",0)
  Old_CMD_Text := What
  CMD_Text := What

  SetTimer, CMD_Process, %CMDProcess_Delay%

  DEBUG_CMD += 1000

  ; _Message("End _CMD",0)
  Return 0
}

_Text_to_Speech(Text) {
  ; sleep, 200 ; Delta für folgende ToolTips

  If Speech_On
  {
    ; x := 0
    ; while x<5
    ; {
    cSpeaker.AudioOutput := cAudioOutputs.Item(Headset_OutputDevice)
    ; 	cSpeaker.AudioOutput := cAudioOutputs.Item(x)
    cSpeaker.Speak(Text)
    ; 	MsgBox, Device %x%
    ; 	x := x+1
    ; }
    ; _Message("Speaker set to Headset!",0)
  }
  Else
  {
    cSpeaker.AudioOutput := cAudioOutputs.Item(Monitor_OutputDevice)
    ; _Message("Speaker set to Monitor!",0)

    If Not (Speech_Mute Or Listen_On) ; Or Speech_On) dann über Kopfhörer
      cSpeaker.Speak(Text)
    Else
      SoundBeep, 400, 30
  }

  Return 0
}

_Aircraft_Log(text) {
  FileAppend, %Text%`n, %Aircraft_LOG_File%
  Return 0
}

_Message(str, delay) {
  Err := ToolTipEx(str, x_Tooltip6, y_Tooltip6, 6, HFONT, "WHITE", "Black", "4", "S")
  Sleep, delay * 1000

  If delay
    Err := ToolTipEx(,,,6)

  Return 0
}

_Error_Message(str, delay) {
  Err := ToolTipEx(str, x_Tooltip9, y_Tooltip9, 9, HFONT, "RED", "Black", "4", "S")
  Sleep, delay * 1000

  If delay
    Err := ToolTipEx(,,,9)
  Return 0
}

class SpeechRecognizer
{
  ; https://msdn.microsoft.com/en-us/library/ee125663(v=vs.85).aspx
  ; class CustomSpeech extends SpeechRecognizer
  ; Text to Speech
  ; {
  ; OnRecognize(Text)
  ; {
  ; static cSpeaker := ComObjCreate("SAPI.SpVoice")
  ; TrayTip, Speech Recognition, You said: %Text%
  ; cSpeaker.Speak("You said: " . Text)
  ; }
  ; }

  static Contexts := {}

  __New()
  {
    ; obtain speech recognizer (ISpeechRecognizer object)
    try
    {
      this.cListener := ComObjCreate("SAPI.SpInprocRecognizer")
      cAudioInputs := this.cListener.GetAudioInputs() ; obtain list of audio inputs (ISpeechObjectTokens object)
      this.cListener.AudioInput := cAudioInputs.Item(Headset_InputDevice) ; set audio device to first input **** by AKI ****
    }

    catch e

      throw Exception("Could Not create recognizer: " . e.Message)

    ; obtain speech Recognition context (ISpeechRecoContext object)
    try this.cContext := this.cListener.CreateRecoContext()
    catch e
      throw Exception("Could Not create Recognition context: " . e.Message)

    try this.cGrammar := this.cContext.CreateGrammar() ; obtain phrase manager (ISpeechRecoGrammar object)
    catch e
      throw Exception("Could Not create Recognition grammar: " . e.Message)

    ; create rule to use when dictation mode is off
    try
    {
      this.cRules := this.cGrammar.Rules() ; obtain list of grammar rules (ISpeechGrammarRules object)
      this.cRule := this.cRules.Add("WordsRule",0x1 | 0x20) ; add a New grammar rule (SRATopLevel | SRADynamic)
    }
    catch e
      throw Exception("Could Not create speech Recognition grammar rules: " . e.Message)

    ; tokenObject := := ComObjCreate("SAPI.SpObjectToken")
    ; tokenObject := cAudioInputs.Item(1)

    ; yy :=	tokenObject.GetDescription
    ; zz :=	this.cListener.GetAudioInputs
    ; MsgBox ,,,%yy% -> %zz%,6

    this.Phrases(["hello", "hi", "greetings", "salutations"])
    this.Dictate(True)

    SpeechRecognizer.Contexts[&this.cContext] := &this ; store a weak reference to the instance so event callbacks can obtain this instance
    this.Prompting := False ; prompting defaults to inactive

    ComObjCOnnect(this.cContext, "SpeechRecognizer_") ; connect the Recognition context events to functions
  }

  Recognize(Values = True)
  {
    If Values ; enable speech Recognition
    {
      this.Listen(True)

      If IsObject(Values) ; list of phrases to use
      {
        this.Phrases(Values)
      }
      Else ; recognize any phrase
      {
        this.Dictate(True)
      }
    }
    Else ; disable speech Recognition
    {
      this.Listen(False)
      Return, this
    }
  }

  Listen(State = True)
  {
    ; MsgBox Listen()
    If (this.cListener.State = State)
      Return

    try
    {
      If State
      {
        this.cListener.State := 1 ; SRSActive
        Listen_On := 1
      }
      Else
      {
        this.cListener.State := 0 ; SRSInactive
        Listen_On := 0
      }
    }
    catch e
      throw Exception("Could Not set listener state: " . e.Message)

    Return, this
  }

  Prompt(Timeout = -1)
  {
    ; MsgBox Promt()

    this.Prompting := True
    this.SpokenText := ""

    If Timeout < 0 ; no timeout
    {
      While, (this.Prompting) ; by AKI
      {
        Sleep, Prompt_Delay
      }
    }
    Else
    {
      EndTime := A_TickCount + Timeout

      While, (this.Prompting And (EndTime > A_TickCount))
      {
        Sleep, Prompt_Delay
      }
    }

    RecText := this.SpokenText
    Return, this.SpokenText
  }

  Phrases(PhraseList)
  {
    ; MsgBox Phrases()
    try this.cRule.Clear() ; reset rule to initial state
    catch e
      throw Exception("Could Not reset rule: " . e.Message)
    try cState := this.cRule.InitialState() ; obtain rule initial state (ISpeechGrammarRuleState object)
    catch e
      throw Exception("Could Not obtain rule initial state: " . e.Message)

    ; add rules to recognize
    cNull := ComObjParameter(13,0) ; null IUnknown pointer

    For Index, Phrase In PhraseList
    {
      try cState.AddWordTransition(cNull, Phrase) ; add a no-op rule state Transition triggered by a phrase
      catch e
        throw Exception("Could Not add rule """ . Phrase . """: " . e.Message)
    }

    try this.cRules.Commit() ; compile all rules in the rule collection
    catch e
      throw Exception("Could Not update rule: " . e.Message)

    ; this.Dictate(False) ; disable dictation mode
    this.Dictate(false) ; disable dictation mode
    Return, this
  }

  Dictate(Enable = True)
  {
    ; MsgBox Dictate()
    try
    {
      If Enable ; enable dictation mode
      {
        this.cGrammar.DictationSetState(1) ; enable dictation mode (SGDSActive)
        this.cGrammar.CmdSetRuleState("WordsRule", 0) ; disable the rule (SGDSInactive)
        ; this.cGrammar.CmdSetRuleState("WordsRule", 0) ; disable the rule (SGDSInactive)				;
      }
      Else ; disable dictation mode
      {
        this.cGrammar.DictationSetState(0) ; disable dictation mode (SGDSInactive)
        this.cGrammar.CmdSetRuleState("WordsRule", 1) ; enable the rule (SGDSActive)
        ; this.cGrammar.CmdSetRuleState("WordsRule", 1) ; enable the rule (SGDSActive)
      }
    }

    catch e
      throw Exception("Could Not set grammar dictation state: " . e.Message)
    Return, this
  }

  OnRecognize(RecText)
  {
    ; placeholder function meant to be overridden in subclasses
  }

  __Delete()
  {
    ; remove weak reference to the instance
    this.base.Contexts.Remove(&this.cContext, "")
  }

}

; Wird aufgerufen wenn Sprache erkannt wird!
SpeechRecognizer_Recognition(StreamNumber, StreamPosition, RecognitionType, cResult, cContext)
{
  try
  {
    pPhrase := cResult.PhraseInfo() ; obtain detailed information about recognized phrase (ISpeechPhraseInfo object from ISpeechRecoResult object)
    MyText := pPhrase.GetText() ; obtain the spoken text
  }
  catch e
    throw Exception("Could Not obtain Recognition result text: " . e.Message)

  If Listen_On ; ansonsten BullShit
  {

    Speech_Found := True
    SoundBeep, 250, 80
    Err := _CMD(MyText)
    gosub Close_SpeechRec

  }

  ; Instance := Object(SpeechRecognizer.Contexts[&cContext]) ; obtain reference to the recognizer

  ; ; handle prompting mode
  ; If Instance.Prompting
  ; {
  ; Instance.SpokenText := RecText
  ; Instance.Prompting := False
  ; }
  ; Instance.OnRecognize(RecText) ; invoke callback in recognizer
}

_GetHFONT(Options := "", Name := "") {
  Gui, New
  Gui, Font, % Options, % Name
  Gui, Add, Text, +hwndHTX, Dummy
  HFONT := DllCall("User32.dll\SendMessage", "Ptr", HTX, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "UPtr") ; WM_GETFONT
  Gui, Destroy
  Return HFONT
}

IL_EX_GetHICON(ILID, Index, Styles := 0x20){
  ; http://ahkscript.org/boards/viewtopic.php?f=6&t=1273
  Return DllCall("ComCtl32.dll\ImageList_GetIcon", "Ptr", ILID, "Int", Index - 1, "UInt", Styles, "UPtr")
}

ToolTipEx(Text:="", X:="", Y:="", WhichToolTip:=1, HFONT:="", BgColor:="", TxColor:="", HICON:="", CoordMode:="W") {
  ; ToolTipEx() Display ToolTips with custom fonts and colors.
  ;
  ; Parameters:
  ; Text 			    - the text to display in the ToolTip.If omitted or empty, the ToolTip will be destroyed.
  ; X 			      - the X position of the ToolTip. Default: "" (mouse cursor)
  ; Y 			      - the Y position of the ToolTip. Default: "" (mouse cursor)
  ; WhichToolTip	- the number of the ToolTip. Values: MAX_TOOLTIPS Default: 1 to 30
  ; HFONT 		    - a HFONT handle of the font to be used. Default: 0 (default font)
  ; BgColor 		  - background color of the ToolTip. Values: RGB integer value or HTML color name. Default: "" (default color)
  ; TxColor 	  	- the text color of the ToolTip. Values: RGB integer value or HTML color name. Default: "" (default color)
  ; HICON 		    - the icon to display in the upper-left corner of the TooöTip. This can be the number of a predefined icon
  ; 				        (1 = info, 2 = warning, 3 = error >>> add 3 <<< to display large icons on Vista+) or a HICON handle.
  ; 				        Specify 0 to remove an icon from the ToolTip. Default: "" (no icon)
  ; CoordMode 	  - the coordinate mode for the X and Y parameters, if specified. Values: "C" (Client), "S" (Screen),
  ;                 "W" (Window) Default: "W" (CoordMode, ToolTip, Window)
  ; Return values:- On success: The HWND of the ToolTip window. On failure: False (ErrorLevel contains
  ;                 additional informations)

  ; ToolTip messages
  Static ADDTOOL := A_IsUnicode ? 0x0432 : 0x0404 ; TTM_ADDTOOLW : TTM_ADDTOOLA
  Static BKGCOLOR := 0x0413 ; TTM_SETTIPBKCOLOR
  Static MAXTIPW := 0x0418 ; TTM_SETMAXTIPWIDTH
  Static SETMARGN := 0x041A ; TTM_SETMARGIN
  Static SETTHEME := 0x200B ; TTM_SETWINDOWTHEME
  Static SETTITLE := A_IsUnicode ? 0x0421 : 0x0420 ; TTM_SETTITLEW : TTM_SETTITLEA
  Static TRACKACT := 0x0411 ; TTM_TRACKACTIVATE
  Static TRACKPOS := 0x0412 ; TTM_TRACKPOSITION
  Static TXTCOLOR := 0x0414 ; TTM_SETTIPTEXTCOLOR
  Static UPDTIPTX := A_IsUnicode ? 0x0439 : 0x040C ; TTM_UPDATETIPTEXTW : TTM_UPDATETIPTEXTA

  ; Other constants
  Static SizeTI := (4 * 6) + (A_PtrSize * 6) ; size of the TOOLINFO structure
  Static OffTxt := (4 * 6) + (A_PtrSize * 3) ; offset of the lpszText field

  ; Global MAX_TOOLTIPS := 30 ; maximum number of ToolTips to appear simultaneously
  ; Global TT := Object() ; [] ; ToolTip array

  ; HTML Colors (BGR)
  Static HTML := {AQUA: 0xFFFF00, BLACK: 0x000000, BLUE: 0xFF0000, FUCHSIA: 0xFF00FF, GRAY: 0x808080, GREEN: 0x008000
    , LIME: 0x00FF00, MAROON: 0x000080, NAVY: 0x800000, OLIVE: 0x008080, PURPLE: 0x800080, RED: 0x0000FF
    , SILVER: 0xC0C0C0, TEAL: 0x808000, WHITE: 0xFFFFFF, YELLOW: 0x00FFFF}

  ; -------------------------------------------------------------------------------------------------------------------
  ; Init TT on first call
  ; If (TT.MaxIndex() = "")
  ; -------------------------------------------------------------------------------------------------------------------

  ; Check params
  TTTX := Text
  TTXP := X
  TTYP := Y

  ; MsgBox x = %ttxp% y = %ttyp%
  TTIX := WhichToolTip = "" ? 1 : WhichToolTip
  TTHF := HFONT = "" ? 0 : HFONT
  TTBC := BgColor
  TTTC := TxColor
  TTIC := HICON
  TTCM := CoordMode = "" ? "W" : SubStr(CoordMode, 1, 1)

  ; If TTXP Is Not Digit
  ; Return False, ErrorLevel := "Invalid parameter X-position!", False
  ; If TTYP Is Not Digit
  ; Return False, ErrorLevel := "Invalid parameter Y-Position!", False

  If (TTIX < 1) || (TTIX > MAX_TOOLTIPS)
    Return False, ErrorLevel := "Max ToolTip number is " . MAX_TOOLTIPS . ".", False

  If (TTHF) && !(DllCall("Gdi32.dll\GetObjectType", "Ptr", TTHF, "UInt") = 6)
    Return False, ErrorLevel := "Invalid font handle!", False

  If TTBC Is Integer
    TTBC := ((TTBC >> 16) & 0xFF) | (TTBC & 0x00FF00) | ((TTBC & 0xFF) << 16)
  Else
    TTBC := (HTML.HasKey(TTBC) ? HTML[TTBC] : "")

  If TTTC Is Integer
    TTTC := ((TTTC >> 16) & 0xFF) | (TTTC & 0x00FF00) | ((TTTC & 0xFF) << 16)
  Else
    TTTC := (HTML.HasKey(TTTC) ? HTML[TTTC] : "")

  If !InStr("CSW", TTCM)
    Return False, ErrorLevel := "Invalid parameter CoordMode!", False

  ; -------------------------------------------------------------------------------------------------------------------
  ; Destroy the ToolTip window, if Text is empty
  TTHW := TT[TTIX].HW

  If (TTTX = "") && (TTHW) {
    If DllCall("User32.dll\IsWindow", "Ptr", TTHW, "UInt")
      DllCall("User32.dll\DestroyWindow", "Ptr", TTHW)

    TT[TTIX] := {HW: 0, TX: ""}
    Return True
  }
  ; -------------------------------------------------------------------------------------------------------------------
  ; Get the virtual desktop rectangle
  SysGet, X, 76
  SysGet, Y, 77
  SysGet, W, 78
  SysGet, H, 79
  DTW := {L: X, T: Y, R: X + W, B: Y + H}

  ; -------------------------------------------------------------------------------------------------------------------
  ; Initialise the ToolTip coordinates. If either X or Y is empty, use the cursor position for the present.
  PT := {X: 0, Y: 0}
  If (TTXP = "") || (TTYP = "") {
    Err := VarSetCapacity(Cursor, 8, 0)
    DllCall("User32.dll\GetCursorPos", "Ptr", &Cursor)
    Cursor := {X: NumGet(Cursor, 0, "Int"), Y: NumGet(Cursor, 4, "Int")}
    PT := {X: Cursor.X + 16, Y: Cursor.Y + 16}
  }

  ; -------------------------------------------------------------------------------------------------------------------
  ; If either X or Y is specified, get the position of the active window considering CoordMode.
  Origin := {X: 0, Y: 0}
  If ((TTXP <> "") || (TTYP <> "")) && ((TTCM = "W") || (TTCM = "C")) {
    ; if (*aX || *aY) // Need the offsets.
    HWND := DllCall("User32.dll\GetForegroundWindow", "UPtr")
    If (TTCM = "W") {
      WinGetPos, X, Y, , , ahk_id %HWND%
      Origin := {X: X, Y: Y}
    }
    Else {
      Err := VarSetCapacity(OriginPT, 8, 0)
      DllCall("User32.dll\ClientToScreen", "Ptr", HWND, "Ptr", &OriginPT)
      Origin := {X: NumGet(OriginPT, 0, "Int"), Y: NumGet(OriginPT, 0, "Int")}
    }
  }

  ; -------------------------------------------------------------------------------------------------------------------
  ; If either X or Y is specified, use the window related position for this parameter.
  If (TTXP <> "")
    PT.X := TTXP + Origin.X
  If (TTYP <> "")
    PT.Y := TTYP + Origin.Y

  ; -------------------------------------------------------------------------------------------------------------------
  ; Create and fill a TOOLINFO structure.
  TT[TTIX].TX := "T" . TTTX ; prefix with T to ensure it will be stored as a string in either case

  Err := VarSetCapacity(TI, SizeTI, 0) ; TOOLINFO structure
  Err := NumPut(SizeTI, TI, 0, "UInt")
  Err := NumPut(0x0020, TI, 4, "UInt") ; TTF_TRACK
  Err := NumPut(TT[TTIX].GetAddress("TX") + (1 << !!A_IsUnicode), TI, OffTxt, "Ptr")

  ; -------------------------------------------------------------------------------------------------------------------
  ; If the ToolTip window doesn't exist, create it.
  If !(TTHW) || !DllCall("User32.dll\IsWindow", "Ptr", TTHW, "UInt") {
    ; ExStyle = WS_TOPMOST, Style = TTS_NOPREFIX | TTS_ALWAYSTIP
    TTHW := DllCall("User32.dll\CreateWindowEx", "UInt", 8, "Str", "tooltips_class32", "Ptr", 0, "UInt", 3
      , "Int", 0, "Int", 0, "Int", 0, "Int", 0, "Ptr", A_ScriptHwnd, "Ptr", 0, "Ptr", 0, "Ptr", 0)
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", ADDTOOL, "Ptr", 0, "Ptr", &TI)
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", MAXTIPW, "Ptr", 0, "Ptr", A_ScreenWidth)
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", TRACKPOS, "Ptr", 0, "Ptr", PT.X + (PT.Y << 16))
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", TRACKACT, "Ptr", 1, "Ptr", &TI)
  }

  ; -------------------------------------------------------------------------------------------------------------------
  ; Update the text and the font and colors, if specified.
  If (TTBC <> "") || (TTTC <> "") {
    ; colors
    DllCall("UxTheme.dll\SetWindowTheme", "Ptr", TTHW, "Ptr", 0, "Str", "")
    Err := VarSetCapacity(RC, 16, 0)
    Err := NumPut(4, RC, 0, "Int"), NumPut(4, RC, 4, "Int"), NumPut(4, RC, 8, "Int"), NumPut(1, RC, 12, "Int")
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", SETMARGN, "Ptr", 0, "Ptr", &RC)
    If (TTBC <> "")
      DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", BKGCOLOR, "Ptr", TTBC, "Ptr", 0)
    If (TTTC <> "")
      DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", TXTCOLOR, "Ptr", TTTC, "Ptr", 0)
  }

  If (TTIC <> "")
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", SETTITLE, "Ptr", TTIC, "Str", " ")
  If (TTHF) ; font
    DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", 0x0030, "Ptr", TTHF, "Ptr", 1) ; WM_SETFONT
  DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", UPDTIPTX, "Ptr", 0, "Ptr", &TI)

  ; -------------------------------------------------------------------------------------------------------------------
  ; Get the ToolTip window dimensions.
  Err := VarSetCapacity(RC, 16, 0)
  DllCall("User32.dll\GetWindowRect", "Ptr", TTHW, "Ptr", &RC)
  TTRC := {L: NumGet(RC, 0, "Int"), T: NumGet(RC, 4, "Int"), R: NumGet(RC, 8, "Int"), B: NumGet(RC, 12, "Int")}
  TTW := TTRC.R - TTRC.L
  TTH := TTRC.B - TTRC.T

  ; -------------------------------------------------------------------------------------------------------------------
  ; Check if the Tooltip will be partially outside the virtual desktop and adjust the position, if necessary.
  If (PT.X + TTW >= DTW.R)
    PT.X := DTW.R - TTW - 1
  If (PT.Y + TTH >= DTW.B)
    PT.Y := DTW.B - TTH - 1

  ; -------------------------------------------------------------------------------------------------------------------
  ; Check if the cursor is inside the ToolTip window and adjust the position, if necessary.
  If (TTXP = "") || (TTYP = "") {
    TTRC.L := PT.X, TTRC.T := PT.Y, TTRC.R := TTRC.L + TTW, TTRC.B := TTRC.T + TTH
    If (Cursor.X >= TTRC.L) && (Cursor.X <= TTRC.R) && (Cursor.Y >= TTRC.T) && (Cursor.Y <= TTRC.B)
      PT.X := Cursor.X - TTW - 3, PT.Y := Cursor.Y - TTH - 3
  }

  ; -------------------------------------------------------------------------------------------------------------------
  ; Show the Tooltip using the final coordinates.
  DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", TRACKPOS, "Ptr", 0, "Ptr", PT.X + (PT.Y << 16))
  DllCall("User32.dll\SendMessage", "Ptr", TTHW, "UInt", TRACKACT, "Ptr", 1, "Ptr", &TI)
  TT[TTIX].HW := TTHW

  Return TTHW
}

MACRO_INIT:

  ; Privat

  :R*:aw#::Achim Wolberg
  :R*:str#::Swakopmunder Strasse 17
  :R*:ort#::Duisburg
  :R*:plz#::47249

  :R*:handy#::+49 (1577) 9668730
  :R*:telefon#::+49 (203) 799714
  :R*:gmail#::achim.wolberg@gmail.com

  :R*:vga#::Viele Grüße`rAchim `r
  :R*:vgaw#::Viele Grüße`rAchim Wolberg`r

  ; AHK Befehle

  :R*:Send#::Send {Shift Down}{Ctrl Down}{Alt Down}{xx}{Alt Up}{Shift Up}{Ctrl Up}
  :R*:mb#::MsgBox ,,,?,2
  :R*:mess#::_Message("?", 0)
  :R*:tt#::ToolTipEx("?", x_Tooltip9, y_Tooltip9, 9, HFONT, "WHITE", "Black", "", "S")

  ; Lizenznummern

  ; SimCoder
  :R*:REPcode#::LCSH-89EL-47C7
  ; Toliss
  :R*:TOLcode#::Q6GEA-Q4BVH-7RJDJ-CBLKW-5LRMA-UDVPL
  ; JAR A330
  :R*:JARcode#::L8-ENEVCZ-EF9ZNV-VNC9ZL-P87VTC
  ; Ground Handling
  :R*:GHcode#::JD-GHD-QZF-RDK-S98-YG
  ; XPlane
  :R*:XEcode#::JB6AAUOFMROEFN9GD7ZFDD9Q4TIENQLC

  ; User / Pass

  :R*:IVAOID#::557124
  :R*:IVAOPASS#::4mAaLbb2

  :R*:VATID#::863991
  :R*:VATPASS#::419969

  :R*:AFXID#:: AFX6
  :R*:AFXPASS#::aki12345

  ; AirFox CallSign/ Remark

  :R*:csA#::CS/AirFox
  :R*:csAR#::RMK/CS/AirFox

  ; X-Plane Save File Names

  :R*:CeADu#::CessnaAFL EDDL.sit
  :R*:CeADo#::CessnaAFL EDLW.sit
  :R*:CeALa#::CessnaAFL LAST.sit

  :R*:CeGDu#::CessnaR G1000 EDDL.sit
  :R*:CeGDo#::CessnaR G1000 EDLW.sit
  :R*:CeGLa#::CessnaR G1000 LAST.sit

  :R*:CeDu#::CessnaR EDDL.sit
  :R*:CeDo#::CessnaR EDLW.sit
  :R*:CeLa#::CessnaR LAST.sit

  :R*:CiDu#::Cirrus EDDL.sit
  :R*:CiDo#::Cirrus EDLW.sit
  :R*:CiLa#::Cirrus LAST.sit

  :R*:PiDu#::Piper EDDL.sit
  :R*:PiDo#::Piper EDLW.sit
  :R*:PiLa#::Piper LAST.sit

  :R*:RoDu#::Robin EDDL.sit
  :R*:RoDo#::Robin EDLW.sit .sit
  :R*:RoLa#::Robin LAST.sit

  :R*:EcDu#::Eclipse EDDL.sit
  :R*:EcLa#::Eclipse LAST.sit
  :R*:EcPBN#::PBN/A1B1C1D1L1O1S2 DAT/V CS/AIRFOX

  :R*:A319Du#::A319 EDDL.sit
  :R*:A319La#::A319 LAST.sit
  :R*:A319PBN#::PBN/A1B1C1D1L1O1S2 DAT/V CS/AIRFOX

  :R*:A330Du#::A330 EDDL.sit
  :R*:A330La#::A330 LAST.sit
  :R*:A330PBN#::PBN/A1B1C1D1L1O1S2 DAT/V CS/AIRFOX

  :R*:B738Du#::B738 EDDL.sit
  :R*:B738La#::B738 LAST.sit
  :R*:B738PBN#::PBN/A1B1C1D1L1O1S2 DAT/V CS/AIRFOX

  ; Info-Texte Online Netz

  :R*:tr#::tfc, taxi to RW
  :R*:lu#::tfc, line up for t/o RW
  :R*:cl#::climb FL
  :R*:de#::descend FL
  :R*:ci#::tfc, cleared ILS
  :R*:of#::tfc, on final RW
  :R*:rv#::tfc, runway vacated RW
  :R*:tg#::tfc, taxi to gate
  :R*:da#::.r Danke!

; Flightplan Airfox

:R*:fpA#::
  {
    SendInput %FP_Departure%
    SendInput {Tab 1}
    SendInput %FP_Destination%
    SendInput {Tab 1}
    SendInput %FP_Airline%%FP_FlightNumber%
    SendInput {Tab 1}
    SendInput %FP_Paxe%
    SendInput {Tab 1}
    SendInput %FP_FlightLevel%
    SendInput {Tab 1}
    SendInput {End}{Shift down}{Home}{Del}{Shift up}
    SendInput %FP_Cargo%
    SendInput {Tab 1}
    SendInput %FP_Route%
    SendInput {Tab}
    Return
  }

; Flightplan VATSIM

:R*:fpV#::
  {
    Gosub, LoadVatsimFlightPlan
    if (FlightType = "") {
      _Error_Message("No LNM-Flightplan exportet!", 2)
    }
    Else {
      SendInput %FP_CallSign%
      SendInput {Tab 1}
      SendInput %FlightType%
      SendInput {Tab 1}
      SendInput C172
      SendInput {Tab 1}
      ; SendInput %IsHeavy%
      ; SendInput {Tab 1}
      SendInput L	; wake Category
      SendInput {Tab 1}
      SendInput %Equipment%
      SendInput {Tab 1}
      ; SendInput %EquipmentPrefix%
      ; SendInput {Tab 1}
      ; SendInput %EquipmentSuffix%
      ; SendInput {Tab 1}
      SendInput C	; Transponder
      SendInput {Tab 1}
      SendInput %DepartureAirport%
      SendInput {Tab 1}
      SendInput %DepartureTime%
      SendInput {Tab 1}
      SendInput %CruiseAltitude%
      SendInput {Tab 1}
      SendInput %CruiseSpeed%
      SendInput {Tab 1}
      SendInput %DestinationAirport%
      SendInput {Tab 1}
      SendInput %AlternateAirport%
      SendInput {Tab 1}
      SendInput %EnrouteHours%%EnrouteMinutes%
      SendInput {Tab 1}
      SendInput %FuelHours%%FuelMinutes%
      SendInput {Tab 1}
      SendInput %Route%
      SendInput {Tab 19}
      SendInput %Remarks%
      SendInput {PgUp}

      ; SendInput {Tab 1}
      ; SendInput %VoiceType%
    }
    Return
  }

; Datumsformate

:R*:d-#::
  {
    FormatTime, Datum,,yyyy-MM-dd
    Send %Datum%
    Return
  }

:R*:d_#::
  {
    FormatTime, Datum,,yyyy_MM_dd
    Send %Datum%
    Return
  }

:R*:d.#::
  {
    FormatTime, Datum,, dd.MM.yyyy
    Send %Datum%`r
    Return
  }

; RETURN ; nicht erlaubt, sonst wird gemeckert (WARN)
