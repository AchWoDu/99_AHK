P_Boeing737_2022_09_08: ; -> PMDG B737-800/-900

DEV_VARS:
  Global TEST := False ;Or True ; Keine Programme starten
  Global DEBUG := False ;Or True ; Debug anzeigen

  Global Aktu_Sim := "Lockheed Martin® Prepar3D® v4"
  Global Aktu_Scenario := "Boeing737" ; zum suchen in Load Scenario
  Global CMD_File := "P_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "P_" Aktu_Scenario "_CMD.txt"
  ; Global SkipUAC := "SkipUAC_M_" Aktu_Scenario ; wird nicht mehr benötigt da SkipUAC := "SkipUAC_StartAircraft"

  ; Sprachbefehl Anzeigen
  Global x_Versatz := 0 ; -1920 <-  0  -> +1920
  Global y_Versatz := 0

  ; Status-Bar und Checklist_ITEM (ToolTip 11..n und 3)
  Global TTex_xVersatz := 500 ; -1920 <-  0  -> +1920
  Global TTex_yVersatz := 0

  Global CheckOk_Break := True ; Wenn Checklisten auch bei Unterbrechung Ok sind
  Global STD_On := False ; Wenn Baro STD gesetzt

  Global ANZ_Flaps := 8 ; 1; 2; 5; 15; 20; 25; 30; 40
  Global STR_Flaps := ["FUP","F01","F02","F05","F15","F20","F25","F30","F40"]

  #Include %A_ScriptDir%\Common.ahk
Return

