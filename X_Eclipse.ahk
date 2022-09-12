Eclipse_2022_09_11:

DEV_VARS:
  Global TEST := False ;Or True ; Keine Programme starten
  Global DEBUG := False ;Or True ; Debug anzeigen

  Global Aktu_Sim := "X-System"
  Global Aktu_Scenario := "Eclipse" ; zum suchen in Load Scenario
  Global CMD_File := "X_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "X_" Aktu_Scenario "_CMD.txt"

  ; Sprachbefehl Anzeigen
  Global x_Versatz := 0 ; -1920 <- 0 -> +1920
  Global y_Versatz := 0

  ; Status-Bar und Checklist_ITEM (ToolTip 11..n und 3)
  Global TTex_xVersatz := 500 ; -1920 <-  0  -> +1920
  Global TTex_yVersatz := 0

  Global CheckOK_Break := True ; wenn auch bei CecklistBreak die Checkliste ok ist
  Global STD_On := False ; Wenn Baro STD gesetzt

  Global ANZ_Flaps := 2
  Global STR_Flaps := ["FUP", "F10", "F20"]
  Global use_Garmin = False

  ; DEV_VSpeeds_Eclipse550_REMARKS:

  ; Rotate (MTOM)			91 KIAS
  ; Normal Climb (MTOM) 	167 KIA S (2480 fpm)
  ; Flaps T/O 			200 KIAS
  ; Full Flaps 			140 KIAS
  ; Vyse 					130 KIAS
  ; Performance cruise 	speed at 99.0% N1 	360 KTAS, FL250
  ; Economy cruise 		speed at 95.4% N1 	332 KIAS, FL410
  ; Normal max Vno 		285 KIAS
  ; Never exceed Vne 		285 KIAS
  ; Stall (clean) 		95 KIAS
  ; Stall (land) 			76 KIAS
  ; Final approach (full flaps) 99 KIAS
  ; Max glide 			140 KIAS

  #Include %A_ScriptDir%\Common.ahk
Return

