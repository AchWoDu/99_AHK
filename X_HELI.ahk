X_HELI_2022_05_06:

DEV_VARS:
  Global TEST := False Or True ; Keine Programme starten
  Global DEBUG := False ; Or True ; Debug anzeigen

  Global Aktu_Sim := "X-System"
  Global Aktu_Scenario := "HELI" ; zum suchen in Load Scenario
  Global CMD_File := "X_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "X_" Aktu_Scenario "_CMD.txt"

  ; Sprachbefehl Anzeigen
  Global x_Versatz := 0 ; -1920 ; <-  0  -> +1920
  Global y_Versatz := 0

  ; Status-Bar und Checklist_ITEM (ToolTip 11..n und 3)
  Global TTex_xVersatz := 348 ; -1920 <-  0  -> +1920
  Global TTex_yVersatz := 0

  Global CheckOK_Break := True ; wenn auch bei CecklistBreak die Checkliste ok ist
  Global STD_On := False ; Wenn Baro STD gesetzt

  Global TRIM := 0 ; Temp VAR für Trim up/down

  #Include %A_ScriptDir%\Common.ahk
  ; 

CMD_Process:
  {
    DEBUG_CMD_Process++

    Critical, On

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
    Else If (CMD_Text="night panel")
    {
      Send {Shift Down}w{Shift Up}
      Send {Alt Down}h{Alt Up}
    }
    Else If (CMD_Text="GPS") ; not for G1000
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}g{Shift Up}{Ctrl Up}{Alt Up}
    }
    Else If (CMD_Text="autopilot") ; XAP  Panel??
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}3{Shift Up}{Ctrl Up}{Alt Up}
    }
    Else If (CMD_Text="transponder") ; XAP  Panel??
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}5{Shift Up}{Ctrl Up}{Alt Up}
    }
    Else If (CMD_Text="PDF window") ; G1000 only
    {
      send {Ctrl Down}{Alt Down}1{Shift Up}{Ctrl Up}{Alt Up}
    }
    Else If (CMD_Text="MFD window") ; G1000 only
    {
      send {Ctrl Down}{Alt Down}2{Shift Up}{Ctrl Up}{Alt Up}
    }
    ;
    ; NUMPAD Views
    ;
    Else If (CMD_Text="top down view") ; 7
    {
      Gosub Screen7
    }
    Else If (CMD_Text="landing panel") ; 8
    {
      Gosub Screen8
    }
    Else If (CMD_Text="outside view") ; 9
    {
      Gosub Screen9
    }
    Else If (CMD_Text="left window") ; 6
    {
      Gosub Screen6
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
    Else If (CMD_Text="P F D") ; 1
    {
      Gosub Screen1
    }
    Else If (CMD_Text="trim wheel") ; 2
    {
      Gosub Screen2
    }
    Else If (CMD_Text="throttle") ; 2
    {
      Gosub Screen2
    }
    Else If (CMD_Text="radio stack") ; 3
    {
      Gosub Screen3
    }
    Else If (CMD_Text="N A V") ; 3
    {
      Gosub Screen3
    }
    Else If (CMD_Text="M F D") ; 3
    {
      Gosub Screen3
    }
    Else If (CMD_Text="great panel") ; 0 ;
    {
      Gosub Screen0
    }
    Else If (CMD_Text="no panel") ; Del
    {
      Gosub ScreenDel
    }
    ;
    ; Autopilot
    ;
    Else If (CMD_Text="autopilot on")
    {
      Send z
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="autopilot off")
    {
      Send z
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold heading")
    {
      Send {Shift Down}{Ctrl Down}h{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold roll mode")
    {
      If HHDG
        Send +^h

      Send +^h
      Send +^h
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold navigation")
    {
      Send {Shift Down}{Ctrl Down}n{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold approach")
    {
      Send {Shift Down}{Ctrl Down}a{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold altitude")
    {
      Send {Shift Down}{Ctrl Down}z{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="hold vertical speed")
    {
      Send {Shift Down}{Ctrl Down}v{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="flight director on")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="flight director off")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="GPS navigation on")
    {
      Send {Ctrl Down}{Alt Down}g{Ctrl Up}{Alt Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="GPS navigation off")
    {
      Send {Ctrl Down}{Alt Down}g{Ctrl Up}{Alt Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    ;
    ; Controls
    ;
    ;
    ; Lights
    ;
    Else If (CMD_Text="beacon lights on")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="beacon lights off")
    {
      Send {Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="landing lights on")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="landing lights off")
    {
      Send {Ctrl Down}{Alt Down}l{Alt up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe lights on")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe lights off")
    {
      Send {Ctrl Down}{Alt Down}s{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe and landing lights on")
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}s{Shift Up}{Ctrl Up}
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Shift Up}{Ctrl Up}{Alt Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe and landing lights off")
    {
      Send {Ctrl Down}{Alt Down}s{Shift Up}{Ctrl Up}{Alt Up}
      Send {Ctrl Down}{Alt Down}l{Alt Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    ;
    #Include %A_ScriptDir%\Common_CMD_XP.ahk
    #Include %A_ScriptDir%\Common_CMD.ahk
    Return
  }

  _Preflight_Procedure()
  {

    SetTimer,, Off
    CheckList_Active := True

    If _Is_CheckItem("Preflight procedure is complete! ")
      PreflightProc_Ok := True

    PreflightProc_Ok := PreflightProc_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _Preflight_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Preflight checklist")

    If _Is_CheckItem("Check the calculated fuel quantity!")
      If _Is_CheckItem("Is the flight scheduled and the flightplan filed?")
      If _Is_CheckItem("Where necessary, check if the GPS armed and the flightplan loaded!")
      If _Is_CheckItem("Check the parking brake!")
      If _Is_CheckItem("Check the trimm wheel and fuel selector position!")
      If _Is_CheckItem("Check if the beacon- and the navigation light swiched on!")
      If _Is_CheckItem("Check the transponder code!")
      If _Is_CheckItem("Check if hold heading and vertical speed armed!")
      ; If _Is_CheckItem("Check if gyro and magnet compass synchronized!")
    If _Is_CheckItem("Check if heading and OBS on runway course!")
      If _Is_CheckItem("Check the altimeter setting!")

    If _Is_CheckItem("Preflight checklist is complete! You can request taxi!")
      PreflightCheck_Ok := True

    PreflightCheck_Ok := PreflightCheck_Ok Or CheckOK_Break
    CheckList_Active := False

    Return
  }

  _BeforeTaxi_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Before Taxi Checklist")

    If _Is_CheckItem("Check if the flaps in take off configuration!")

    If _Is_CheckItem("Before taxi checklist is complete!")
      BeforeTaxi_Ok := True

    BeforeTaxi_Ok := BeforeTaxi_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _BeforeTakeOff_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Before take off checklist")

    If _Is_CheckItem("Check the heading and navigation settings!")
      If _Is_CheckItem("Request ready for departure!")
      If _Is_CheckItem("Check transponder mode charly and run the timer!")

    If _Is_CheckItem("Before take off checklist is complete!")
      BeforeTakeOff_Ok := True

    BeforeTakeOff_Ok := BeforeTakeOff_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _AfterTakeOff_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("After take off checklist")

    If _Is_CheckItem("Check if the flaps full up!")
      If _Is_CheckItem("Check autopilot settings!")

    If _Is_CheckItem("After take off checklist is complete!")
      AfterTakeOff_Ok := True

    AfterTakeOff_Ok := AfterTakeOff_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _BeforeApproach_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Before approach checklist")

    If _Is_CheckItem("Check if approach transition in GPS is loaded!")
      If _Is_CheckItem("Check if landing lights switched on!")

    If _Is_CheckItem("Before approach checklist is complete!")
      BeforeApproach_Ok := True

    BeforeApproach_Ok := BeforeApproach_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _BeforeLanding_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Before landing checklist")

    If _Is_CheckItem("Check if GPS is disengaged and approach engaged!")

    If _Is_CheckItem("Check the altimeter!")
      If _Is_CheckItem("Check if flaps in landing position!")

    If _Is_CheckItem("Before landing checklist is complete!")
      BeforeLanding_Ok := True

    BeforeLanding_Ok := BeforeLanding_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _AfterLanding_Checklist()
  {
    Critical ,Off
    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("After landing checklist")

    If _Is_CheckItem("Check if the transponder in mode standby!")
      If _Is_CheckItem("Check if the flaps retracted!")
      If _Is_CheckItem("Check if strobe- and landing lights off and taxi light on!")
      If _Is_CheckItem("Check if the autopilot switched off!")

    If _Is_CheckItem("After landing checklist is complete! Stop timer and request taxi to the gate!")
      AfterLanding_Ok := True

    AfterLanding_Ok := AfterLanding_Ok Or CheckOK_Break
    CheckList_Active := False
    Return
  }

  _Parking_Checklist()
  {

    SetTimer,, Off
    CheckList_Active := True

    Err := _Text_to_Speech("Parking Checklist")

    If _Is_CheckItem("Check if battery master and avionic switched off!")

    If _Is_CheckItem("Parking checklist is complete!")
      Parking_Ok := True

    Parking_Ok := Parking_Ok Or CheckOK_Break
    CheckList_Active := False

    Gosub Auto_Checklists
    Return
  }

  _Read_FS_VARS()
  {
    ; DEVs
    DEBUG_Read_FS_VARS++

    ; Typ	Wertebereich								Länge
    ; byte	-128..127									8 Bit
    ; short	-32768..32767								16 Bit
    ; int	-2147483648..2147483647						32 Bit
    ; (u)Int 											32 Bit
    ; long	-9223372036854775808..9223372036854775807	64 Bit

    ; Standard VARs read

    If AC_TYPE_read ; Nur beim ersten Durchlauf
    {
      Global AC_TYPE :=0x3160 ; bei P3D 0x3D00
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AC_TYPE, int, 14, char, &AC_TYPE, int, &dwResult)
    }

    Global ELV_TRIM := 0 ; YAW Throttle Achse in %
    ; Global ELV_TRIM := 0x0BC0 ; ELEVATOR Trimmung in %
    ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, ELV_TRIM, int, 2, short, &ELV_TRIM, int, &dwResult)

    Global POWER := 0 ; Colective Throttel Achse in %
    ; Global POWER := 0x088c ; Power in %
    ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, POWER, int, 2, short, &POWER, int, &dwResult)

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

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

    ; Standard VARs convert

    If AC_TYPE_read
    {
      AC_TYPE := StrGet(&AC_TYPE, 8, "UTF-8")

      If (AC_TYPE == "Bell 206")
        AC_TYPE := "B206 "
      Else If (AC_TYPE == "Bell_407")
        AC_TYPE := "B407"
      Else If (AC_TYPE == "Bell_412")
        AC_TYPE := "B412"
      Else If (AC_TYPE == "Bell_429")
        AC_TYPE := "B429"
      Else If (AC_TYPE == "H45 ")
        AC_TYPE := "H145"
      Else If (AC_TYPE == "SA315B -")
        AC_TYPE := "LAMA"
      Else If (AC_TYPE == "KiowaW ")
        AC_TYPE := "B06 "
      {
        _Error_Message("AC_TYPE: HELI ->" AC_TYPE "<", 6)
        AC_TYPE := "????"
      }

      AC_TYPE_read := False
    }

    ; ELV_TRIM := ceil(NumGet(&ELV_TRIM, 0, "short") / 164)
    ELV_TRIM := ceil(-50 + GetKeyState("1JoyZ")) ; YAW-Achse
    ; _Message(ELV_TRIM,0)

    POWER := ceil(100- GetKeyState("3JoyZ")) ; Colective Achse
    ; _Message(POWER,0)

    GEAR := NumGet(&GEAR, 0, "int") == 16383

    GS 	:= round(NumGet(&GS, 0, "int") / 65536 / 1000 * 3600) ; Ground Speed in km/h
    TAS := round(NumGet(&TAS, 0, "int") / 128) ; True Air Speed in Kn
    IAS := round(NumGet(&IAS, 0, "int") / 128) ; Indicated Air Speed in Kn

    VSPEED		:= round(NumGet(&VSPEED, 0, "int") * 60 * 3.28084 / 256) ; Vertical Speed ft/ min
    VSPEED_TD 	:= round(NumGet(&VSPEED_TD, 0, "int") * 60 * 3.28084 / 256) ; Touch down VSpeed  ft/ min
    TD_FLAG		:= Not (NumGet(&TD_FLAG, 0, "short") > 0) ; Touch down flag

    QALT 	:= round(NumGet(&QALT, 0, "int") * 3.28) ; Pressure Altitude von Meter in Fuss umrechenen
    GALT 	:= round(QALT - NumGet(&GALT, 0, "short") * 3.28) ; Ground Altitude von Meter in Fuss umrechenen
    HDG		:= round(NumGet(&HDG, 0, "uint")*360/(65536*65536)) ; Heading

    PBRAKE 	:= NumGet(&PBRAKE, 0, "short") >= 22936 ; Parking brake

    ; XPlane Com Radios and Transponder read

    Global XIVAP_TP := 0x6D8C ; XIVAP Transponder
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, XIVAP_TP, int, 4, int, &XIVAP_TP, int, &dwResult)

    Global COM1_STB_F := 0x5530
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_STB_F, int, 4, int, &COM1_STB_F, int, &dwResult)

    Global COM2_STB_F := 0x5534
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_STB_F, int, 4, int, &COM2_STB_F, int, &dwResult)

    Global COM1_ACT_F := 0x5538
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_ACT_F, int, 4, int, &COM1_ACT_F, int, &dwResult)

    Global COM2_ACT_F := 0x5542
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_ACT_F, int, 4, int, &COM2_ACT_F, int, &dwResult)

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

    ; XPlane Com Radios and Transponder convert

    XIVAP_TP 	:= NumGet(&XIVAP_TP, 0, "int") > 1 ; 0 = Off

    COM1_STB_F := NumGet(&COM1_STB_F, 0, "int")
    COM2_STB_F := NumGet(&COM2_STB_F, 0, "int")
    COM1_ACT_F := NumGet(&COM1_ACT_F, 0, "int")
    COM2_ACT_F := NumGet(&COM2_ACT_F, 0, "int")

    ; Alle GA Flieger- VARs read

    Global FD := 0x2EE0 ; Flight Director
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FD, int, 4, int, &FD, int, &dwResult)

    Global AT := 0x0810 ; Autothrottel ARM
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AT, int, 4, int, &AT, int, &dwResult)

    Global AP := 0x07BC ; Autopilot
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AP, int, 4, int, &AP, int, &dwResult)

    Global HNAV := 0x07C4 ; Hold Navigaton
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HNAV, int, 4, int, &HNAV, int, &dwResult)
    Global HNAV1_V := 0x0C4E ; NAV1 OBS setting (degrees, 0–359)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HNAV1_V, int, 2, short, &HNAV1_V, int, &dwResult)

    Global HHDG := 0x07C8 ; Hold Heading
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HHDG, int, 4, int, &HHDG, int, &dwResult)
    Global HHDG_V := 0x07CC ; Heading als Value in °
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HHDG_V, int, 2, short, &HHDG_V, int, &dwResult)

    Global HALT := 0x07D0 ; Hold Altitude
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HALT, int, 4, int, &HALT, int, &dwResult)

    Global HVS := 0x07EC ; Hold Vertical Speed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HVS, int, 4, int, &HVS, int, &dwResult)
    Global HVS_V := 0x07F2 ; Hold Vertical Speed als Value in feet/ min
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HVS_V, int, 2, short, &HVS_V, int, &dwResult)

    Global HAPP := 0x0800 ; Hold Approach
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HAPP, int, 4, int, &HAPP, int, &dwResult)

    Global HGPS := 0x132C ; Hold GPS
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HGPS, int, 4, int, &HGPS, int, &dwResult)

    Global LIGHTS := 0x0D0C
    Global NAVIGATION_L := 999
    Global BEACON_L := 999
    Global TAXI_L := 999
    Global LAND_L := 999
    Global STROBE_L := 999
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, LIGHTS, int, 2, short, &LIGHTS, int, &dwResult)

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

    ; Alle GA Flieger- VARs convert

    FD	:= NumGet(&FD, 0, "int") > 0
    AT	:= NumGet(&AT, 0, "int") > 0
    AP	:= NumGet(&AP, 0, "int") > 0

    HNAV 	 := NumGet(&HNAV, 0, "int") > 0
    HNAV1_V := NumGet(&HNAV1_V, 0, "short")

    HHDG 	:= NumGet(&HHDG, 0, "int") > 0
    HHDG_V	:= round(NumGet(&HHDG_V, 0, "ushort") * 360 / 65536)

    HALT := NumGet(&HALT, 0, "int") > 0

    HVS		:= NumGet(&HVS, 0, "int") > 0
    HVS_V 	:= NumGet(&HVS_V, 0, "short")

    HAPP := NumGet(&HAPP, 0, "int") > 0
    HGPS := NumGet(&HGPS, 0, "int") > 0

    ; 0 = Navigatin / 2 = Beacon/ 4 = Landing / 8 = Taxi / 16 = Strobe / 32 = Instruments / 64 = Recognition / 128 = Wing

    LIGHTS 	:= NumGet(&LIGHTS, 0, "short")
    NAVIGATION_L:= (LIGHTS & 1) == 1
    BEACON_L	:= (LIGHTS & 2) == 2
    TAXI_L		:= (LIGHTS & 8) == 8
    STROBE_L	:= (LIGHTS & 16) == 16
    LAND_L		:= (LIGHTS & 4) == 4

    DEBUG_Read_FS_VARS += 1000
    Return Err
  }

