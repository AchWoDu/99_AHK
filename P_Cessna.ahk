P_Cessna_2022_05_08:

DEV_VARS:
  Global TEST := False Or True ; Keine Programme starten
  Global DEBUG := False ; Or True ; Debug anzeigen

  Global Aktu_Sim := "Lockheed Martin® Prepar3D® v4"
  Global Aktu_Scenario := "Cessna" ; zum suchen in Load Scenario
  Global CMD_File := "P_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "P_" Aktu_Scenario "_CMD.txt"
  ; Global SkipUAC := "SkipUAC_M_" Aktu_Scenario ; wird nicht mehr benötigt da SkipUAC := "SkipUAC_StartAircraft"

  ; Sprachbefehl Anzeigen
  Global x_Versatz := 0 ;+1920 ; -1920 <- 0 -> +1920
  Global y_Versatz := 0

  ; Status-Bar und Checklist_ITEM (ToolTip 11..n und 3)
  Global TTex_xVersatz := 348 ;+1920 ; -1920 <- 0 -> +1920
  Global TTex_yVersatz := 0

  Global CheckOK_Break := True ; wenn auch bei CecklistBreak die Checliste ok ist
  Global STD_On := False ; Wenn Baro STD gesetzt

  Global ANZ_Flaps := 3
  Global STR_Flaps := ["FUP","F10","F20","F30"]

  Global TRIM := 0 ; Temp VAR für Trim up/down

  #Include %A_ScriptDir%\Common.ahk
Return