CMD_Process:
  Critical ,On
  DEBUG_CMD_Process++

  CP_StartTime := A_TickCount

  SetTimer, CMD_Process, Off

  ; WinActivate, %Aktu_Sim%
  WinActivate, ahk_class %Aktu_Sim%

  If (CMD_Text="?")
  {
    ; Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Views
  ;
  Else If (CMD_Text="night panel") ; HUD
  {
    Send {Shift Down}w{Shift Up}
    Send {Alt Down}h{Alt Up}
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
  Else If (CMD_Text="landing panel") ; 8
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
  Else If (CMD_Text="right window") ; 6
  {
    Gosub Screen6
  }
  Else If (CMD_Text="P F D") ; 1
  {
    Gosub Screen1
  }
  Else If (CMD_Text="thrust lever") ; 2
  {
    Gosub Screen2
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
  Else If (CMD_Text="flight director on")
  {
    Send {Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="flight director off")
  {
    Send {Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autothrust on")
  {
    Send {Ctrl Down}{Alt Down}r{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="autothrust off")
  {
    Send {Ctrl Down}{Alt Down}r{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
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
    Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up} ; Sync heading
    Send {Shift Down}{Ctrl Down}h{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold heading bug")
  {
    Send {Shift Down}{Ctrl Down}h{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold navigation")
  {
    Send {Shift Down}{Ctrl Down}n{Shift Up}{Ctrl Up}
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
  Else If (CMD_Text="hold altitude")
  {
    Send {Shift Down}{Ctrl Down}z{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold approach")
  {
    Send {Shift Down}{Ctrl Down}a{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="change altitude")
  {
    Send {Ctrl Down}{Alt Down}c{Shift Up}{Ctrl Up}{Alt Up} ; aerobask plugin de
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold vertical speed")
  {
    Send {Shift Down}{Ctrl Down}v{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Controls
  ;
  Else If (CMD_Text="flaps 1")
  {
    Send {F6 2}{F7 1}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="flaps 2")
  {
    Send {F7 2}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="go around")
  {
    ; Send {F4} ; full thrust
    If GEAR
      Send g ; gear up

    Send {F5}{F7 1} ; flaps 1

    ; If HAPP
    ; Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up} ; hold app off
    ; Send {Ctrl Down}z{Alt Up}{Shift Up}{Ctrl Up} ; hold altitude
    ; Send {Ctrl Down}h{Alt Up}{Shift Up}{Ctrl Up} ; hold heading
    ; Send {Shift Down}{Ctrl Down}{Alt Down}w{Alt Up}{Shift Up}{Ctrl Up} ; warnings off
    Err := _Text_to_Speech(CMD_Text)
  }
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
  Else If (CMD_Text="taxi lights on")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi lights off")
  {
    Send {Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
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
  ; Others
  ;
  Else If (CMD_Text="run timer") ; TODO:
  {
    ; Send {Shift Down}{Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _Text_to_Speech(CMD_Text)
    Err := _Text_to_Speech("Not implemented")
  }
  Else If (CMD_Text="stop timer")
  {
    ; Send {Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _Text_to_Speech(CMD_Text)
    Err := _Text_to_Speech("Not implemented")
  }
  Else If (CMD_Text="reset timer")
  {
    ; Send {Shift Down}{Ctrl Down}u{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _Text_to_Speech(CMD_Text)
    Err := _Text_to_Speech("Not implemented")
  }

  Else If (CMD_Text="use garmin")
  {
    use_Garmin := Not use_Garmin

    If use_Garmin
      Err := ToolTipEx("Use Garmin", x_Tooltip4, y_Tooltip4, 4, HFONT, "red", "white", "", "S")
    Else
      Err := ToolTipEx("", x_Tooltip4, y_Tooltip4, 4, HFONT, "Lime", "Black", "", "S")

    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  #Include %A_ScriptDir%\Common_CMD_XP.ahk
  #Include %A_ScriptDir%\Common_CMD.ahk
Return

_Preflight_Procedure() { ; Starts manually
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Preflight procedure")

  If _Is_CheckItem("Switch system battery and external power on!")
    If _Is_CheckItem("When all flightplans are filed, load cargo and fuel!")
    If _Is_CheckItem("Check ACARS!")
    If _Is_CheckItem("Set navigation lights on!")
    If _Is_CheckItem("Prepare flight management!")
    If _Is_CheckItem("If the flightdirector switched on and the GPS armed?")
    If _Is_CheckItem("Check if heading on runway course!")
    If _Is_CheckItem("Set actual baro!")
    If _Is_CheckItem("Set initial climb and take off speed!")
    If _Is_CheckItem("Check com radios!")
    If _Is_CheckItem("Check parking brake on!")

  If _Is_CheckItem("Preflight procedure is complete. Request start up or switch to unicom!")
    PreflightProc_Ok := True

  PreflightProc_Ok := PreflightProc_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_Preflight_Checklist() { ; Starts manually
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Preflight checklist")

  If _Is_CheckItem("When startup is approved, call pushback car!")
    If _Is_CheckItem("Check departure and flightplan route!")
    If _Is_CheckItem("Check the fuel!")
    If _Is_CheckItem("Check transponder!")
    If _Is_CheckItem("Check thrust lever is in idle position!")
    If _Is_CheckItem("Close the door and remove chocks!")
    If _Is_CheckItem("Switch beacon light on!")
    If _Is_CheckItem("Switch start battery on!")
    If _Is_CheckItem("Start the engines!")
    If _Is_CheckItem("Switch engine generators and cabin pressure to on!")
    If _Is_CheckItem("Remove GPU!")
    If _Is_CheckItem("Set flaps to take off position!")
    ; If _Is_CheckItem("Check flight controls!")
  If _Is_CheckItem("Check elevator!")

  If _Is_CheckItem("Preflight checklist is complete! Request push back or direct request taxi!")
    PreflightCheck_Ok := True

  PreflightCheck_Ok := PreflightCheck_Ok Or CheckOK_Break
  CheckList_Active := False

Return
}

_BeforeTaxi_Checklist() { ; when parkbrake off
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before Taxi Checklist")

  If _Is_CheckItem("Set transponder mode charly!")
    If _Is_CheckItem("Set taxi lights on!")

  If _Is_CheckItem("Before taxi checklist is complete!")
    BeforeTaxi_Ok := True

  BeforeTaxi_Ok := BeforeTaxi_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeTakeOff_Checklist() { ; Starts when the landing lights goes on
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before take off checklist")

  If _Is_CheckItem("Check the heading and navigation settings!")
    If _Is_CheckItem("Run timer")

  If _Is_CheckItem("Before take off checklist is complete. Request ready for departure!")

  BeforeTakeOff_Ok := BeforeTakeOff_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_AfterTakeOff_Checklist() { ; Starts after flaps full up
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("After take off checklist")

  If _Is_CheckItem("Check if the flaps and the gear are up!")
    If _Is_CheckItem("Check autopilot settings!")
    If _Is_CheckItem("Check electrical bus and cabin pressure!")

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

  If _Is_CheckItem("Check if approach transition is loaded!")
    If _Is_CheckItem("Check localizer frequence!")
    If _Is_CheckItem("Check actual QNH!")

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

  If _Is_CheckItem("Check if flaps in landing position and the gear down!")
    If _Is_CheckItem("Check if localizer is engaged!")
    If _Is_CheckItem("Check the altimeter!")

  If _Is_CheckItem("Before landing checklist is complete!")
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

  Err := _Text_to_Speech("Parking Checklist")

  If _Is_CheckItem("Transponder mode standby!")
    If _Is_CheckItem("Switch engines off!!")
    If _Is_CheckItem("Switch GPU on and set the chocks!")
    If _Is_CheckItem("Batteries and cabin pressure off!")
    If _Is_CheckItem("Check the lights!")
    If _Is_CheckItem("Flight director off!")
    If _Is_CheckItem("Open the door!")

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
    Global AC_TYPE := 0x3160 ; bei MSFS& P3D 0x3D00
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

  Global FLAPS := 0x0BDC ; Klappenstellung als Wert von 100%
  Global FLAPS_V := 999 ; Klappenstellung als Nr
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, FLAPS, int, 4, int, &FLAPS, int, &dwResult)
  ;
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; Standard VARs convert

  If AC_TYPE_read
  {
    AC_TYPE := StrGet(&AC_TYPE, 14, "UTF-8")

    If (AC_TYPE == " Eclipse550 ai") OR (AC_TYPE == "Eclipse 550 NG")
      AC_TYPE := "EA50" ; 4 stellig
    Else
    {
      _Error_Message("AC_TYPE: EA50 ->" AC_TYPE "<", 6)
      AC_TYPE := "????"
    }

    AC_TYPE_read := False
  }

  GEAR := NumGet(&GEAR, 0, "int") == 16383

  GS := round(NumGet(&GS, 0, "int") / 65536 / 1000 * 3600) ; Ground Speed in km/h
  TAS := round(NumGet(&TAS, 0, "int") / 128) ; True Air Speed in Kn
  IAS := round(NumGet(&IAS, 0, "int") / 128) ; Indicated Air Speed in Kn

  VSPEED := round(NumGet(&VSPEED, 0, "int") * 60 * 3.28084 / 256) ; Vertical Speed ft/ min
  VSPEED_TD := round(NumGet(&VSPEED_TD, 0, "int") * 60 * 3.28084 / 256) ; Touch down VSpeed  ft/ min
  TD_FLAG	:= Not (NumGet(&TD_FLAG, 0, "short") > 0) ; Touch down flag

  QALT := round(NumGet(&QALT, 0, "int") * 3.28) ; von Meter in Fuss umrechenen
  GALT := round(QALT - NumGet(&GALT, 0, "short") * 3.28) ; von Meter in Fuss umrechenen
  HDG	:= round(NumGet(&HDG, 0, "uint")*360/(65536*65536))

  PBRAKE := NumGet(&PBRAKE, 0, "short") >= 22936
  ; _Message("PBRAKE" PBRAKE, 0)

  FLAPS := NumGet(&FLAPS, 0, "int")
  FLAPS_V := round(FLAPS / (16382/ANZ_Flaps)) ; ?= Anzahl Flaps
  FLAPS := FLAPS > 0

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

  FD := NumGet(&FD, 0, "int") > 0
  AT := NumGet(&AT, 0, "int") > 0
  AP := NumGet(&AP, 0, "int") > 0

  HNAV := NumGet(&HNAV, 0, "int") > 0
  HNAV1_V := NumGet(&HNAV1_V, 0, "short")

  HHDG := NumGet(&HHDG, 0, "int") > 0
  HHDG_V := round(NumGet(&HHDG_V, 0, "short") * 360 / 65536)

  HALT := NumGet(&HALT, 0, "int") > 0

  HVS := NumGet(&HVS, 0, "int") > 0
  HVS_V := NumGet(&HVS_V, 0, "short")

  HAPP := NumGet(&HAPP, 0, "int") > 0
  HGPS := NumGet(&HGPS, 0, "int") > 0

  ; 0 = Navigatin / 2 = Beacon/ 4 = Landing / 8 = Taxi / 16 = Strobe / 32 = Instruments / 64 = Recognition / 128 = Wing
  ; Airbus: LANDING = 4 / NOSE/ TAXI = 8 / STROBE = 16 / WING = 128 / NAV = 256

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
  DEBUG_Write_Statusbar++

  GetKeyState, NumLState ,NumLock, T ; NUM State

  If (NumLState = "D")
    NumLockChar := 1
  Else
    NumLockChar := 0

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

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> BEACON_L)
  {
    TTex_oFSVAR[TTex_Nr] := BEACON_L
    Err := ToolTipEx("Beacon", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[BEACON_L], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> TAXI_L)
  {
    TTex_oFSVAR[TTex_Nr] := TAXI_L
    Err := ToolTipEx("Taxi", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[TAXI_L], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 4) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> STROBE_L)
  {
    TTex_oFSVAR[TTex_Nr] := STROBE_L
    Err := ToolTipEx("Strobe", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[STROBE_L], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> LAND_L)
  {
    TTex_oFSVAR[TTex_Nr] := LAND_L
    Err := ToolTipEx("Landing", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[LAND_L], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 7) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> XIVAP_TP)
  {
    TTex_oFSVAR[TTex_Nr] := XIVAP_TP
    Err := ToolTipEx("TP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[XIVAP_TP], "BLACK", "", "S")
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

  ; Err := ToolTipEx("N", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[NumLockChar], "BLACK", "", "S")
  ; TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS

  ++TTex_Nr
  ; MsgBox ,,,%Aktu_Sim%,2
  ; If WinExist(Aktu_Sim)
  WinGetClass, ahkClass, A

  If (ahkClass = Aktu_Sim) ; (WinActive(Aktu_Sim)
  {
    Err := ToolTipEx(BlinkerChar, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "Red", "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 1) + TTex_FontS
  }
  Else
  {
    Err := ToolTipEx(BlinkerChar, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "White", "BLACK", "", "S")
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

  ; If Not PreflightCheck_Ok
  ; 	Goto Show_DEBUG_Info

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
  If (Not PBRAKE And Not BeforeTaxi_Ok And PreflightCheck_Ok And Not CheckList_Active)
  {
    Err := _CMD("before taxi checklist")
  }

  If TAXI_L And Not GEAR
  {
    Err := _CMD("taxi lights off")
  }

  ; "BEFORE TAKE Off CHECKLIST"
  If ((LAND_L) And Not BeforeTakeOff_Ok And BeforeTaxi_Ok And Not CheckList_Active)
  {
    Err := _CMD("before take off checklist")
  }

  ; "AFTER TAKE Off CHECKLIST"
  If ((FLAPS_V = 0 Or QALT > 4000) And Not AfterTakeOff_Ok And BeforeTakeOff_Ok And Not CheckList_Active)
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
    Send {Shift Down}{Ctrl Down}{ALT Down}...{ALT Up}{Shift Up}{Ctrl Up}
    SoundBeep, 300, 50
  }

  ACS_EndTime := A_TickCount - ACS_StartTime
  ACS_Time := ACS_EndTime - RFV_Time - WSB_Time

  DEBUG_Aircraft_Scenario += 1000
Return

Show_DEBUG_Info:
  DebugText =
  (
    DEBUG Info
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

AIRCRAFT_INIT:
  ; 1 Monitor
  FileCopy, J:\X-Plane 11\Output\preferences\X-Plane Window Positions_1Mon.prf, J:\X-Plane 11\Output\preferences\X-Plane Window Positions.prf ,

  ; 2 Monitore
  ; FileCopy, J:\X-Plane 11\Output\preferences\X-Plane Window Positions_2Mon.prf, J:\X-Plane 11\Output\preferences\X-Plane Window Positions.prf ,

Return

_Write_Aircraft_Info(Filename) {

  FileAppend, "Test Text", Filename
Return, 0
}

JOYSTICK_SECTION:
  ; -------------------------------------------------------
  ; 1JoyX Wireless Gamepad
  ; 3JoyX TM T-Flight Stick Hotas X (Hands On Throttle And Stick)
  ; 4JoyX Arduino

3JoyPOV:
POV:
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

3Joy01_CheckitemOk:
Return

3Joy02_MainPanel_GreatPanel:
3Joy2:: ; HOTAS _Joy_VM
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

3Joy03_SpeechRec__HotkeyButton:
  ; WinActivate, ahk_class %Aktu_Sim%
Return

3Joy04_ATC__HotkeyButton:
  ; WinActivate, ahk_class %Aktu_Sim%
Return

3Joy05_AP_WarningsOff:
3Joy5:: ; HOTAS_Thrust_RO
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

3Joy06_AT_WarningsOff:
3Joy6:: ; HOTAS_Thrust_RM
  x := 0
  While GetKeyState("3Joy6")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If x = 10
    {
      Err := _CMD("warnings off")
      Return
    }
  }

  If AT
    Err := _CMD("autothrust off")
  Else
    Err := _CMD("autothrust on")

Return

3Joy07_AP_HoldVerticalSpeed:
3Joy7:: ; HOTAS_Thrust_RU
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

      Err := _CMD("take off trim")
      Return
    }
  }

  Err := _CMD("hold vertical speed")
Return

3Joy08_OutsideView_TopDownView:
3Joy8:: ; HOTAS_Thrust_VM
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

3Joy09_FlapsStepUp_FlapsUP:
3Joy9:: ; HOTAS_Thrust_HO
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

3Joy10_FlapsStepDown_FlapsDown:
3Joy10:: ; HOTAS_Thrust_HU
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

3Joy11_ParkingBrake_Gear:
3Joy11:: ; HOTAS_Thrust_UL
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

3Joy12_StopTimer_GoAround:
3Joy12:: ; HOTAS _Thrust_UR
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

  ; Err := _CMD("stop timer")
  Err := _CMD("strobe and landing lights off")
  Err := _CMD("flaps full up")
Return

_ARDUINO_Buttons:
  ; 1 - 4
  ; 2 - 5
  ; 3 - 6

4Joy1_PDFandMFD_externWin:
4Joy1::
  WinActivate, ahk_class %Aktu_Sim%

  x := 0
  While GetKeyState("4Joy1")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If (x = 10)
    {
      Send 33 ; PDF out window
      Send 44 ; MFD out window
      Return
    }
  }	

  Send 12
  ; Err := _CMD("switch P F D")
  ; Err := _CMD("switch M F D")
  ; _Message("4Joy1", 3)
Return

4Joy2_HoldSpeed_SynchHDG:
4Joy2::
  WinActivate, ahk_class %Aktu_Sim%

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

  Err := _CMD("hold speed")
  ; _Message("4Joy2", 3)
Return

4Joy3_HoldHeadingBug_HoldNavigation:
4Joy3::
  WinActivate, ahk_class %Aktu_Sim%

  x := 0
  While GetKeyState("4Joy3")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If x = 10
    {
      Err := _CMD("hold navigation")
      Return
    }
  }	

  Err := _CMD("hold heading bug")
  ; _Message("4Joy3", 3)
Return

; 4Joy4_HoldNavigation:
4Joy4_MFDwindow_ChangeMenue:
4Joy4::
  WinActivate, ahk_class %Aktu_Sim%

  x := 0
  While GetKeyState("4Joy4")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If (x = 10)
    {
      Err := _CMD("change menue")
      Return
    }
  }	

  Err := _CMD("use garmin")
  ; Err := _CMD("switch M F D")
  ; _Message("4Joy4", 3)
Return

4Joy5_HoldVSpeed_holdVNAV:
4Joy5::
  WinActivate, ahk_class %Aktu_Sim%

  x := 0
  While GetKeyState("4Joy5")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If x = 10
    {
      Err := _CMD("hold V NAV")
      Return
    }
  }	

  Err := _CMD("hold vertical speed")
  ; _Message("4Joy5", 3)
Return

4Joy6_HoldAltitude_holdVNAV:
4Joy6::
  WinActivate, ahk_class %Aktu_Sim%

  x := 0
  While GetKeyState("4Joy6")
  {
    x := x + 1
    Sleep, ButtonWait_Delay

    If x = 10
    {
      Err := _CMD("hold V NAV")
      Return
    }
  }	

  Err := _CMD("hold altitude")
  ; _Message("4Joy6", 3)
Return

4Joy7_SpeechRec__HotkeyButton:
  ; 4Joy7::
  ; WinActivate, ahk_class %Aktu_Sim%
  ; _Message("4Joy7", 3)
Return
4Joy8_ATC__HotkeyButton:
  ; 4Joy8::
  ; WinActivate, ahk_class %Aktu_Sim%
  ; _Message("4Joy8", 3)
Return
4Joy9_CecklistOK__HotkeyButton:
  ; 4Joy9::
  ; WinActivate, ahk_class %Aktu_Sim%
  ; _Message("4Joy9", 3)
Return

_ARDUINO_Rotaries:

4Joy10_CourseDown_Baro:
4Joy10:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{9}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Ins}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{ALt Down}{Ins}{Alt Up}{Shift Up}

  ; _Message("Course down", 0)
Return
4Joy11_CourseUp_Baro:
4Joy11:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{0}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Del}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{Del}{Alt Up}{Shift Up}

  ; _Message("Course up", 0)
Return

4Joy12_SpeedDown_Nav:
4Joy12:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{5}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{End}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{End}{Alt Up}{Shift Up}

  ; _Message("speed down", 0)
Return
4Joy13_SpeedUp_Nav:
4Joy13:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{6}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Home}{Alt Up}{Ctrl Up}
  Else		
    Send {Shift Down}{Alt Down}{Home}{Alt Up}{Shift Up}

  ; _Message("speed up", 0)
Return

4Joy14_HeadingDown_Nav:
4Joy14:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{7}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Left}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{Left 1}{Alt Up}{Shift Up}{Ctrl Up}

  ; _Message("Heading down", 0)
Return
4Joy15_HeadingUp_Nav:
4Joy15:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{8}{Alt Up} ; FMS outer Ring
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Right}{Alt Up}{Ctrl Up}
  Else	
    Send {Shift Down}{Alt Down}{Right 1}{Alt Up}{Shift Up}{Ctrl Up}

  ; _Message("Heading up", 0)
Return

4Joy16_AltitudeDown_FMS:
4Joy16:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {	
    Send {Alt Down}{3}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Down 1}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{Down 1}{Alt Up}{Shift Up}{Ctrl Up}

  ; _Message("Altitude down", 0)
Return
4Joy17_AltitudeUp_FMS:
4Joy17:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{4}{Alt Up}
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{Up 1}{Ctrl Up}{Alt Up}
  Else
    Send {Shift Down}{Alt Down}{Up 1}{Alt Up}{Shift Up}{Ctrl Up}

  ; _Message("Altitude up", 0)
Return

4Joy18_VSpeedDown_FMS:
4Joy18:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{1}{Alt Up} ; FMS outer Ring
    Return
  }	

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{PgDn}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{PgDn}{Alt Up}{Shift Up}

  ; _Message("VS down", 0)
Return
4Joy19_VSpeedUp_FMS:
4Joy19:: ; LUA
  WinActivate, ahk_class %Aktu_Sim%

  If use_Garmin
  {
    Send {Alt Down}{2}{Alt Up} ; FMS outer Ring
    Return
  }

  If GetKeyState("Ctrl")
    Send {Ctrl Down}{Alt Down}{PgUp}{Alt Up}{Ctrl Up}
  Else
    Send {Shift Down}{Alt Down}{PgUp}{Alt Up}{Shift Up}

  ; _Message("VS up", 0)
Return

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
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadHome}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 7
Return

Screen8:
$NumpadUp:: ; Numpad8
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadUp}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 8
Return

Screen9:
$NumpadPgUp:: ; Numpad9
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadPgUp}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 9
Return

Screen4:
$NumpadLeft:: ; Numpad4
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadLeft}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 4
Return

Screen5:
$NumpadClear:: ; Numpad5
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadClear}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 5
Return

Screen6:
$NumpadRight:: ; Numpad6
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadRight}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 6
Return

Screen1:
$NumpadEnd:: ; Numpad1
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadEnd}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 1
Return

Screen2:
$NumpadDown:: ; Numpad2
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadDown}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 2
Return

Screen3:
$NumpadPgDn:: ; Numpad3
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadPgDn}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 3
Return

Screen0:
$NumpadIns:: ; Numpad0:
  WinActivate, ahk_class %Aktu_Sim%
  Send {NumpadIns}
  Last_Screen := Aktu_Screen
  Aktu_Screen := 0
Return

ScreenDel:
$NumpadDel:: ; NumpadDel
  ; WinActivate, %Aktu_Sim%
  WinActivate, ahk_class %Aktu_Sim%
  Send {Ctrl Down}w{Ctrl Up} ; no panel

  ; CoordMode, Mouse, Screen
  ; Click,right, 1919,35
  ; MouseMove, 1930,5,0
Return