CMD_Process:
  DEBUG_CMD_Process++

  Critical ,On

  CP_StartTime := A_TickCount

  SetTimer, CMD_Process, Off

  WinActivate, %Aktu_Sim%
  WinActivate, ahk_class %Aktu_Sim%

  If (CMD_Text="?")
  {
    ; Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Views
  ;
  ; Else If (CMD_Text="night panel")
  ; {
  ; 	Send {Shift Down}w{Shift Up}
  ; 	Send {Alt Down}h{Alt Up}
  ; }

  ; {
  ; Send {F10}{Shift Down}1{Shift Up}
  ; }
  Else If (CMD_Text="lower main panel")
  {
    Send {Shift Down}2{Shift Up}
  }
  Else If (CMD_Text="upper overhead panel")
  {
    Send {Shift Down}7{Shift Up}
  }
  Else If (CMD_Text="lower overhead panel")
  {
    Send {Shift Down}8{Shift Up}
  }
  Else If (CMD_Text="fire panel")
  {
    Send {Shift Down}5{Shift Up}
  }
  Else If (CMD_Text="PFD")
  {
    ; Send {Shift Down}8{Shift Up}
  }
  Else If (CMD_Text="ND")
  {
    ; Send {Shift Down}9{Shift Up}
  }
  Else If (CMD_Text="CDU")
  {
    Send {Shift Down}3{Shift Up}
  }
  Else If (CMD_Text="left CDU")
  {
    Send {Shift Down}3{Shift Up}
  }
  Else If (CMD_Text="right CDU")
  {
    Send {Shift Down}4{Shift Up}
  }
  ;
  ; NUMPAD Views
  ;
  Else If (CMD_Text="top down view") ; 7
  {
    Gosub Screen7
  }
  Else If (CMD_Text="overhead panel") ; 8
  {
    Gosub Screen8
  }
  Else If (CMD_Text="outside view") ; 9
  {
    Gosub Screen9
  }
  Else If (CMD_Text="left window") ; 4
  {
    Gosub Screen4
  }
  Else If (CMD_Text="main panel") ; 5
  {
    Gosub Screen5
  }
  Else If (CMD_Text="left panel") ; 5
  {
    Gosub Screen5
  }
  Else If (CMD_Text="right window") ; 6
  {
    Gosub Screen6
  }
  Else If (CMD_Text="thrust lever") ; 1
  {
    Gosub Screen1
  }
  Else If (CMD_Text="radio panel") ; 2
  {
    Gosub Screen2
  }
  Else If (CMD_Text="head up guidance") ; 3
  {
    Send 3
    Send {Ctrl Down}{Alt Down}h{Alt Up}{Ctrl Up}
    Aktu_Screen := 3
  }
  Else If (CMD_Text="great panel") ; 0 ;
  {
    Gosub Screen0
  }
  Else If (CMD_Text="no panel") ; Del
  {
    ; Gosub ScreenDel
  }
  ;
  ; Autopilot
  ;
  Else If (CMD_Text="flight director on")
  {
    If Not FD
      Send {Ctrl Down}f{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="flight director off")
  {
    If FD
      Send {Ctrl Down}f{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autothrust on")
  {
    If Not AT
      Send {Shift Down}r{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autothrust off")
  {
    If AT
      Send {Shift Down}r{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autopilot on")
  {
    If Not AP
      Send {Shift Down}{Ctrl Down}{Alt Down}z{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autopilot off")
  {
    If AP
      Send {Shift Down}{Ctrl Down}{Alt Down}z{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold V NAV")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}v{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold L NAV")
  {
    Send {Ctrl Down}n{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold navigation") ; VNAV & LNAV
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}v{Shift Up}{Ctrl Up}{Alt Up}
    Send {Ctrl Down}n{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold heading")
  {
    Send {Ctrl Down}h{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold altitude")
  {
    Send {Ctrl Down}z{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold approach")
  {
    Send {Ctrl Down}a{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Controls
  ;
  Else If (CMD_Text="flaps 5")
  {
    Send {F5}{F7}{F7}{F7}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="reverse thrust")
  {
    Send {F1}{F2}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi thrust")
  {
    Send {F1}{F3}{F3}{F3}{F3}{F3}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="take off thrust")
  {
    Send {Shift Down}{Ctrl Down}g{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autobrake on")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}{PGUP 5}{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autobrake off")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}{PGDN 5}{PGUP 1}{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autobrake RTO")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}{PGDN 5}{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="armed spoilers")
  {
    Send {Shift Down}{#}{Shift Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="disarmed spoilers")
  {
    Send {Shift Down}{#}{Shift Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="spoilers on")
  {
    Send {Ctrl Down}{#}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="spoilers off")
  {
    Send {#}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="go around")
  {
    Send {Shift Down}{Ctrl Down}g{Alt Up}{Shift Up}{Ctrl Up}
    If GEAR
      Send g
    Send {F5}{F7}{F7}{F7}{F7} ; Flaps 15
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="warnings off") ; LUA Function
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}w{Alt Up}{Shift Up}{Ctrl Up} ; All Warnings off
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="switch radio") ; FSUIPC Funktion
  {
    ; FSUIPC KEY DEFINITION (Com Stby Radio Swap )
    Send {Shift Down}{Ctrl Down}{Alt Down}r{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="visual approach")
  {
    If AP
      Send {Shift Down}{Ctrl Down}{Alt Down}z{Alt Up}{Shift Up}{Ctrl Up}
    If AT
      Send {Shift Down}r{Alt Up}{Shift Up}{Ctrl Up}

    Send {Shift Down}{Ctrl Down}{Alt Down}w{Alt Up}{Shift Up}{Ctrl Up} ; All Warnings off
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Lights
  ;
  Else If (CMD_Text="beacon lights on") ; LUA Function
  {

    Send {Shift Down}{Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="beacon lights off") ; LUA Function
  {
    Send {Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi lights on") ; LUA Function
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi lights off") ; LUA Function
  {
    Send {Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe lights on") ; LUA Function
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe lights off") ; LUA Function
  {
    Send {Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="landing lights on") ; LUA Function
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="landing lights off") ; LUA Function
  {
    Send {Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe and landing lights on") ; LUA Function
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up}
    Send {Shift Down}{Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe and landing lights off") ; LUA Function
  {
    Send {Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up} ; B737 Strobe -> off
    Send {Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Others
  ;
  Else If (CMD_Text="run timer")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="stop timer")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="baro standard")
  {
    Auto_Baro := True

    if Not STD_On
      Send {Ctrl Down}{Alt Down}q{Alt Up}{Ctrl Up}

    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="baro QNH")
  {
    Auto_Baro := False

    if Std_ON
      Send {Ctrl Down}{Alt Down}q{Alt Up}{Ctrl Up}	

    Send b

    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="reload lua")
  {
    Send {Ctrl Down}{Shift Down}6{Shift Up}{Ctrl Up}	
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  #Include %A_ScriptDir%\Common_CMD_P3D.ahk
  #Include %A_ScriptDir%\Common_CMD.ahk
Return

_Preflight_Procedure() { ; Starts manually
  SetTimer,, Off
  CheckList_Active := True

  Gosub Auto_Checklists

  Err := _Text_to_Speech("Preflight Procedure")

  If _Is_CheckItem("Battery on, guard closed!")
    If _Is_CheckItem("If ground power available, ground power switch on!")
    If _Is_CheckItem("When all flightplans are filed, load cargo and fuel!")
    If _Is_CheckItem("Check ACARS!")
    ; If _Is_CheckItem("Standby power auto, guard closed!")
  ; If _Is_CheckItem("Check bus transfer auto, guard closed!")
  ; If _Is_CheckItem("Left forward fuel pump switches on!")
  ; if _Is_CheckItem("Fire test!")
  ; If _Is_CheckItem("Start APU generator!")
  ; If _Is_CheckItem("Emergency exit light armed, guard closed!")
  ; If _Is_CheckItem("Engine hydraulic pumps in on position, electrical pumps switch off!")
  ; If _Is_CheckItem("Left and right packs in auto position!")
  ; If _Is_CheckItem("APU generator bus switches on!")
  ; If _Is_CheckItem("APU bleed switch on!")
  ; If _Is_CheckItem("IRS mode swiches in navigation position!")
  If _Is_CheckItem("Prepare the CDU!")
    If _Is_CheckItem("Logo and position lights on!")
    If _Is_CheckItem("Smoking sign on and seat belt sign auto!")
    If _Is_CheckItem("Check if yaw dampers on!")
    ; If _Is_CheckItem("Engine hydraulic pumps in on position, electrical pumps switch off!")
  ; If _Is_CheckItem("Left and right packs in auto position!")
  ; If _Is_CheckItem("APU bleed switch on!")
  ; If _Is_CheckItem("IRS mode swiches in navigation position!")

  If _Is_CheckItem("Preflight procedure is complete. Request start up or switch to unicom!")
    PreflightProc_Ok := True

  ; If _Is_CheckItem("Communication And Audio Panel Set?")
  ; If _Is_CheckItem("Configure fuel pumps!")
  ; If _Is_CheckItem("Switch irss to nav mode!")
  ; If _Is_CheckItem("Test voice recorder!")
  ; If _Is_CheckItem("Service interphone switch off!")
  ; If _Is_CheckItem("Flight recorder switch normal!")
  ; If _Is_CheckItem("Engine panel set!")
  ; If _Is_CheckItem("Mach overspeed test!")
  ; If _Is_CheckItem("Stall warning test!")
  ; If _Is_CheckItem("Oxygen test and set!")
  ; If _Is_CheckItem("Set radio tuning panel!")
  ; If _Is_CheckItem("Master lights test and dim switch test!")

  PreflightProc_Ok := PreflightProc_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_Preflight_Checklist() { ; Starts manually

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Preflight Checklist")

  If _Is_CheckItem("Is startup approved?")
    If _Is_CheckItem("Check departure and flightplan route!")
    If _Is_CheckItem("Check the fuel!")
    If _Is_CheckItem("Check transponder and com radio settings!")
    If _Is_CheckItem("Check all AFDS settings and check actual QNH!")
    If _Is_CheckItem("Check the V speeds!")
    If _Is_CheckItem("Check if autobrakes is set to RTO!")
    If _Is_CheckItem("Is the timer reseted!")
    If _Is_CheckItem("Configure fuel pumps!")
    ; If _Is_CheckItem("Start APU generator when APU is off!")
  ; If _Is_CheckItem("Check if ground power switch off!")
  If _Is_CheckItem("Check if window heat on and probe heat off!")
    If _Is_CheckItem("Check if Wing and engine anti ice off!")
    If _Is_CheckItem("Electrical hydraulic pumps swiched on!")
    If _Is_CheckItem("Check if trim air on and Recirc fans auto?")
    If _Is_CheckItem("Set Pack control switches off?")
    If _Is_CheckItem("Check if Isolation valve is open?")
    If _Is_CheckItem("Engine and APU bleed switches on?")
    If _Is_CheckItem("Set cruise and landing altitude?")
    If _Is_CheckItem("Pressurization auto?")
    If _Is_CheckItem("Set parking brake and check thrust lever!")
    If _Is_CheckItem("Check ACARS!")
    If _Is_CheckItem("Check if doors and windows are closed!")
    If _Is_CheckItem("Switch beacon light on!")
    If _Is_CheckItem("Check if jetway and the groundequippment is removed!")

  If _Is_CheckItem("Preflight checklist is complete! Request push back!")
    PreflightCheck_Ok := True

  ; If _Is_CheckItem("Configure fuel pumps!")
  ; If _Is_CheckItem("Ground power switch off!")
  ; ; If _Is_CheckItem("Seat belt signs on?")
  ; If _Is_CheckItem("Window heat on, probe heat off!")
  ; If _Is_CheckItem("Wing anti ice off!")
  ; If _Is_CheckItem("Electrical hydraulic pumps swiched on!")
  ; If _Is_CheckItem("Trim air on?")
  ; If _Is_CheckItem("Recirc fans auto?")
  ; If _Is_CheckItem("Pack control switches off?")
  ; If _Is_CheckItem("Isolation valve open?")
  ; If _Is_CheckItem("Engine and APU bleed switches on?")
  ; If _Is_CheckItem("Set cruise and landing altitude?")
  ; If _Is_CheckItem("Pressurization auto?")
  ; If _Is_CheckItem("Set Rudder Trim to 0?")
  ; If _Is_CheckItem("Is the flightplan filed And Startup Requestet?")
  ; If _Is_CheckItem("Please check the calculated fuel quantity!")
  ; If _Is_CheckItem("Is Trimming set And the Flaps in retracted Position?")
  ; If _Is_CheckItem("Is heading And navigation On runway course?")
  ; If _Is_CheckItem("Is Altimeter adjusted?")
  ; If _Is_CheckItem("Are the EFIS Switches set as needed!")
  ; If _Is_CheckItem("Check Mode Control Panel!")

  PreflightCheck_Ok := PreflightCheck_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeTaxi_Checklist() { ; when parkbrake off

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before taxi checklist")

  If _Is_CheckItem("Set transponder mode charly!")
    If _Is_CheckItem("Start the engines!")
    If _Is_CheckItem("Check if flaps in take off position!")
    If _Is_CheckItem("Trim elevator!")
    If _Is_CheckItem("There after switch engine generators on!")
    If _Is_CheckItem("Switch the APU off!")
    If _Is_CheckItem("Probe heat on!")
    If _Is_CheckItem("Wing and engine anti ice as needed!")
    If _Is_CheckItem("Pack control switches auto!")
    If _Is_CheckItem("APU bleed switch off!")
    ; If _Is_CheckItem("Engine start selectors in continues position!")
  If _Is_CheckItem("Set taxi lights on!")

  If _Is_CheckItem("Before taxi checklist is complete! Request taxi!")
    BeforeTaxi_Ok := True

  BeforeTaxi_Ok := BeforeTaxi_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeTakeOff_Checklist() { ; Starts when the landing lights goes on

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before take off checklist")

  If _Is_CheckItem("Set autothrust on!")
    If _Is_CheckItem("Advise cabin crew!")
    If _Is_CheckItem("Check transponder and run the timer!")

  If _Is_CheckItem("Before take off checklist is complete. Request ready for departure!")
    BeforeTakeOff_Ok := True

  BeforeTakeOff_Ok := BeforeTakeOff_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_AfterTakeOff_Checklist() { ; Starts after flaps full up

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("After take off checklist")

  If _Is_CheckItem("Check if the gear locked and the flaps are up!")
    ; If _Is_CheckItem("Check if the engine start selectors in off position!")
  If _Is_CheckItem("Check if the autobrake is disarmed!")
    If _Is_CheckItem("Check if weather radar on!")

  If _Is_CheckItem("After take off checklist is complete!")
    AfterTakeOff_Ok := True

  AfterTakeOff_Ok := AfterTakeOff_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeApproach_Checklist() { ; Starts after descending 8000 Feets

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before approach checklist")

  If _Is_CheckItem("Check the CDU approach page!")
    If _Is_CheckItem("Check if the landing lights on!")
    If _Is_CheckItem("Check if booth NAVs shows the ILS frequence!")
    If _Is_CheckItem("Check is radar altitude is set!")
    If _Is_CheckItem("Check if the autobrake is set!")

  If _Is_CheckItem("Before approach checklist is complete!")
    BeforeApproach_Ok := True

  BeforeApproach_Ok := BeforeApproach_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeLanding_Checklist() { ; Starts after the Flaps goes in landing config

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before landing checklist")

  If _Is_CheckItem("Check landing speed!")	
    If _Is_CheckItem("Check if the gear down and the spoilers are armed!")
    If _Is_CheckItem("Check if the go around altitude is set!")
    If _Is_CheckItem("Check second autopilot!")

  If _Is_CheckItem("Before landing checklist is complete.")
    BeforeLanding_Ok := True

  BeforeLanding_Ok := BeforeLanding_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_AfterLanding_Checklist() { ; Starts when the Flaps are up

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("After Landing Checklist")

  If _Is_CheckItem("Check lights, flaps and timer!")

  If _Is_CheckItem("After landing checklist is complete. Request taxi to the gate!")
    AfterLanding_Ok := True

  AfterLanding_Ok := AfterLanding_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_Parking_Checklist() { ; Starts when the taxi lights goes off

  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Parking checklist")

  If _Is_CheckItem("Transponder mode standby!")
    If _Is_CheckItem("Activate ground equippment!")
    If _Is_CheckItem("Release parking brake!")
    If _Is_CheckItem("Check if the timer reseted!")
    If _Is_CheckItem("Check if all AFDS in normal settings!")
    If _Is_CheckItem("Check if elevator trim in take off position!")
    If _Is_CheckItem("Check if route page cleared!")
    If _Is_CheckItem("Start the APU or use external power!")
    If _Is_CheckItem("There after switch the engines off!")
    If _Is_CheckItem("Check overhead panel configuration!")
    If _Is_CheckItem("Push the jetway and open the doors!")
    If _Is_CheckItem("Deactivate ACARS!")

  If _Is_CheckItem("Parking checklist is complete!")
    Parking_Ok := True

  Parking_Ok := Parking_Ok Or CheckOK_Break
  CheckList_Active := False

  Gosub Auto_Checklists
Return
}

_Read_FS_VARS() {
  ; DEVs
  DEBUG_Read_FS_VARS++

  ; https://ahkde.github.io/docs/commands/DllCall.htm

  ; Typ	Wertebereich								Länge
  ; byte	-128..127									8 Bit
  ; short	-32768..32767								16 Bit
  ; int	-2147483648..2147483647						32 Bit
  ; (u)Int 											32 Bit
  ; long	-9223372036854775808..9223372036854775807	64 Bit

  ; Global yy := 0x3D00 ; read aircraft lable
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, yy, int, 30, int, &yy, int, &dwResult)
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; yy := StrGet(&yy, 30, 0)

  ; err := _Message(yy, 0)

  ; Global FF := 100
  ; Global PP := 9000
  ; NumPut(PP, FF, 0, "int")
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x5520, int, 4, int, &FF, int, &dwResult)

  ; Standard VARs read

  If AC_TYPE_read ; Nur beim ersten Durchlauf
  {
    Global AC_TYPE := 0x3D00
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AC_TYPE, int, 14, char, &AC_TYPE, int, &dwResult)
  }

  Global GEAR := 0x0BE8 ; Gear
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GEAR, int, 4, int, &GEAR, int, &dwResult)

  Global GS := 0x02B4 ; Ground Speed
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GS, int, 4, int, &GS, int, &dwResult)

  Global TAS := 0x02B8 ; True Airspeed
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TAS, int, 4, int, &TAS, int, &dwResult)

  Global IAS := 0x02BC ; indicatet Airspeed
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, IAS, int, 4, int, &IAS, int, &dwResult)

  Global VSPEED := 0x02C8 ; Vertical Speed
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, VSPEED, int, 4, int, &VSPEED, int, &dwResult)

  Global VSPEED_TD := 0x030C ; Touchdown Rate Vertical Speed
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, VSPEED_TD, int, 4, int, &VSPEED_TD, int, &dwResult)

  Global TD_FLAG := 0x0366 ; Touchdown Flag
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TD_FLAG, int, 2, short, &TD_FLAG, int, &dwResult)

  Global QALT := 0x0574 ; Altitude basierend auf QNH in feet (High Bytes)
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, QALT, int, 4, int, &QALT, int, &dwResult)

  Global GALT :=0x0B4C ; Ground Altitude
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GALT, int, 2, short, &GALT, int, &dwResult)

  Global HDG := 0x0580 ; Heading
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HDG, int, 4, uint, &HDG, int, &dwResult)

  Global PBRAKE := 0x0BC8 ; parking brake
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", "int", PBRAKE, "int", 2, "short", &PBRAKE, "int", &dwResult)

  ; Global PUSHBACK :=0x31f0 ; Pushback Status
  ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, PUSHBACK, int, 4, int, &PUSHBACK, int, &dwResult)

  Global FLAPS := 0x0BDC ; Klappenstellung als Wert von 100%
  Global FLAPS_V := 999 ; Klappenstellung als Nr
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FLAPS, int, 4, int, &FLAPS, int, &dwResult)

  Global QNH_HP :=0x0330 ; DruckAltitude
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, QNH_HP, int, 2, short, &QNH_HP, int, &dwResult)

  Global ALT_KOLLSMANN :=0x3324 ; 
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, ALT_KOLLSMANN, int, 4,int, &ALT_KOLLSMANN, int, &dwResult)

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; Standard VARs convert

  If AC_TYPE_read
  {
    ; Zkette := StrGet(Quelle [, Länge] [, Codierung := Keine])
    AC_TYPE := StrGet(&AC_TYPE+5, 4, "UTF-8")

    If (AC_TYPE = "B737")
      {}
    Else
    {
      _Error_Message("AC_TYPE: B737 ->" AC_TYPE "<", 6)
      AC_TYPE := "????"
    }

    AC_TYPE_read := False
  }

  GEAR := NumGet(&GEAR, 0, "int") == 16383

  GS 	:= round(NumGet(&GS, 0, "int") / 65536 / 1000 * 3600) ; Ground Speed in km/h
  TAS := round(NumGet(&TAS, 0, "int") / 128) ; True Air Speed in Kn
  IAS 	:= round(NumGet(&IAS, 0, "int") / 128) ; Indicated Air Speed in Kn

  VSPEED		:= round(NumGet(&VSPEED, 0, "int") * 60 * 3.28084 / 256) ; Vertical Speed ft/ min
  VSPEED_TD	:= round(NumGet(&VSPEED_TD, 0, "int") * 60 * 3.28084 / 256) ; Touch down VSpeed  ft/ min
  TD_FLAG		:= Not (NumGet(&TD_FLAG, 0, "short") > 0) ; Touch down flag

  QALT	:= round(NumGet(&QALT, 0, "int") * 3.28) ; von Meter in Fuss umrechenen
  GALT	:= round(QALT - NumGet(&GALT, 0, "short") * 3.28) ; von Meter in Fuss umrechenen
  HDG		:= round(NumGet(&HDG, 0, "uint")*360/(65536*65536))

  PBRAKE 	:= NumGet(&PBRAKE, 0, "short") >= 22936

  ; PUSHBACK 	:= NumGet(&PUSHBACK, 0, "int")

  FLAPS 	:= NumGet(&FLAPS, 0, "int")
  FLAPS_V	:= round(FLAPS / (16382/ANZ_Flaps)) ; ?= Anzahl Flaps
  FLAPS 	:= FLAPS > 0

  QNH_HP := NumGet(&QNH_HP, 0, "short") / 16
  STD_On := QNH_HP = 1013.1875

  ALT_KOLLSMANN := NumGet(&ALT_KOLLSMANN, 0, "int")

  ; P3D Com Radios and Transponder read

  Global IVAP_TP := 0x7B91 ; !!! IVAP Transponder
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, IVAP_TP, int, 1, short, &IVAP_TP, int, &dwResult)

  Global COM1_STB_F := 0x311A
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_STB_F, int, 2, short, &COM1_STB_F, int, &dwResult)

  Global COM2_STB_F := 0x311C
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_STB_F, int, 2, short, &COM2_STB_F, int, &dwResult)

  Global COM1_ACT_F := 0x034E
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_ACT_F, int, 2, short, &COM1_ACT_F, int, &dwResult)

  Global COM2_ACT_F := 0x3118
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_ACT_F, int, 2, short, &COM2_ACT_F, int, &dwResult)

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; P3D Com Radios and Transponder convert

  IVAP_TP 	:= NumGet(&IVAP_TP, 0, "short") = 0

  COM1_STB_F := Format("{1:6x}", (NumGet(COM1_STB_F, 0, "short") * 0x10 + 0x100000))
  COM2_STB_F := Format("{1:6x}", (NumGet(COM2_STB_F, 0, "short") * 0x10 + 0x100000))
  COM1_ACT_F := Format("{1:6x}", (NumGet(COM1_ACT_F, 0, "short") * 0x10 + 0x100000))
  COM2_ACT_F := Format("{1:6x}", (NumGet(COM2_ACT_F, 0, "short") * 0x10 + 0x100000))

  ; B737 VARs read

  ; Freie FSUIPC Offsets: von 5400-5FFF Projekt Magenta

  Global FD := 0x6533 ; 6533 2 BYTE x 2 MCP_FDSw[2] Boolean
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FD, int, 1, short, &FD, int, &dwResult)
  Global AT := 0x6535 ; Autotrhrust
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AT, int, 1, short, &AT, int, &dwResult)
  Global AP := 0x6545
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AP, int, 1, short, &AP, int, &dwResult)
  Global TP := 0x65CD ; Transponder
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TP, int, 1, short, &TP, int, &dwResult)
  Global BEACON_L := 0x6501
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, BEACON_L, int, 1, short, &BEACON_L, int, &dwResult)
  Global TAXI_L := 0x64fA
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TAXI_L, int, 1, short, &TAXI_L, int, &dwResult)
  Global STROBE_L := 0x6500
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, STROBE_L, int, 1, short, &STROBE_L, int, &dwResult)
  Global LAND_L := 0x64F6
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, LAND_L, int, 1, short, &LAND_L, int, &dwResult)

  Global PBRAKE := 0x65A7 ; wegen wheel chocks ParkBrakeAnzeige
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, PBRAKE, int, 1, short, &PBRAKE, int, &dwResult)

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; B737 VARs convert

  FD := NumGet(&FD, 0, "short") > 0
  AT := NumGet(&AT, 0, "short") > 0
  AP := NumGet(&AP, 0, "short") > 0
  TP := NumGet(&TP, 0, "short") > 0

  BEACON_L	:= NumGet(&BEACON_L, 0, "short") > 0
  TAXI_L		:= NumGet(&TAXI_L, 0, "short") > 0
  STROBE_L	:= NumGet(&STROBE_L, 0, "short") = 2 ; Strobe&Steady
  LAND_L		:= NumGet(&LAND_L, 0, "short") > 0

  PBRAKE	:= NumGet(&PBRAKE, 0, "short") > 0

  DEBUG_Read_FS_VARS += 1000
Return Err
}

Write_Statusbar:
  DEBUG_Write_Statusbar++

  GetKeyState, NumLState ,NumLock, T ; NUM state

  If (NumLState = "D")
    NumLockChar := 1
  Else
    NumLockChar:= 0

  If (BlinkerChar = ">")
    BlinkerChar := "<"
  Else
    BlinkerChar := ">"

  TTex_FontB := 10 ; Spaltbreite 7
  TTex_FontS := 13 ; Breite eines Buchstabens

  TTex_Nr := 11 ; Array fängt bei 11 an

  TTex_StartPos[TTex_Nr] := TTex_xVersatz ; x Startposition wird festgelegt

  If (TTex_oFSVAR[TTex_Nr] <> PBRAKE)
  {
    TTex_oFSVAR[TTex_Nr] := PBRAKE
    Err := ToolTipEx("PB", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[PBRAKE], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> GEAR)
  {
    TTex_oFSVAR[TTex_Nr] := GEAR
    Err := ToolTipEx("Gear",	TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[GEAR], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> FLAPS_V)
  {
    TTex_oFSVAR[TTex_Nr] := FLAPS_V
    Err := ToolTipEx(STR_Flaps[FLAPS_V+1], TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[FLAPS_V], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> FD)
  {
    TTex_oFSVAR[TTex_Nr] := FD
    Err := ToolTipEx("FD", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[FD], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> AT)
  {
    TTex_oFSVAR[TTex_Nr] := AT
    Err := ToolTipEx("AT", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[AT], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> AP)
  {
    TTex_oFSVAR[TTex_Nr] := AP
    Err := ToolTipEx("AP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[AP], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
  }

  ; ++TTex_Nr

  ; If (TTex_oFSVAR[TTex_Nr] <> HVS)
  ; {
  ; TTex_oFSVAR[TTex_Nr] := HVS
  ; Err := ToolTipEx("HVS "HVS_V, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HVS], "BLACK", "", "S")
  ; TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 9) + TTex_FontS
  ; }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> BEACON_L)
  {
    TTex_oFSVAR[TTex_Nr] := BEACON_L
    Err := ToolTipEx("B", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[BEACON_L+10], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> TAXI_L)
  {
    TTex_oFSVAR[TTex_Nr] := TAXI_L
    Err := ToolTipEx("T", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[TAXI_L+10], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> STROBE_L)
  {
    TTex_oFSVAR[TTex_Nr] := STROBE_L
    Err := ToolTipEx("S", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[STROBE_L+10], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> LAND_L)
  {
    TTex_oFSVAR[TTex_Nr] := LAND_L
    Err := ToolTipEx("L", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[LAND_L+10], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> IVAP_TP)
  {
    TTex_oFSVAR[TTex_Nr] := IVAP_TP
    Err := ToolTipEx("TP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[IVAP_TP], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> STD_On)
  {
    TTex_oFSVAR[TTex_Nr] := STD_On
    Err := ToolTipEx("STD", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[STD_On], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> NumLockChar)
  {
    TTex_oFSVAR[TTex_Nr] := NumLockChar
    Err := ToolTipEx("N", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[NumLockChar], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ; 	 Err := ToolTipEx("N", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[NumLockChar], "BLACK", "", "S")
  ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS

  ++TTex_Nr

  If (WinActive(Aktu_Sim))
  {
    Err := ToolTipEx(BlinkerChar, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "RED", "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }
  Else
  {
    Err := ToolTipEx(BlinkerChar, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "WHITE", "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> AC_TYPE)
  {
    TTex_oFSVAR[TTex_Nr] := AC_TYPE
    Err := ToolTipEx(AC_TYPE, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> COM1_ACT_F)
  {
    TTex_oFSVAR[TTex_Nr] := COM1_ACT_F
    Err := ToolTipEx("CA " COM1_ACT_F, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "GREEN", "WHITE", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 9 ) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> COM1_STB_F)
  {
    TTex_oFSVAR[TTex_Nr] := COM1_STB_F
    Err := ToolTipEx("CS " COM1_STB_F, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "GREEN", "WHITE", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 9 ) + TTex_FontS
  }

  If Not TD_FLAG
  {
    ++TTex_Nr

    Err := ToolTipEx("TD "Format("{1:5}",VSPEED_TD), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[1], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8 ) + TTex_FontS

    ++TTex_Nr

    Err := ToolTipEx("GS "Format("{1:2}",GS), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
  }
  Else
  {
    ++TTex_Nr
    Err := ToolTipEx(,,,TTex_Nr)

    ++TTex_Nr
    Err := ToolTipEx(,,,TTex_Nr)
  }

  DEBUG_Write_Statusbar+= 1000
Return

Aircraft_Scenario:
  ; Global ACS_StartTime 	; Aircraft Scenario
  ; Global RFV_Time		; Read Flightsim Vars
  ; Global WSB_Time		; Write Statusbar
  ; Global ACS_Time		; Aircraft Scenario 
  ; Global ACS_EndTime	; Aircraft Scenario 

  DEBUG_Aircraft_Scenario++

  Critical ,On

  ACS_StartTime := A_TickCount

  If Not _Read_FS_VARS()
  {
    AC_TYPE := "FSVE"
    Gosub Write_Statusbar
    Gosub Stop_Aircraft_Scenario
    Gosub Start_Aircraft_Scenario
    Return
  }
  RFV_Time := A_TickCount - ACS_StartTime

  Gosub Write_Statusbar
  WSB_Time := A_TickCount - ACS_StartTime - RFV_Time

  Critical ,Off

  ; ********** passing FL100

  If ((QALT > 10050) And LAND_L)
  {
    Err := _CMD("landing lights off")
  }

  If ((QALT > 9000) And (QALT < 9950) And Not LAND_L) ; LUA
  {
    Err := _CMD("landing lights on")
  }

  ; ********** passing TRA oder TRL

  If Auto_Baro
  {
    InTrans := (QALT > 5000) And (QALT < 6000)

    If Not AboveTrans
      AboveTrans := (QALT > 6100)

    If Not BelowTrans
      BelowTrans := (QALT < 4900)

    If (InTrans)
    {
      If (AboveTrans And STD_On)
      {
        AboveTrans := False
        Err := _CMD("baro QNH")
      }

      If (BelowTrans And Not STD_On)
      {
        BelowTrans := False
        Err := _CMD("baro standard")
      }

    }
    Else ; If in Transiton
    {
      If ((QALT > 6100) And Not STD_On) ; über 6000 immer STD
      {
        Err := _CMD("baro standard")
      }

      If ((QALT < 4900) And STD_On) ; unter 5000 immer QNH
      {
        Err := _CMD("baro QNH")
      }
    }
  }

  ; ********** Checklisten

  ; ; "PREFLIGHT CHECKLIST"
  ; If (FD And Not PreflightCheck_Ok And PreflightProc_Ok And Not CheckList_Active)
  ; {
  ; Err := _CMD("preflight checklist")
  ; }

  ; "BEFORE TAXI CHECKLIST"
  If (Not PBRAKE And Not BeforeTaxi_Ok And PreflightCheck_Ok And Not CheckList_Active)
  {
    Err := _CMD("before taxi checklist")
  }

  ; "BEFORE TAKE OFF CHECKLIST"
  If (LAND_L And Not BeforeTakeOff_Ok And BeforeTaxi_Ok And Not CheckList_Active)
  {
    Err := _CMD("before take off checklist")
  }

  If TAXI_L And Not GEAR
  {
    Err := _CMD("taxi lights off")
  }

  ; "AFTER TAKE OFF CHECKLIST"
  If (Not FLAPS And Not AfterTakeOff_Ok And BeforeTakeOff_Ok And Not CheckList_Active)
  {
    Err := _CMD("after take off checklist")
  }

  ; damit "BEFORE APPROACH CHECKLIST" klappt
  If (Not PassingFL080)
  {
    PassingFL080 := (QALT > 8000)
  }

  ; "BEFORE APPROACH CHECKLIST"
  If ((QALT < 8000) And PassingFL080 And Not BeforeApproach_Ok And AfterTakeOff_Ok And Not CheckList_Active)
  {
    Err := _CMD("before approach checklist")
  }

  ; "BEFORE LANDING CHECKLIST"
  If ((FLAPS_V > 7) And Not BeforeLanding_Ok And BeforeApproach_Ok And Not CheckList_Active)
  {
    If (Not TAXI_L)
      Err := _CMD("taxi lights on")

    Err := _CMD("before landing checklist")
  }

  ; "AFTER LANDING CHECKLIST"
  If ((FLAPS_V < 1) And Not AfterLanding_Ok And BeforeLanding_Ok And Not CheckList_Active)
  {
    Err := _CMD("after landing checklist")

    PassingFL080 := False
  }

  ; "PARKING CHECKLIST"
  If (Not TAXI_L And Not Parking_Ok And AfterLanding_Ok And Not CheckList_Active)
  {
    Err := _CMD("parking checklist")
  }

  ; Tempomat :-)
  If (TAXI_L And (GS > TempoLow) And (GS < TempoHigh) And Not LAND_L)
  {
    Send ...
    SoundBeep, 300, 50
  }

  ACS_EndTime := A_TickCount - ACS_StartTime
  ACS_Time := ACS_EndTime - RFV_Time - WSB_Time

  DEBUG_Aircraft_Scenario += 1000
Return

Show_DEBUG_Info:
  DebugText =
  (
DEBUG Info:
  Listen_On > %Listen_On%
  Speech_Found > %Speech_Found%
  Speech_On > %Speech_On%`n
  CList_Active > %CheckList_Active%
  PassFL80 > %PassingFL080%

  PP > %PreflightProc_Ok%
  PC > %PreflightCheck_Ok%
  BT > %BeforeTaxi_Ok%
  BTO > %BeforeTakeOff_Ok%
  ATO > %AfterTakeOff_Ok%
  BA > %BeforeApproach_Ok%
  BL > %BeforeLanding_Ok%
  AL > %AfterLanding_Ok%
  PC > %Parking_Ok%

  AScr	 > %Aktu_Screen%
  LScr	 > %Last_Screen%

  FLAPS	 > %FLAPS%
  FLAPS_V > %FLAPS_V% 
  QALT	 > %QALT%
  GALT	 > %GALT%
  QNH 	 > %QNH_HP%

  CMD 	 > %DEBUG_CMD%
  CMD_Process 	 > %DEBUG_CMD_Process%
  Aircraft_Scenario > %DEBUG_Aircraft_Scenario%
  Read_FS_VARS 	 > %DEBUG_Read_FS_VARS%
  Write_Statusbar > %DEBUG_Write_Statusbar%
  Is_CheckItem	 > %DEBUG_Is_CheckItem%
  Check_ARCARS	 > %DEBUG_Check_ARCARS_Error_Win%

  CP_Time > %CP_EndTime%
  RFV_Time > %RFV_Time%
  WSB_Time > %WSB_Time%	
  ACS_Time > %ACS_Time% 
  ACS_EndTime	 > %ACS_EndTime%
  )

  Err := ToolTipEx(DebugText, x_ToolTip10, y_ToolTip10, 10, HFONT, "WHITE", "BLACK", "", "S")

Return

AIRCRAFT_INIT:
Return

_POV_Send(Screen) {
  WinActivate, %Aktu_Sim%

  If Not (Aktu_Screen = Screen)
  {
    Send %Screen%
    Last_Screen := Aktu_Screen
    Aktu_Screen := Screen
  }

Return Aktu_Screen
}

_NUMPAD_Send(Screen) {
  WinActivate, %Aktu_Sim%

  If (Aktu_Screen = Screen)
  {
    Aktu_Screen := Last_Screen
  }
  else
  {
    Last_Screen := Aktu_Screen
    Aktu_Screen := Screen
  }

  Send %Aktu_Screen%

Return Aktu_Screen
}

; -------------------------------------------------------
JOYSTICK_SECTION:
  ; -------------------------------------------------------
  ; 1JoyX Wireless Gamepad
  ; 3JoyX TM T-Flight Stick Hotas X (Hands On Throttle And Stick)
  ; 4JoyX Arduino

3JoyPOV:
POV:
  {
    Global POV_Step := 2
    Global POV_Value := GetKeyState("3JoyPOV")

    if (POV_Value < 0)
      Return

    If ((Aktu_Screen = 9) Or GetKeyState("LCtrl"))
    {
      if (POV_Value = 31500) ; Numpad7
      {
        SendInput {Ctrl Down}{7 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 0) ; Numpad8
      {
        SendInput {Ctrl Down}{8 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 4500) ; Numpad9
      {
        SendInput {Ctrl Down}{9 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 27000) ; Numbad4
      {
        ; SendInput {Ctrl Down}{4 %POV_Step%}{Ctrl Up}
        SendInput {Ctrl Down}{5 %POV_Step%}{Ctrl Up} ; wegen Aerosoft
      }
      else if (POV_Value = 9000) ; Numpad6
      {
        SendInput {Ctrl Down}{6 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 22500) ; Numpad1
      {
        SendInput {Ctrl Down}{1 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 18000) ;Numpad2
      {
        SendInput {Ctrl Down}{2 %POV_Step%}{Ctrl Up}
      }
      else if (POV_Value = 13500) ; Numpad3
      {
        SendInput {Ctrl Down}{3 %POV_Step%}{Ctrl Up}
      }

      Return
    }

    if (POV_Value = 31500) ; Numpad7
    {
      _POV_Send(7)
    }
    else if (POV_Value = 0) ; Numpad8
    {
      _POV_Send(8)
    }
    else if (POV_Value = 4500) ; Numpad9
    {
      _POV_Send(9)
    }
    else if (POV_Value = 27000) ; Numbad4
    {
      _POV_Send(4)
    }
    else if (POV_Value = 9000) ; Numpad6
    {
      _POV_Send(6)
    }
    else if (POV_Value = 22500) ; Numpad1
    {
      _POV_Send(1)
    }
    else if (POV_Value = 18000) ;Numpad2
    {
      _POV_Send(2)
    }
    else if (POV_Value = 13500) ; Numpad3
    {
      _POV_Send(3)
    }

    Return
  }

3Joy01_CheckitemOk:
  ; 3Joy1:: ; HOTAS _Joy_HM
  {
    ; Als Hotkey Button definiert
    Return
  }

3Joy02_MainPanel_GreatPanel:
3Joy2:: ; HOTAS _Joy_VM
  {
    x := 0
    While GetKeyState("3Joy2")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Gosub Screen0
        Return
      }
    }
    Send {Alt Up}{Shift Up}{Ctrl Up} ; alle Tasten löschen

    Gosub Screen5
    Return
  }

3Joy03_SpeechRec:
  ; 3Joy3:: ; HOTAS_Joy_RH
  {
    ; Als Hotkey Button definiert
    Return
  }

3Joy04_ATC:
  ; 3Joy4:: ; HOTAS_Joy_RV
  {
    ; Als Hotkey Button definiert
    Return
  }

3Joy05_AP_WarningsOff:
3Joy5:: ; HOTAS_Thrust_RO
  {
    x := 0
    While GetKeyState("3Joy5")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("warnings off")
        Return
      }
    }

    If AP
      err := _CMD("autopilot off")
    Else
      err := _CMD("autopilot on")

    Return
  }

3Joy06_AT_Navigation:
3Joy6:: ; HOTAS_Thrust_RM
  {
    x := 0
    While GetKeyState("3Joy6")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("hold navigation")
        Return
      }
    }

    If AT
      Err := _CMD("autothrust off")
    Else
      Err := _CMD("autothrust on")

    Return
  }

3Joy07_TakeOffThrust_ReverseThrust:
3Joy7:: ; HOTAS_Thrust_RU
  {
    x := 0
    While GetKeyState("3Joy7")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("reverse thrust")
        Return
      }
    }

    Err := _CMD("take off thrust")
    Return
  }

3Joy08_OutsideView_TopDownView:
3Joy8:: ; HOTAS_Thrust_VM
  {
    x := 0
    While GetKeyState("3Joy8")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("top down view")
        Return
      }
    }

    Err := _CMD("outside view")
    Return
  }

3Joy09_FlapsStepUp_FlapsUP:
3Joy9:: ; HOTAS_Thrust_HO
  {
    x := 0
    While GetKeyState("3Joy9")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("flaps full up")
        Return
      }
    }

    Err := _CMD("flaps step up")
    Return
  }

3Joy10_FlapsStepDown_FlapsDown:
3Joy10:: ; HOTAS_Thrust_HU
  {
    x := 0
    While GetKeyState("3Joy10")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("flaps full down")
        Return
      }
    }
    Err := _CMD("flaps step down")
    Return
  }

3Joy11_ParkingBrake_Gear:
3Joy11:: ; HOTAS_Thrust_UL
  {
    x := 0
    While GetKeyState("3Joy11")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        If GEAR
          Err := _CMD("gear up")
        Else
          Err := _CMD("gear down")
        Return
      }
    }	

    If PBRAKE
      Err := _CMD("parking brake off")
    Else
      Err := _CMD("parking brake on")

    Return
  }

3Joy12_StopTimer_GoAround:
3Joy12:: ; HOTAS _Thrust_UR
  {
    x := 0
    While GetKeyState("3Joy12")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("go around")
        Return
      }
    }	

    Err := _CMD("stop timer")
    Err := _CMD("strobe and landing lights off")
    Err := _CMD("flaps full up")
    Return
  }

  ; 1 - 4
  ; 2 - 5
  ; 3 - 6

4Joy01_HoldVNAV:
4Joy1::
  {
    Err := _CMD("hold V NAV")
    ; _Message("4Joy1", 0)
    Return
  }	

4Joy02_HoldSpeed:
4Joy2::
  {
    x := 0
    While GetKeyState("4Joy2")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("hold n1")
        Return
      }
    }	

    Err := _CMD("hold speed")
    ; _Message("4Joy2", 0)
    Return
  }	

4Joy03_HoldHeading_SyncHeading:
4Joy3::
  {
    x := 0
    While GetKeyState("4Joy3")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("synchronised heading")
        Return
      }
    }	

    Err := _CMD("hold heading")
    ; _Message("4Joy3", 0)
    Return
  }	

4Joy04_HoldLNAV:
4Joy4::
  {
    Err := _CMD("hold L NAV")
    ; _Message("4Joy4", 0)
    Return
  }	

4Joy05_HoldVS_LevelChange:
4Joy5::
  {
    x := 0
    While GetKeyState("4Joy5")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("level change")
        Return
      }
    }		

    Err := _CMD("hold vertical speed")
    ; _Message("4Joy5", 0)
    Return
  }	

4Joy06_HoldAlt_AltIntervention:
4Joy6::
  {
    x := 0
    While GetKeyState("4Joy6")
    {
      x := x + 1
      Sleep, ButtonWait_Delay

      If x = 10
      {
        Err := _CMD("alt intervention")
        Return
      }
    }

    Err := _CMD("hold altitude")
    ; _Message("4Joy6", 0)
    Return
  }	

4Joy07_SpeechRec:
  ; 4Joy7::
  {
    ; Als Hotkey Button definiert
    _Message("4Joy7", 0)
    Return
  }	

4Joy08_ATC:
  ; 4Joy8::
  {
    ; Als Hotkey Button definiert
    _Message("4Joy8", 0)
    Return
  }	

4Joy09_CecklistOK:
  ; 4Joy9::
  {
    ; Als Hotkey Button definiert
    _Message("4Joy9", 0)
    Return
  }	

ROTARIS:

4Joy10_CourseDown:
4Joy10::
  {
    Send {Ctrl Down}{Numpad0}{Ctrl Up}
    ; _Message("Course down", 0)
    Return
  }	
4Joy11_CourseUp:
4Joy11::
  {
    Send {Ctrl Down}{NumpadDot}{Ctrl Up}
    ; _Message("Course up", 0)
    Return
  }

4Joy12_SpeedDown:
4Joy12::
  {
    Send {Ctrl Down}{Numpad1}{Ctrl Up}
    ; _Message("speed up", 0)
    Return
  }	
4Joy13_SpeedUp:
4Joy13::
  {
    Send {Ctrl Down}{Numpad7}{Ctrl Up}
    ; _Message("speed down", 0)
    Return
  }

4Joy14_HeadingDown:
4Joy14::
  {
    Send {Ctrl Down}{Numpad4}{Ctrl Up}
    ; _Message("Hading down", 0)
    Return
  }	
4Joy15_HeadingUp:
4Joy15::
  {
    Send {Ctrl Down}{Numpad6}{Ctrl Up}
    ; _Message("Heading up", 0)
    Return
  }

4Joy16_AltitudeDown:
4Joy16::
  {
    Send {Ctrl Down}{Numpad2}{Ctrl Up}
    ; _Message("speed up", 0)
    Return
  }	
4Joy17_AltitudeUp:
4Joy17::
  {
    Send {Ctrl Down}{Numpad8}{Ctrl Up}
    ; _Message("speed down", 0)
    Return
  }

4Joy18_VSpeedDown:
4Joy18::
  {
    Send {Ctrl Down}{Numpad3}{Ctrl Up}
    ; _Message("speed up", 0)
    Return
  }	
4Joy19_VSpeedUp:
4Joy19::
  {
    Send {Ctrl Down}{Numpad9}{Ctrl Up}
    ; _Message("speed down", 0)
    Return
  }

  ; -------------------------------------------------------
KEYBOARD_SECTION:
  ; -------------------------------------------------------
  ; *		= wird immer ausgelöst auch wenn modifikaton
  ; $ 	= keine rekursion
  ; ~  	= Taste weiterleiten
  ; + 	= [Shift]-Taste
  ; ^ 	= [Ctrl]-Taste
  ; ! 	= [QALT]-Taste
  ; # 	= [Win] -Taste
  ; <# 	= [Left Win Taste]

~F9::
~F10::
~F11::
~F12::
  {
    Aktu_Screen = -1
    Return
  }

Screen7:
NumpadHome:: ; Numpad7
  {
    Err := _NUMPAD_Send(7)
    Return
  }

Screen8:
NumpadUp:: ; Numpad8
  {
    Err := _NUMPAD_Send(8)
    Return
  }

Screen9:
NumpadPgUp:: ; Numpad9
  {
    Err := _NUMPAD_Send(9)
    Return
  }

Screen4:
NumpadLeft:: ; Numpad4
  {
    Err := _NUMPAD_Send(4)
    Return
  }

Screen5:
NumpadClear:: ; Numpad5
  {
    Err := _NUMPAD_Send(5)
    Return
  }

Screen6:
NumpadRight:: ; Numpad6
  {
    Err := _NUMPAD_Send(6)
    Return
  }

Screen1:
NumpadEnd:: ; Numpad1
  {
    Err := _NUMPAD_Send(1)
    Return
  }

Screen2:
NumpadDown:: ; Numpad2
  {
    Err := _NUMPAD_Send(2)
    Return
  }

Screen3:
NumpadPgDn:: ; Numpad3
  {
    Err := _NUMPAD_Send(3)
    Return
  }

Screen0:
NumpadIns:: ; Numpad0
  {
    Err := _NUMPAD_Send(0)
    Return
  }

ScreenDel:
NumpadDel:: ; NumpadDel
  {
    Err := _CMD("reset view")
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT: ; NUMLock Aus
  ; -------------------------------------------------------
  ; hierdurch wird Ctrl+Alt(6) (langsames Rotari) an LUA weitergegeben 

  ; +Home::
+NumpadHome:: ; Numpad7
  {
    Send {Ctrl Down}{Alt Down}{Numpad7}{Alt Up}{Ctrl Up}
    Return
  }
  ; ; +Up::
+NumpadUp:: ; Numpad8
  {
    Send {Ctrl Down}{Alt Down}{Numpad8}{Alt Up}{Ctrl Up}
    Return
  }
  ; +PgUp::
+NumpadPgUp:: ; Numpad9
  {
    Send {Ctrl Down}{Alt Down}{Numpad9}{Alt Up}{Ctrl Up}
    Return
  }
  ; +Left::
+NumpadLeft:: ; Numpad4
  {
    Send {Ctrl Down}{Alt Down}{Numpad4}{Alt Up}{Ctrl Up}
    Return
  }
+NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift", 3)
    Send {Ctrl Down}{Alt Down}{Numpad5}{Alt Up}{Ctrl Up}
    Return
  }
  ; +Right::
+NumpadRight:: ; Numpad6
  {
    Send {Ctrl Down}{Alt Down}{Numpad6}{Alt Up}{Ctrl Up}
    Return
  }
  ; +End::
+NumpadEnd:: ; Numpad1
  {
    Send {Ctrl Down}{Alt Down}{Numpad1}{Alt Up}{Ctrl Up}
    Return
  }
  ; +Down::
+NumpadDown:: ; Numpad2
  {
    Send {Ctrl Down}{Alt Down}{Numpad2}{Alt Up}{Ctrl Up}
    Return
  }
  ; +PgDn::
+NumpadPgDn:: ; Numpad3
  {
    Send {Ctrl Down}{Alt Down}{Numpad3}{Alt Up}{Ctrl Up}
    Return
  }
  ; +Ins::
+NumpadIns:: ; Numpad0
  {
    Send {Ctrl Down}{Alt Down}{Numpad0}{Alt Up}{Ctrl Up}
    Return
  }
  ; Del::
+NumpadDel:: ; NumpadDel
  {
    Send {Ctrl Down}{Alt Down}{NumpadDot}{Alt Up}{Ctrl Up}
    Return
  }

  ; -------------------------------------------------------
NUMPAD_CTRL: ; NUMLock Aus
  ; -------------------------------------------------------
  ; hierdurch (schnelles Rotari) an LUA weitergegeben 

  ; ^Home::
^NumpadHome:: ; Numpad7
  {
    Send {Ctrl Down}{Numpad7}{Ctrl Up}
    Return
  }
  ; ^Up::
^NumpadUp:: ; Numpad8
  {
    Send {Ctrl Down}{Numpad8}{Ctrl Up}
    Return
  }
  ; ^PgUp::
^NumpadPgUp:: ; Numpad9
  {
    Send {Ctrl Down}{Numpad9}{Ctrl Up}
    Return
  }
  ; ^Left::
^NumpadLeft:: ; Numpad4
  {
    Send {Ctrl Down}{Numpad4}{Ctrl Up}
    Return
  }
^NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Ctrl", 3)
    Send {Ctrl Down}{Numpad5}{Ctrl Up}
    Return
  }
  ; ^Right::
^NumpadRight:: ; Numpad6
  {
    Send {Ctrl Down}{Numpad6}{Ctrl Up}
    Return
  }
  ; ^End::
^NumpadEnd:: ; Numpad1
  {
    Send {Ctrl Down}{Numpad1}{Ctrl Up}
    Return
  }
  ; ^Down::
^NumpadDown:: ; Numpad2
  {
    Send {Ctrl Down}{Numpad2}{Ctrl Up}
    Return
  }
  ; ^PgDn::
^NumpadPgDn:: ; Numpad3
  {
    Send {Ctrl Down}{Numpad3}{Ctrl Up}
    Return
  }
  ; ^Ins::
^NumpadIns:: ; Numpad0
  {
    Send {Ctrl Down}{Numpad0}{Ctrl Up}
    Return
  }
  ; Del::
^NumpadDel:: ; NumpadDel
  {
    Send {Ctrl Down}{NumpadDot}{Ctrl Up}
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT_CTRL: ; NUMLock Aus
  ; -------------------------------------------------------

  ; +^Home::
+^NumpadHome:: ; Numpad7
  {
    Return
  }
  ; +^Up::
+^NumpadUp:: ; Numpad8
  {
    Return
  }
  ; +^PgUp::
+^NumpadPgUp:: ; Numpad9
  {
    Return
  }
  ; +^Left::
+^NumpadLeft:: ; Numpad4
  {
    Return
  }
+^NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift+Ctrl", 3)
    Return
  }
  ; +^Right::
+^NumpadRight:: ; Numpad6
  {
    Return
  }
  ; +^End::
+^NumpadEnd:: ; Numpad1
  {
    Return
  }
  ; +^Down::
+^NumpadDown:: ; Numpad2
  {
    Return
  }
  ; +^PgDn::
+^NumpadPgDn:: ; Numpad3
  {
    Return
  }
  ; +^Ins::
+^NumpadIns:: ; Numpad0
  {
    Return
  }
  ; Del::
+^NumpadDel:: ; NumpadDel
  {
    Return
  }

  ; -------------------------------------------------------
NUMPAD_ALT: ; NUMLock Aus
  ; -------------------------------------------------------

!NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Alt", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT_ALT: ; NUMLock Aus
  ; -------------------------------------------------------

+!NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift+Alt", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_CTRL_ALT: ; NUMLock Aus
  ; -------------------------------------------------------

^!NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Ctrl+Alt", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_CTRL_ALTGr: ; NUMLock Aus
  ; -------------------------------------------------------
  ; remapt auf POV 1..9

  ; +Home::
^!NumpadHome:: ; Numpad7
  {
    Send {Ctrl Down}{7 3}{Ctrl Up}
    Return
  }
  ; ^!Up::
^!NumpadUp:: ; Numpad8
  {
    Send {Ctrl Down}{8 3}{Ctrl Up}
    Return
  }
  ; ^!PgUp::
^!NumpadPgUp:: ; Numpad9
  {
    Send {Ctrl Down}{9 3}{Ctrl Up}
    Return
  }
  ; ^!Left::
^!NumpadLeft:: ; Numpad4
  {
    ; Send {Ctrl Down}{4 3}{Ctrl Up} ; 4 klappt nicht nur bei Aerosoft
    Send {Ctrl Down}{5 3}{Ctrl Up}
    Return
  }

  ; ^!NumpadClear:: ; Numpad5
  ; {
  ; 	_Message("Numpad5 mit Ctrl+Alt", 3)
  ; 	Return
  ; }

  ; ^!Right::
^!NumpadRight:: ; Numpad6
  {
    Send {Ctrl Down}{6 3}{Ctrl Up}
    Return
  }
  ; ^!End::
^!NumpadEnd:: ; Numpad1
  {
    Send {Ctrl Down}{1 3}{Ctrl Up}
    Return
  }
  ; ^!Down::
^!NumpadDown:: ; Numpad2
  {
    Send {Ctrl Down}{2 3}{Ctrl Up}
    Return
  }
  ; ^!PgDn::
^!NumpadPgDn:: ; Numpad3
  {
    Send {Ctrl Down}{3 3}{Ctrl Up}
    Return
  }
  ; ^!Ins::
^!NumpadIns:: ; Numpad0
  {
    Return
  }
  ; Del::
^!NumpadDel:: ; NumpadDel
  {
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT_CTRL_ALT: ; NUMLock Aus
  ; -------------------------------------------------------

+^!NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift+Ctrl+Alt", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_WIN: ; NUMLock Aus
  ; -------------------------------------------------------

#NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Win", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT_WIN: ; NUMLock Aus
  ; -------------------------------------------------------

+#NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift+Win", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_CTRL_WIN: ; NUMLock Aus
  ; -------------------------------------------------------

^#NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Ctrl+Win", 3)
    Return
  }

  ; -------------------------------------------------------
NUMPAD_SHIFT_CTRL_WIN: ; NUMLock Aus
  ; -------------------------------------------------------

+^#NumpadClear:: ; Numpad5
  {
    _Message("Numpad5 mit Shift+Ctrl+Win", 3)
    Return
  }

  ; NUMLock Aus
  ; Shift  Ctrl  Alt  Win
  ;	-	  -	    -    -		ok nutzbar in P3D	Views
  ;	x	  -	    -    -		ok ./. in P3D		remapt Shift-Ctrl Speed/Heading/feet slow
  ;	-	  x	    -    -		ok nutzbar in P3D	Speed/Heading/feet fast
  ;	x	  x	    -    -		ok ./. in P3D		
  ;	-	  -	    x    -		ok ./. in P3D
  ;	x	  -	    x    -		ok ./. in P3D4
  ;	-	  x	    x    -		ok AltGr in P3D 	remapt in POV Ctrl-1..9
  ;	x	  x	    x    -		ok AltGr in P3D 	
  ;	-	  x	    -    x		ok ./. in P3D 

  ; -------------------------------------------------------
NUMPAD_mit_NUMLOCK: ; mit NUMLOCK gedrückt
  ; -------------------------------------------------------

Numpad5:: ; !! NOCH FREI
  {
    _Message("Numlock Numpad5", 3)
    Return
  }

+Numpad5:: ; ./. SHIFT wird ignoriert
  {
    _Message("Numlock Numpad5 mit Shift", 3)
    Return
  }

^Numpad5:: ; !! VERGEBEN für Rotari Knobs ...
  {
    _Message("Numlock Numpad5 mit Ctrl", 3)
    Return
  }

+^Numpad5:: ; ./. SHIFT wird ignoriert
  {
    _Message("Numlock Numpad5 mit Shift+Ctrl", 3)
    Return
  }

!Numpad5:: ; ./. ALT=Menu immer im Flight Sim vergeben
  {
    _Message("Numlock Numpad5 mit Alt", 3)
    Return
  }

+!Numpad5:: ; ./.  SHIFT wird ignoriert und damit ALT=Menu 
  {
    _Message("Numlock Numpad5 mit Shift+Alt", 3)
    Return
  }

^!Numpad5:: ; !! VERGEBEN für Rotari Knobs ...
  {
    _Message("Numlock Numpad5 mit Ctrl+Alt", 3)
    Return
  }

+^!Numpad5:: ;./.  ergibt Numpad5 OHNE Numlock
  {
    _Message("Numlock Numpad5 mit Shift+Ctrl+Alt", 3)
    Return
  }