CMD_Process:
  {
    DEBUG_CMD_Process++

    Critical ,On

    CP_StartTime := A_TickCount

    SetTimer, CMD_Process, Off

    WinActivate, %Aktu_Sim%

    If (CMD_Text="?")
    {
      ; Err := _Text_to_Speech(CMD_Text)
    }
    ;
    ; Views
    ;
    Else If (CMD_Text="G P S")
    {
      Send {Shift Down}1{Shift Up}
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
    Else If (CMD_Text="autopilot on")
    {
      If Not AP
      {
        Send z
        ; If HHDG
        ; Send ^h

        ; If HNAV
        ; Send ^n

        ; if HALT
        ; Send ^z

        Err := _Text_to_Speech(CMD_Text)
      }
      Else
        Err := _Text_to_Speech("start autopilot first")

    }
    Else If (CMD_Text="autopilot off")
    {
      If AP
      {
        Send z
        sleep, 300
        If HHDG
        {
          HHDG := ""
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C8, uint, 4, uint, &HHDG, uint, &dwResult)
          Send ^h
        }

        If HNAV
        {
          HNAV := ""
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C4, uint, 4, uint, &HNAV, uint, &dwResult)
          ; Send ^n
        }

        if HALT
        {
          HALT := ""
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07D0, uint, 4, uint, &HALT, uint, &dwResult) ; Hold Altitude set
          Send ^z
        }

        Err := _Text_to_Speech(CMD_Text)
      }
      Else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="hold heading")
    {
      ; Send ^h
      If AP
      {
        If HHDG
        {
          IF HNAV
          {
            HNAV := ""
            Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C4, uint, 4, uint, &HNAV, uint, &dwResult)

          }
          Else
          {
            HHDG := ""
            Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C8, uint, 4, uint, &HHDG, uint, &dwResult)
          }
        }
        Else
        {
          HNAV := ""
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C4, uint, 4, uint, &HNAV, uint, &dwResult)
          HHDG := 1
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C8, uint, 4, uint, &HHDG, uint, &dwResult)
        }

        ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="hold navigation")
    {
      If AP
      {
        if HNAV
          HNAV := ""
        Else
          HNAV := 1
        Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07C4, uint, 4, uint, &HNAV, uint, &dwResult)

        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="hold vertical speed")
    {
      If AP
      {
        if HALT
          HALT := ""
        Else
          HALT := 1

        Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07D0, uint, 4, uint, &HALT, uint, &dwResult) ; Hold Altitude set
        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="hold altitude")
    {
      If AP
      {
        if HALT
          HALT := ""
        Else
          HALT := 1

        Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x07D0, uint, 4, uint, &HALT, uint, &dwResult) ; Hold Altitude set
        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="armed altitude")
    {
      If AP
      {
        Send {Ctrl Down}{Alt Down}w{Alt Up}{Shift Up}{Ctrl Up} ; LUA
        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="hold approach")
    {
      If AP
      {
        Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up}
        Err := _Text_to_Speech(CMD_Text)
      }
      else
        Err := _Text_to_Speech("start autopilot first")
    }
    Else If (CMD_Text="GPS navigation on")
    {
      Send {Shift Down}{Ctrl Down}n{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="GPS navigation off")
    {
      Send {Shift Down}{Ctrl Down}n{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    ;
    ; Controls
    ;
    Else If (CMD_Text="synchronised heading")
    {
      Send {Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up} ; LUA
      ; Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="take off trim")
    {
      Send {Ctrl Down}{Alt Down}y{Alt Up}{Shift Up}{Ctrl Up} ; LUA
      ; Err := _Text_to_Speech(CMD_Text)
    }
    ; Else If (CMD_Text="winglevler off")
    ; {
    ; Send {Ctrl Down}v{Alt Up}{Shift Up}{Ctrl Up}
    ; }
    Else If (CMD_Text="flaps 10")
    {
      Send {F5}{F7}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="flaps 20")
    {
      Send {F5}{F7}{F7}
      Err := _Text_to_Speech(CMD_Text)
    }
    ;
    ; Lights
    ;
    Else If (CMD_Text="beacon lights on") ; TODO:
    {
      ; Send {Shift Down}{Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
      ; Err := _Text_to_Speech(CMD_Text)
      Err := _Text_to_Speech("Not implemented!")
    }
    Else If (CMD_Text="beacon lights off") ; TODO:
    {
      ; Send {Shift Down}{Ctrl Down}{Alt Down}b{Alt Up}{Shift Up}{Ctrl Up}
      ; Err := _Text_to_Speech(CMD_Text)
      Err := _Text_to_Speech("Not implemented!")
    }
    Else If (CMD_Text="taxi lights on")
    {
      ; LUA Function
      Send {Shift Down}{Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="taxi lights off")
    {
      ; LUA Function
      Send {Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="landing lights on")
    {
      If Not Land_L
        ;	Send {Shift Down}{Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Send {Ctrl Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="landing lights off")
    {
      If Land_L
        ;	Send {Shift Down}{Ctrl Down}{Alt Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Send {Ctrl Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe lights on")
    {
      If Not STROBE_L
        ;	Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}s{Shift Up}{Ctrl Up}
      Send {Shift Down}{Ctrl Down}s{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe lights off")
    {
      If STROBE_L
        ;	Send {Shift Down}{Ctrl Down}{Alt Down}s{Alt Up}s{Shift Up}{Ctrl Up}
      Send {Shift Down}{Ctrl Down}s{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe and landing lights on")
    {
      If Not STROBE_L
        Send {Shift Down}{Ctrl Down}s{Alt Up}{Shift Up}{Ctrl Up}
      If Not Land_L
        Send {Ctrl Down}l{Alt Up}{Shift Up}{Ctrl Up}
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="strobe and landing lights off")
    {
      If STROBE_L
        Send {Shift Down}{Ctrl Down}s{Alt Up}{Shift Up}{Ctrl Up}
      If Land_L
        Send {Ctrl Down}l{Alt Up}{Shift Up}{Ctrl Up}
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
    ; Else If (CMD_Text="stop timer")
    ; {
    ; Send {Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _Text_to_Speech(CMD_Text)
    ; }
    Else If (CMD_Text="baro standard")
    {
      Auto_Baro := True
      If Not STD_On
        Send {Shift Down}{Ctrl Down}b{Shift Up}{Shift}{Ctrl Up}
      STD_On := True
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="baro QNH")
    {
      Auto_Baro := False
      If STD_On
        Send b
      STD_On := False
      Err := _Text_to_Speech(CMD_Text)
    }
    Else If (CMD_Text="reload lua")
    {
      Send {Ctrl Down}{Shift Down}9{Shift Up}{Ctrl Up}	
      Err := _Text_to_Speech(CMD_Text)
    }
    ;
    #Include %A_ScriptDir%\Common_CMD_P3D.ahk
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
      ; If _Is_CheckItem("Check if hold heading and vertical speed armed!")
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
      If _Is_CheckItem("Is heading synchronised?")

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

    ; If _Is_CheckItem("Check if the flaps full up!")
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
      Global AC_TYPE 	:= 0x3D00
      Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AC_TYPE, int, 14, char, &AC_TYPE, int, &dwResult)
    }

    Global ELV_TRIM := 0x0BC0 ; ELEVATOR Trimmung in %
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, ELV_TRIM, int, 2, short, &ELV_TRIM, int, &dwResult)

    Global POWER := 0 ; Power in %
    ; Global POWER := 0x088c ; Power in %
    ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, POWER, int, 2, short, &POWER, int, &dwResult)

    Global GEAR 	:= 0x0BE8 ; Gear
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GEAR, int, 4, int, &GEAR, int, &dwResult)

    Global GS 		:= 0x02B4 ; Ground Speed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GS, int, 4, int, &GS, int, &dwResult)

    Global TAS 		:= 0x02B8 ; True Airspeed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TAS, int, 4, int, &TAS, int, &dwResult)

    Global IAS 		:= 0x02BC ; indicatet Airspeed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, IAS, int, 4, int, &IAS, int, &dwResult)

    Global VSPEED 	:= 0x02C8 ; Vertical Speed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, VSPEED, int, 4, int, &VSPEED, int, &dwResult)

    Global VSPEED_TD := 0x030C ; Touchdown Rate Vertical Speed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, VSPEED_TD, int, 4, int, &VSPEED_TD, int, &dwResult)

    Global TD_FLAG 	:= 0x0366 ; Touchdown Flag
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, TD_FLAG, int, 2, short, &TD_FLAG, int, &dwResult)

    Global QALT 	:= 0x0574 ; Altitude basierend auf QNH in feet (High Bytes)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, QALT, int, 4, int, &QALT, int, &dwResult)

    Global GALT 	:= 0x0B4C ; Ground Altitude
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, GALT, int, 2, short, &GALT, int, &dwResult)

    Global HDG 		:= 0x0580 ; Heading
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HDG, int, 4, uint, &HDG, int, &dwResult)

    Global PBRAKE 	:= 0x0BC8 ; parking brake
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", "int", PBRAKE, "int", 2, "short", &PBRAKE, "int", &dwResult)

    ; Global PUSHBACK :=0x31f0 ; Pushback Status
    ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, PUSHBACK, int, 4, int, &PUSHBACK, int, &dwResult)

    Global FLAPS 	:= 0x0BDC ; Klappenstellung als Wert von 100%
    Global FLAPS_V := 999 ; Klappenstellung als Nr
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FLAPS, int, 4, int, &FLAPS, int, &dwResult)

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

    ; Standard VARs convert

    If AC_TYPE_read
    {
      ; Zkette := StrGet(Quelle [, Länge] [, Codierung := Keine])
      AC_TYPE := StrGet(&AC_TYPE+4, 4, "UTF-8") ; C182

      If (AC_TYPE = "C182")
        {}
      Else
      {
        _Error_Message("AC_TYPE: C182 ->" AC_TYPE "<", 6)
        AC_TYPE := "????"
      }

      AC_TYPE_read := False
    }

    ELV_TRIM := ceil(NumGet(&ELV_TRIM, 0, "short") / 164) ; 100/ 16383
    ; ELV_TRIM := NumGet(&ELV_TRIM, 0, "short") / 164 ; 16383/100
    ; _Message(ELV_TRIM,0)

    POWER := ceil(GetKeyState("4JoyZ"))
    ; _Message(POWER,0)

    GEAR := NumGet(&GEAR, 0, "int") == 16383

    GS 	:= round(NumGet(&GS, 0, "int") / 65536 / 1000 * 3600) ; Ground Speed in km/h
    TAS := round(NumGet(&TAS, 0, "int") / 128) ; True Air Speed in Kn
    IAS := round(NumGet(&IAS, 0, "int") / 128) ; Indicated Air Speed in Kn

    VSPEED 	:= round(NumGet(&VSPEED, 0, "int") * 60 * 3.28084 / 256) ; Vertical Speed ft/ min
    VSPEED_TD := round(NumGet(&VSPEED_TD, 0, "int") * 60 * 3.28084 / 256) ; Touch down VSpeed  ft/ min
    TD_FLAG	:= Not (NumGet(&TD_FLAG, 0, "short") > 0) ; Touch down flag

    QALT := round(NumGet(&QALT, 0, "int") * 3.28) ; von Meter in Fuss umrechenen
    GALT := round(QALT - NumGet(&GALT, 0, "short") * 3.28) ; von Meter in Fuss umrechenen

    HDG	:= round(NumGet(&HDG, 0, "uint") * 360 / (65536*65536))

    PBRAKE := NumGet(&PBRAKE, 0, "short") >= 22936

    ; PUSHBACK 	:= NumGet(&PUSHBACK, 0, "int")

    FLAPS := NumGet(&FLAPS, 0, "int")
    ; FLAPS_V	:= round(FLAPS / (16382/ANZ_Flaps)) ; ?= Anzahl Flaps
    FLAPS := FLAPS > 0

    ; P3D Com Radios and Transponder read

    Global IVAP_TP		:= 0x7B91 ; !!! IVAP Transponder
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, IVAP_TP, int, 1, short, &IVAP_TP, int, &dwResult)

    Global COM1_STB_F 	:= 0x311A
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_STB_F, int, 2, short, &COM1_STB_F, int, &dwResult)

    Global COM2_STB_F 	:= 0x311C
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_STB_F, int, 2, short, &COM2_STB_F, int, &dwResult)

    Global COM1_ACT_F 	:= 0x034E
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_ACT_F, int, 2, short, &COM1_ACT_F, int, &dwResult)

    Global COM2_ACT_F 	:= 0x3118
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_ACT_F, int, 2, short, &COM2_ACT_F, int, &dwResult)

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

    ; P3D Com Radios and Transponder convert

    IVAP_TP 	:= NumGet(&IVAP_TP, 0, "short") = 0

    COM1_STB_F := Format("{1:6x}", (NumGet(COM1_STB_F, 0, "short") * 0x10 + 0x100000))
    COM2_STB_F := Format("{1:6x}", (NumGet(COM2_STB_F, 0, "short") * 0x10 + 0x100000))
    COM1_ACT_F := Format("{1:6x}", (NumGet(COM1_ACT_F, 0, "short") * 0x10 + 0x100000))
    COM2_ACT_F := Format("{1:6x}", (NumGet(COM2_ACT_F, 0, "short") * 0x10 + 0x100000))

    ; Alle GA Flieger- VARs read

    Global FD 		:= 0x2EE0 ; Flight Director
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FD, int, 4, int, &FD, int, &dwResult)

    Global AT 		:= 0x0810 ; Autothrottel ARM
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AT, int, 4, int, &AT, int, &dwResult)

    Global AP 		:= 0x07BC ; Autopilot
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AP, int, 4, int, &AP, int, &dwResult)

    Global HNAV 	:= 0x07C4 ; Hold Navigaton
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HNAV, int, 4, int, &HNAV, int, &dwResult)
    Global HNAV1_V 	:= 0x0C4E ; NAV1 OBS setting (degrees, 0–359)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HNAV1_V, int, 2, short, &HNAV1_V, int, &dwResult)

    Global HHDG 	:= 0x07C8 ; Hold Heading
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HHDG, int, 4, int, &HHDG, int, &dwResult)
    Global HHDG_V 	:= 0x07CC ; Heading als Value in °
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HHDG_V, int, 2, short, &HHDG_V, int, &dwResult)

    Global HALT 	:= 0x07D0 ; Hold Altitude
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HALT, int, 4, int, &HALT, int, &dwResult)

    Global HVS 		:= 0x07EC ; Hold Vertical Speed
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HVS, int, 4, int, &HVS, int, &dwResult)
    Global HVS_V 	:= 0x07F2 ; Hold Vertical Speed als Value in feet/ min
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HVS_V, int, 2, short, &HVS_V, int, &dwResult)

    Global HAPP 	:= 0x0800 ; Hold Approach
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HAPP, int, 4, int, &HAPP, int, &dwResult)

    Global HGPS 	:= 0x132C ; Hold GPS
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, HGPS, int, 4, int, &HGPS, int, &dwResult)

    Global LIGHTS 	:= 0x0D0C
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
    HHDG_V	:= NumGet(&HHDG_V, 0, "short") * 360 / 65536

    HALT := NumGet(&HALT, 0, "int") > 0

    HVS		:= NumGet(&HVS, 0, "int") > 0
    HVS_V 	:= NumGet(&HVS_V, 0, "short")

    HAPP := NumGet(&HAPP, 0, "int") > 0
    HGPS := NumGet(&HGPS, 0, "int") > 0

    ; Lights

    ; 0 = Navigatin / 2 = Beacon/ 4 = Landing / 8 = Taxi / 16 = Strobe / 32 = Instruments / 64 = Recognition / 128 = Wing
    ; Airbus: LANDING = 4 / NOSE/ TAXI = 8 / STROBE = 16 / WING = 128 / NAV = 256

    LIGHTS 	:= NumGet(&LIGHTS, 0, "short")
    NAVIGATION_L:= (LIGHTS & 1) == 1
    BEACON_L	:= (LIGHTS & 2) == 2
    TAXI_L		:= (LIGHTS & 8) == 8
    STROBE_L	:= (LIGHTS & 16) == 16
    LAND_L		:= (LIGHTS & 4) == 4

    ; A2A Cessna VARs read

    Global FLAPS_V := 0x5400
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FLAPS_V, int, 4, int, &FLAPS_V, uint, &dwResult)

    ; Global TP := 0x5404 ; Transponder
    ; Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, Global TP, int, 4, int, &TP, int, &dwResult) ; Transponder

    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)

    ; A2A Cessna VARs convert

    transform, FLAPS_V, Asc, %FLAPS_V%
    If (FLAPS_V < 1)
      FLAPS_V := 0

    ; transform, TP, Asc, %TP%
    ; If TP > 0
    ; TP := 1
    ; Else	TP := 0

    DEBUG_Read_FS_VARS += 1000
    Return Err
  }