Write_Statusbar:
  {
    DEBUG_Write_Statusbar++

    GetKeyState, NumLState ,NumLock, T ; NUM State

    ; If (NumLState = "D")
    ; NumLockChar := "↓"
    ; Else
    ; NumLockChar:= "↑"

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

    ; If (TTex_oFSVAR[TTex_Nr] <> PBRAKE)
    ; {
    ; 	TTex_oFSVAR[TTex_Nr] := PBRAKE
    ; 	Err := ToolTipEx("PBrake", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[PBRAKE], "BLACK", "", "S")
    ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
    ; }

    ; ++TTex_Nr

    ; If (TTex_oFSVAR[TTex_Nr] <> GEAR)
    ; {
    ; 	TTex_oFSVAR[TTex_Nr] := GEAR
    ; 	Err := ToolTipEx("Gear",	TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[GEAR], "BLACK", "", "S")
    ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    ; }

    ; ++TTex_Nr

    ; If (TTex_oFSVAR[TTex_Nr] <> FLAPS_V)
    ; {
    ; 	TTex_oFSVAR[TTex_Nr] := FLAPS_V
    ; 	Err := ToolTipEx("Flaps"FLAPS_V, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[FLAPS_V], "BLACK", "", "S")
    ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
    ; }

    ; ++TTex_Nr

    ; If (TTex_oFSVAR[TTex_Nr] <> HGPS)
    ; {
    ; 	TTex_oFSVAR[TTex_Nr] := HGPS
    ; 	Err := ToolTipEx("GPS", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HGPS], "BLACK", "", "S")
    ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    ; }

    ; ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> AP)
    {
      TTex_oFSVAR[TTex_Nr] := AP
      Err := ToolTipEx("AP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[AP], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> HHDG)
    {
      TTex_oFSVAR[TTex_Nr] := HHDG
      Err := ToolTipEx("!HDG", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HHDG], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> HNAV)
    {
      TTex_oFSVAR[TTex_Nr] := HNAV
      Err := ToolTipEx("!NAV", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HNAV], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> HAPP)
    {
      TTex_oFSVAR[TTex_Nr] := HAPP
      Err := ToolTipEx("!APR", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HAPP], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> HALT)
    {
      TTex_oFSVAR[TTex_Nr] := HALT
      Err := ToolTipEx("!ALT", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HALT], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> HVS)
    {
      TTex_oFSVAR[TTex_Nr] := HVS
      Err := ToolTipEx("!VS", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HVS], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> BEACON_L)
    {
      TTex_oFSVAR[TTex_Nr] := BEACON_L
      Err := ToolTipEx("B", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[BEACON_L+10], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
    }

    ; ++TTex_Nr

    ; If (TTex_oFSVAR[TTex_Nr] <> TAXI_L)
    ; {
    ; 	TTex_oFSVAR[TTex_Nr] := TAXI_L
    ; 	Err := ToolTipEx("T", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[TAXI_L+3], "BLACK", "", "S")
    ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
    ; }

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

    If (TTex_oFSVAR[TTex_Nr] <> XIVAP_TP)
    {
      TTex_oFSVAR[TTex_Nr] := XIVAP_TP
      Err := ToolTipEx("TP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[XIVAP_TP], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> STD_ON)
    {
      TTex_oFSVAR[TTex_Nr] := STD_ON
      Err := ToolTipEx("STD", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[STD_ON], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> NumLockChar)
    {
      TTex_oFSVAR[TTex_Nr] := NumLockChar
      Err := ToolTipEx("N", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[NumLockChar], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
    }

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

    If (TTex_oFSVAR[TTex_Nr] <> POWER)
    {
      TTex_oFSVAR[TTex_Nr] := POWER
      Err := ToolTipEx(Format("{1:3}",POWER), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "RED", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> ELV_TRIM)
    {
      TTex_oFSVAR[TTex_Nr] := ELV_TRIM
      Err := ToolTipEx(Format("{1:4}",ELV_TRIM), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "RED", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> COM1_ACT_F)
    {
      TTex_oFSVAR[TTex_Nr] := COM1_ACT_F
      Err := ToolTipEx("CA "Format("{1:6}",COM1_ACT_F), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "GREEN", "WHITE", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 9 ) + TTex_FontS
    }

    ++TTex_Nr

    If (TTex_oFSVAR[TTex_Nr] <> COM1_STB_F)
    {
      TTex_oFSVAR[TTex_Nr] := COM1_STB_F
      Err := ToolTipEx("CS "Format("{1:6}",COM1_STB_F), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "GREEN", "WHITE", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 9 ) + TTex_FontS
    }

    ++TTex_Nr

    Err := ToolTipEx("GA "Format("{1:4}",GAlt), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 7) + TTex_FontS

    ; _Message(TD_FLAG, 0)
    If Not TD_FLAG
    {
      ++TTex_Nr

      Err := ToolTipEx("TD "Format("{1:5}",VSPEED_TD), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[1], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8 ) + TTex_FontS

      ; Str :=  " TAS " TAS  

      ; ++TTex_Nr

      ; Err := ToolTipEx(Str, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
      ; TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * StrLen(Str)) + TTex_FontS

    }
    ; Else
    ; {
    Str := "VS " VSPEED "|" HVS_V " HDG " HDG "|" HHDG_V " TAS " TAS 

    ++TTex_Nr

    Err := ToolTipEx(Str, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * StrLen(Str)) + TTex_FontS
    ; }

    ++TTex_Nr
    Err := ToolTipEx(,,,TTex_Nr)

    DEBUG_Write_Statusbar+= 1000
    Return
  }

Aircraft_Scenario:
  {
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

    If ((QALT > 10050) And Land_L)
    {
      Err := _CMD("landing lights off")
    }

    If ((QALT > 9000) And (QALT < 9950) And Not Land_L)
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

    ; ; "PREFLIGHT CHECKLIST" when BEACON goes on
    ; If (BEACON_L And Not PreflightCheck_Ok And PreflightProc_Ok And Not CheckList_Active)
    ; {
    ; Err := _CMD("Preflight Checklist")
    ; }

    ; ; "BEFORE TAXI CHECKLIST"
    ; If (TAXI_L And Not BeforeTaxi_Ok And PreflightCheck_Ok And Not CheckList_Active)
    ; {
    ; 	Err := _CMD("before taxi checklist")
    ; }

    ; "BEFORE TAKE Off CHECKLIST"
    If ((LAND_L) And Not BeforeTakeOff_Ok And BeforeTaxi_Ok And Not CheckList_Active)
    {
      Err := _CMD("before take off checklist")
    }

    ; ; "AFTER TAKE Off CHECKLIST"
    ; If ((FLAPS_V = 0 Or QALT > 4000) And Not AfterTakeOff_Ok And BeforeTakeOff_Ok And Not CheckList_Active)
    ; {
    ; 	If (TAXI_L)
    ; 		Err := _CMD("taxi lights off")

    ; 	Err := _CMD("after take off checklist")
    ; }

    ; damit "BEFORE APPROACH CHECKLIST" klappt
    If (Not PassingFL080)
      PassingFL080 := (QALT > 8000)

    ; ; "BEFORE APPROACH CHECKLIST"
    ; If ((QALT < 8000) And PassingFL080 And Not BeforeApproach_Ok And AfterTakeOff_Ok And Not CheckList_Active)
    ; {
    ; 	Err := _CMD("before approach checklist")
    ; }

    ; ; "BEFORE LANDING CHECKLIST"
    ; If ((FLAPS_V > 1) And Not BeforeLanding_Ok And BeforeApproach_Ok And Not CheckList_Active)
    ; {
    ; 	If (Not TAXI_L)
    ; 		Err := _CMD("taxi lights on")

    ; 	Err := _CMD("before landing checklist")
    ; }

    ; "AFTER LANDING CHECKLIST"
    ; If (PBRAKE And Not AfterLanding_Ok And BeforeLanding_Ok And Not CheckList_Active)
    ; {
    ; 	Err := _CMD("after landing checklist")

    ; 	PassingFL080 := False
    ; }

    ; ; Tempomat :-)
    ; If (TAXI_L And (GS > TempoLow) And (GS < TempoHigh) And Not LAND_L)
    ; {
    ; 	Send {Shift Down}{Ctrl Down}{QALT Down}...{QALT Up}{Shift Up}{Ctrl Up}
    ; 	SoundBeep, 300, 50
    ; }

    ACS_EndTime := A_TickCount - ACS_StartTime
    ACS_Time := ACS_EndTime - RFV_Time - WSB_Time

    DEBUG_Aircraft_Scenario += 1000
    Return
  }

Show_DEBUG_Info:
  {
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
        QALT 	 > %QALT%

        Auto_Baro > %Auto_Baro%
        STD_On > %STD_On%

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
    }

    AIRCRAFT_INIT:
      {
        FileCopy, J:\X-Plane 11\Output\preferences\X-Plane Window Positions_1Mon.prf, J:\X-Plane 11\Output\preferences\X-Plane Window Positions.prf , 1
        ; FileCopy, J:\X-Plane 11\Output\preferences\X-Plane Window Positions_2Mon.prf, J:\X-Plane 11\Output\preferences\X-Plane Window Positions.prf , 1

        Return
      }

      ; -------------------------------------------------------
    JOYSTICK_SECTION:
      ; -------------------------------------------------------
      ; JoyX Wireless Gamepad
      ; 1JoyX Rudder Peddals
      ; 2JoyX Basetech Gamepad
      ; 3JoyX HOTAS (Hands On Throttle And Stick)
      ; -------------------------------------------------------

    3JoyPOV:
    POV:
      {
        Global POV_Step
        Global POV_Value

        POV_Value := GetKeyState("3JoyPOV")	
        if (POV_Value < 0)
          Return

        If GetKeyState("LCtrl")
        {
          POV_Step := 4

          if (POV_Value = 31500) ; Numpad7
          {
            SendInput {q %POV_Step%}{r %POV_Step%}
          }
          else if (POV_Value = 0) ; Numpad8
          {
            SendInput {r %POV_Step%}
          }
          else if (POV_Value = 4500) ; Numpad9
          {
            SendInput {r %POV_Step%}{e %POV_Step%}
          }
          else if (POV_Value = 27000) ; Numbad4
          {
            SendInput {q %POV_Step%}
          }
          else if (POV_Value = 9000) ; Numpad6
          {
            SendInput {e %POV_Step%}
          }
          else if (POV_Value = 22500) ; Numpad1
          {
            SendInput {q %POV_Step%}{f %POV_Step%}
          }
          else if (POV_Value = 18000) ;Numpad2
          {
            SendInput {f %POV_Step%}
          }
          else if (POV_Value = 13500) ; Numpad3
          {
            SendInput {f %POV_Step%}{e %POV_Step%}
          }

          Return
        }

        If ((Aktu_Screen = 7) OR (Aktu_Screen = 9))
        {
          POV_Step := 1
          Send {Shift Down}

          if (POV_Value = 31500) ; Numpad7
          {
            SendInput {Up %POV_Step%}{Left %POV_Step%}
          }
          else if (POV_Value = 0) ; Numpad8
          {
            Send {Up %POV_Step%}
          }
          else if (POV_Value = 4500) ; Numpad9
          {
            Send {Up %POV_Step%}{Right %POV_Step%}
          }
          else if (POV_Value = 27000) ; Numbad4
          {
            Send {Left %POV_Step%}
          }
          else if (POV_Value = 9000) ; Numpad6
          {
            Send {Right %POV_Step%}
          }
          else if (POV_Value = 22500) ; Numpad1
          {
            Send {Down %POV_Step%}{Left %POV_Step%}
          }
          else if (POV_Value = 18000) ;Numpad2
          {
            Send {Down %POV_Step%}
          }
          else if (POV_Value = 13500) ; Numpad3
          {
            Send {Down %POV_Step%}{Right %POV_Step%}
          }

          Send {Shift Up}

          Return
        }

        if (POV_VALUE = 31500) ; Numpad7
        {
          If (Aktu_Screen <> 7)
            Gosub Screen7

          ; _Message("7-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 0) ; Numpad8
        {
          If (Aktu_Screen <> 8)
            Gosub Screen8

          ; _Message("8-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 4500) ; Numpad9
        {
          If (Aktu_Screen <> 9)
            Gosub Screen9

          ; _Message("9-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 27000) ; Numbad4
        {
          If (Aktu_Screen <> 4)
            Gosub Screen4

          ; _Message("4-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 9000) ; Numpad6
        {
          If (Aktu_Screen <> 6)
            Gosub Screen6

          ; _Message("6-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 22500) ; Numpad1
        {
          If (Aktu_Screen <> 1)
            Gosub Screen1

          ; _Message("1-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 18000) ;Numpad2
        {
          If (Aktu_Screen <> 2)
            Gosub Screen2

          ; _Message("2-" Aktu_Screen, 0)
        }
        else if (POV_VALUE = 13500) ; Numpad3
        {
          If (Aktu_Screen <> 3)
            Gosub Screen3

          ; _Message("3-" Aktu_Screen, 0)
        }

        Return
      }

    3Joy01_CheckitemOk:
      ; 3Joy1:: ; HOTAS _Joy_HM
      {
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

    3Joy03_SpeechOn:
      ; 3Joy3:: ; HOTAS_Joy_RH
      {
        ; Zoom in -> in P3D configuriert
        Return
      }

    3Joy04_ATC:
      ; 3Joy4:: ; HOTAS_Joy_RV
      {
        ; Zoom out -> in P3D configuriert
        Return
      }

    3Joy05_VS_Down:
    3Joy5:: ; HOTAS_Thrust_HO/ XPlane
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {Ctrl Down}{NumpadPgup}{Ctrl Up}

        ; If HVS
        ; 	Send {Ctrl Down}{NumpadPgup}{Ctrl Up}
        ; Else
        ; {
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int,  0x0BC0, int, 2, short, &TRIM, int, &dwResult)
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
        ; 	TRIM := NumGet(&TRIM, 0, "short")

        ; 	TRIM := TRIM + 164
        ; 	NumPut(TRIM, TRIM, 0, "short")
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
        ; 	Sleep, 100
        ; }

        Return
      }

    3Joy06_VS_Up:
    3Joy06:: ; HOTAS_Thrust_HU
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {Ctrl Down}{NumpadPgdn}{Ctrl Up}

        ; If HVS
        ; 	Send {Ctrl Down}{NumpadPgdn}{Ctrl Up}
        ; Else
        ; {
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int,  0x0BC0, int, 2, short, &TRIM, int, &dwResult)
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
        ; 	TRIM := NumGet(&TRIM, 0, "short")

        ; 	TRIM := TRIM - 164
        ; 	NumPut(TRIM, TRIM, 0, "short")
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
        ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
        ; 	Sleep, 100
        ; }
        Return
      }

    3Joy07_AP_HoldVerticalSpeed:
    3Joy7:: ; HOTAS_Thrust_RU
      {
        x := 0
        While GetKeyState("3Joy7")
        {
          x := x + 1
          Sleep, ButtonWait_Delay

          If x = 10
          {
            ; TRIM := 8 * 164
            ; NumPut(TRIM, TRIM, 0, "short")
            ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
            ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

            ; Err := _Text_to_Speech("take off trim")

            Err := _CMD("hold vertical speed")
            Return
          }
        }
        If AP
          Err := _CMD("autopilot off")
        Else
          Err := _CMD("autopilot on")
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
            Gosub Screen7
            Return
          }
        }

        Gosub Screen9
        Return
      }

    3Joy09_HoldAltitude_HoldVerticalSpeed:
    3Joy9:: ; HOTAS_Thrust_RM
      {
        x := 0
        While GetKeyState("3Joy9")
        {
          x := x + 1
          Sleep, ButtonWait_Delay

          If x = 10
          {
            Err := _CMD("hold vertical speed")
            Return
          }
        }

        Err := _CMD("hold altitude")

        Return
      }

    3Joy10_HoldHeading_HoldNavigation: ; 3Joy05_TrimUp:
    3Joy10:: ; HOTAS_Thrust_RO
      {
        x := 0
        While GetKeyState("3Joy10")
        {
          x := x + 1
          Sleep, ButtonWait_Delay

          If x = 10
          {
            Err := _CMD("hold navigation")
            Return
          }
        }

        Err := _CMD("hold heading")

        Return
      }

    3Joy11_ParkingBrake_Gear:
    3Joy11:: ; HOTAS_Thrust_UL/ XPlane
      {
        ; Parking Brake
        Return
      }

    3Joy12_TPstandby_Autostart:
    3Joy12:: ; HOTAS _Thrust_UR
      {
        Err := _CMD("autostart")
        Return
      }

    4Joy1_:
    4Joy1::
      {
        _Message("4Joy1", 3)
        Return
      }	
    4Joy2_:
    4Joy2::
      {
        _Message("4Joy2", 3)
        Return
      }	
    4Joy3_:
    4Joy3::
      {
        _Message("4Joy3", 3)
        Return
      }	
    4Joy4_:
    4Joy4::
      {
        _Message("4Joy4", 3)
        Return
      }	
    4Joy5_:
    4Joy5::
      {
        _Message("4Joy5", 3)
        Return
      }	
    4Joy6_:
    4Joy6::
      {
        _Message("4Joy6", 3)
        Return
      }	

    4Joy7_Speech:
    4Joy7::
      {
        _Message("4Joy7", 3)
        Return
      }	
    4Joy8_ATC:
    4Joy8::
      {
        _Message("4Joy8", 3)
        Return
      }	
    4Joy9_Cecklist_OK:
    4Joy9::
      {
        _Message("4Joy9", 3)
        Return
      }	

    4Joy10_OBS_HSI_down:
    4Joy10::
      {
        Send {Ctrl Down}{Alt Down}{NumpadLeft 10}{Ctrl Up}{Alt Up}
        ; _Message("OBS HSI down", 0)
        Return
      }	
    4Joy11_OBS_HSI_up:
    4Joy11::
      {
        Send {Ctrl Down}{Alt Down}{NumpadRight 10}{Ctrl Up}{Alt Up}
        ; _Message("OBS HSI up", 0)
        Return
      }

    4Joy12_Speed_down:
    4Joy12::
      {
        Send {Ctrl Down}{NumpadEnd}{Ctrl Up}
        ; _Message("speed down", 0)
        Return
      }	
    4Joy13_Speed_up:
    4Joy13::
      {
        Send {Ctrl Down}{NumpadHome}{Ctrl Up}
        ; _Message("speed up", 0)
        Return
      }

    4Joy14_Heading_down:
    4Joy14::
      {
        Send {Ctrl Down}{NumpadLeft 5}{Ctrl Up}
        Send {Ctrl Down}{NumpadLeft 5}{Ctrl Up}
        ; _Message("Heading down", 0)
        Return
      }	
    4Joy15_Heading_up:
    4Joy15::
      {
        Send {Ctrl Down}{NumpadRight 5}{Ctrl Up}
        Send {Ctrl Down}{NumpadRight 5}{Ctrl Up}
        ; _Message("Heading up", 0)
        Return
      }

    4Joy16_Altitude_down:
    4Joy16::
      {
        Send {Ctrl Down}{NumpadDown}{Ctrl Up}

        ; x := 0
        ; while x < 7
        ; {
        ; 	x += 1
        ; 	Send {Ctrl Down}{NumpadDown }{Ctrl Up}
        ; 	sleep, 200
        ; }

        ; _Message("Altitude down", 0)
        Return
      }	

    4Joy17_Altitude_up:
    4Joy17::
      {
        Send {Ctrl Down}{NumpadUp}{Ctrl Up}
        ; _Message("Altitude up", 0)
        Return
      }

    4Joy18_VS_down:
    4Joy18::
      {
        Send {Ctrl Down}{NumpadPgdn}{Ctrl Up}
        ; _Message("speed down", 0)
        Return
      }	
    4Joy19_VS_up:
    4Joy19::
      {
        Send {Ctrl Down}{NumpadPgup}{Ctrl Up}
        ; _Message("speed up", 0)
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

    Screen7:
    $NumpadHome:: ; Numpad7
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadHome}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 7
        Return
      }

    Screen8:
    $NumpadUp:: ; Numpad8
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadUp}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 8
        Return
      }

    Screen9:
    $NumpadPgUp:: ; Numpad9
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadPgUp}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 9
        Return
      }

    Screen4:
    $NumpadLeft:: ; Numpad4
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadLeft}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 4
        Return
      }

    Screen5:
    $NumpadClear:: ; Numpad5
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadClear}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 5
        Return
      }

    Screen6:
    $NumpadRight:: ; Numpad6
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadRight}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 6
        Return
      }

    Screen1:
    $NumpadEnd:: ; Numpad1
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadEnd}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 1
        Return
      }

    Screen2:
    $NumpadDown:: ; Numpad2
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadDown}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 2
        Return
      }

    Screen3:
    $NumpadPgDn:: ; Numpad3
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadPgDn}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 3
        Return
      }

    Screen0:
    $NumpadIns:: ; Numpad0:
      {
        WinActivate, ahk_class %Aktu_Sim%
        Send {NumpadIns}
        Last_Screen := Aktu_Screen
        Aktu_Screen := 0
        Return
      }

    ScreenDel:
    $NumpadDel:: ; NumpadDel
      {
        ; WinActivate, %Aktu_Sim%
        WinActivate, ahk_class %Aktu_Sim%
        Send {Ctrl Down}w{Ctrl Up} ; no panel

        ; CoordMode, Mouse, Screen
        ; Click,right, 1919,35
        ; MouseMove, 1930,5,0
        Return
      }