Write_Statusbar:
  {
    DEBUG_Write_Statusbar++

    GetKeyState, NumLState ,NumLock, T ; NUM State

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

    If (TTex_oFSVAR[TTex_Nr] <> HGPS)
    {
      TTex_oFSVAR[TTex_Nr] := HGPS
      Err := ToolTipEx("GPS", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HGPS], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    }

    ++TTex_Nr

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

    If (TTex_oFSVAR[TTex_Nr] <> HVS) ; AKI:
    {
      TTex_oFSVAR[TTex_Nr] := HVS
      Err := ToolTipEx("!VS", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HVS], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
    }

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

    ++TTex_Nr

    Err := ToolTipEx("GA "Format("{1:4}",GAlt), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 7) + TTex_FontS

    ; _Message(TD_FLAG, 0)

    If Not TD_FLAG
    {
      ++TTex_Nr

      Err := ToolTipEx("TD "Format("{1:5}",VSPEED_TD), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[1], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8 ) + TTex_FontS

      Str := " TAS " TAS 

      ++TTex_Nr

      Err := ToolTipEx(Str, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
    }
    Else
    {
      ; If HVS ; wenn vertical speed
      ; {		
      ; 	++TTex_Nr

      ; 	Err := ToolTipEx("f/m "Format("{1:4}",HVS_V), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "RED", "WHITE", "", "S")
      ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8) + TTex_FontS
      ; }
      ; Else
      ; {
      ; 	++TTex_Nr

      ; 	Err := ToolTipEx("f/m "Format("{1:4}",HVS_V), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "WHITE", "BLACK", "", "S")
      ; 	TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8) + TTex_FontS
      ; }

      Str := "VS " VSPEED "|" HVS_V " HDG " HDG "|" HHDG_V " TAS " TAS 

      ++TTex_Nr

      Err := ToolTipEx(Str, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS

      ++TTex_Nr
      Err := ToolTipEx(,,,TTex_Nr)
    }

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
      _Message("Read FSV Error", 0)
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

    ; "BEFORE TAXI CHECKLIST"
    If (TAXI_L And Not BeforeTaxi_Ok And PreflightCheck_Ok And Not CheckList_Active)
    {
      Err := _CMD("before taxi checklist")
    }

    ; "BEFORE TAKE Off CHECKLIST"
    If (LAND_L And Not BeforeTakeOff_Ok And BeforeTaxi_Ok And Not CheckList_Active)
    {
      Err := _CMD("before take off checklist")
    }

    ; "AFTER TAKE Off CHECKLIST"
    If ((FLAPS_V = 0) And Not AfterTakeOff_Ok And BeforeTakeOff_Ok And Not CheckList_Active)
    {
      If (TAXI_L)
        Err := _CMD("taxi lights off")

      Err := _CMD("after take off checklist")
    }

    ; damit "BEFORE APPROACH CHECKLIST" klappt
    If (Not PassingFL080)
      PassingFL080 := (QALT > 8000)

    ; "BEFORE APPROACH CHECKLIST"
    If ((QALT < 8000) And PassingFL080 And Not BeforeApproach_Ok And AfterTakeOff_Ok And Not CheckList_Active)
    {
      Err := _CMD("before approach checklist")
    }

    ; "BEFORE LANDING CHECKLIST"
    If ((FLAPS_V > 1) And Not BeforeLanding_Ok And BeforeApproach_Ok And Not CheckList_Active)
    {
      If (Not TAXI_L)
        Err := _CMD("taxi lights on")

      Err := _CMD("before landing checklist")
    }

    ; "AFTER LANDING CHECKLIST"
    If (PBRAKE And Not AfterLanding_Ok And BeforeLanding_Ok And Not CheckList_Active)
    {
      Err := _CMD("after landing checklist")

      PassingFL080 := False
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
    }

    AIRCRAFT_INIT:
      {
        Return
      }

      _POV_Send(Screen)
      {
        WinActivate, %Aktu_Sim%

        If Not (Aktu_Screen = Screen)
        {
          Send %Screen%
          Last_Screen := Aktu_Screen
          Aktu_Screen := Screen
        }

        Return Aktu_Screen
      }

      _NUMPAD_Send(Screen)
      {
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
        ; Brake in P3D
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

        If HVS
          Send {Ctrl Down}{NumpadPgup}{Ctrl Up}
        Else
        {
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
          TRIM := NumGet(&TRIM, 0, "short")

          TRIM := TRIM + 164
          NumPut(TRIM, TRIM, 0, "short")
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
          Sleep, 100
        }

        Return
      }

    3Joy06_VS_Up:
    3Joy06:: ; HOTAS_Thrust_HU
      {
        If HVS
          Send {Ctrl Down}{NumpadPgdn}{Ctrl Up}
        Else
        {
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
          TRIM := NumGet(&TRIM, 0, "short")

          TRIM := TRIM - 164
          NumPut(TRIM, TRIM, 0, "short")
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC0, int, 2, short, &TRIM, int, &dwResult)
          Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
          Sleep, 100
        }

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
            Send 7
            Aktu_Screen := 7
            Return
          }
        }

        Send 9
        Aktu_Screen := 9
        Return
      }

    3Joy9_FlapsStepUp:
    3Joy9:: ; HOTAS_Thrust_HO
      {
        Err := _CMD("flaps step up")
        Return
      }

    3Joy10_FlapsStepDown:
    3Joy10:: ; HOTAS_Thrust_HU
      {
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

    3Joy12_TPstandby_Autostart:
    3Joy12:: ; HOTAS _Thrust_UR
      {
        x := 0
        While GetKeyState("3Joy12")
        {
          x := x + 1
          Sleep, ButtonWait_Delay

          If x = 10
          {
            Err := _CMD("autostart")
            Return
          }
        }	

        Err := _CMD("transponder mode standby")
        Err := _CMD("strobe and landing lights off")
        Err := _CMD("flaps full up")
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

      ; 4Joy7_Speech:
      ; 4Joy7::
      ; {
      ; 	_Message("4Joy7", 3)
      ; 	Return
      ; }	
      ; 4Joy8_ATC:
      ; 4Joy8::
      ; {
      ; 	_Message("4Joy8", 3)
      ; 	Return
      ; }	
      ; 4Joy9_Cecklist_OK:
      ; 4Joy9::
      ; {
      ; 	_Message("4Joy9", 3)
      ; 	Return
      ; }	

    4Joy10_Course_down:
    4Joy10::
      {
        Send {Ctrl Down}{Numpad1}{Ctrl Up}
        _Message("Course down", 0)
        Return
      }	
    4Joy11_Course_up:
    4Joy11::
      {
        _Message("Course up", 0)
        Return
      }

    4Joy12_Speed_down:
    4Joy12::
      {
        Send {Ctrl Down}{Numpad1}{Ctrl Up}
        ; _Message("speed up", 0)
        Return
      }	
    4Joy13_Speed_up:
    4Joy13::
      {
        Send {Ctrl Down}{Numpad7}{Ctrl Up}
        ; _Message("speed down", 0)
        Return
      }

    4Joy14_Heading_down:
    4Joy14::
      {
        Send {Ctrl Down}{Numpad4}{Ctrl Up}
        ; _Message("Hading down", 0)
        Return
      }	
    4Joy15_Heading_up:
    4Joy15::
      {
        Send {Ctrl Down}{Numpad6}{Ctrl Up}
        ; _Message("Heading up", 0)
        Return
      }

    4Joy16_Altitude_down:
    4Joy16::
      {
        Send {Ctrl Down}{Numpad2}{Ctrl Up}
        ; _Message("speed up", 0)
        Return
      }	
    4Joy17_Altitude_up:
    4Joy17::
      {
        Send {Ctrl Down}{Numpad8}{Ctrl Up}
        ; _Message("speed down", 0)
        Return
      }

    4Joy18_VS_down:
    4Joy18::
      {
        Send {Ctrl Down}{Numpad3}{Ctrl Up}
        ; _Message("speed up", 0)
        Return
      }	
    4Joy19_VS_up:
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
        ; Err := _CMD("reset view")
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
      ;	-	  -	    -    -		ok nutzbar in P3D+LUA	Views
      ;	x	  -	    -    -		ok ./. in P3D
      ;	-	  x	    -    -		ok nutzbar in P3D+LUA	Speed/Heading/feet
      ;	x	  x	    -    -		ok ./. in P3D
      ;	-	  -	    x    -		ok ./. in P3D
      ;	x	  -	    x    -		ok ./. in P3D4
      ;	-	  x	    x    -		ok ./. in P3D 
      ;	x	  x	    x    -		ok ./. in P3D 
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
