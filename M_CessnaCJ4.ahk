M_CessnaCJ4_2022_09_14:

DEV_VARS:
  Global TEST := False ; Or True ; Keine Programme starten
  Global DEBUG := False ;Or True ; Debug anzeigen

  Global Aktu_Sim := "Microsoft Flight Simulator"
  Global Aktu_Scenario := "CessnaCJ4" ; zum suchen in Load Scenario
  Global CMD_File := "M_" Aktu_Scenario ".ahk" ; Kommandos aus dem Aircraft File
  Global CMD_List := "M_" Aktu_Scenario "_CMD.txt"

  ; Sprachbefehl Anzeigen
  Global x_Versatz := 0 ; -1920 <-  0  -> +1920
  Global y_Versatz := 0

  ; Statusanzeigen (ToolTip 2 u. 3)
  Global TTex_xVersatz := 348 ; -1920 <-  0  -> +1920
  Global TTex_yVersatz := 0

  Global CheckOK_Break := True ; wenn auch bei CecklistBreak die Checliste ok ist
  Global STD_On := False ; Wenn Baro STD gesetzt
  Global ANZ_Flaps := 3 ; 0, 1, 2
  Global TRIM := 0 ; Temp VAR für Trim up/down

  #Include %A_ScriptDir%\Common.ahk

Return

CMD_Process:
  Critical ,On

  ; Global CP_StartTime
  ; Global CP_EndTime
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
  ; no extendet views
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
  Else If (CMD_Text="P F D") ; 1
  {
    Gosub Screen1
  }
  Else If (CMD_Text="power schwitches") ; 1
  {
    Gosub Screen1
  }
  Else If (CMD_Text="trim wheel") ; 2
  {
    Gosub Screen2
  }
  Else If (CMD_Text="thrust lever") ; 2
  {
    Gosub Screen2
  }
  Else If (CMD_Text="NAV") ; 3
  {
    Gosub Screen3
  }
  Else If (CMD_Text="CDU") ; 3
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
    Send {Shift Down}{Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}{f Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="flight director off")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}f{Shift Up}{Ctrl Up}{Alt Up}
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
    Send {Shift Down}{Ctrl Down}h{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold navigation")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}n{Shift Up}{Ctrl Up}{Alt Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold roll mode") ; TODO:?????????
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
  Else If (CMD_Text="hold vertical speed")
  {
    Send {Shift Down}{Ctrl Down}{Alt Down}v{Shift Up}{Ctrl Up}{Alt Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="hold speed") ; TODO: ?????????
  {
    Send {Shift Down}{Ctrl Down}s{Shift Up}{Ctrl Up}
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
  Else If (CMD_Text="Flaps 1")
  {
    Send {F6 4}{F7 1}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="Take Off flaps")
  {
    Send {F6 4}{F7 1}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="Flaps 2")
  {
    Send {F6 4}{F7 1}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="Landing flaps")
  {
    Send {F6 4}{F7 2}
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
  Else If (CMD_Text="beacon lights on") ; MSFS-Tastatur TODO: funktioniert nicht
  {
    If Not BEACON_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}b{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Shift Down}{Ctrl Down}{AppsKey Down}b{Shift Up}{Ctrl Up}{AppsKey Up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="beacon lights off") ; MSFS-Tastatur TODO: funktioniert nicht
  {
    If BEACON_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}b{Shift Up}{Ctrl Up}{Alt Up}
      ; 	Send {Ctrl Down}{AppsKey Down}b{Ctrl Up}{AppsKey Up}
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi lights on")
  {
    If Not TAXI_L
      Send {Shift Down}{Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="taxi lights off")
  {
    If TAXI_L
      Send {Shift Down}{Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}

    ; Send {Ctrl Down}{Alt Down}t{Alt Up}{Shift Up}{Ctrl Up}
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe lights on") ;TODO:
  {
    If Not STROBE_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Shift Down}{Ctrl Down}{AppsKey Down}s{Shift Up}{Ctrl Up}{AppsKey Up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe lights off") ;TODO:
  {
    If STROBE_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Ctrl Down}{AppsKey Down}s{Shift Up}{Ctrl Up}{AppsKey Up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="landing lights on") ;TODO:
  {
    If Not LAND_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Shift Down}{Ctrl Down}{AppsKey Down}l{Shift Up}{Ctrl Up}{AppsKey up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="landing lights off") ;TODO:
  {
    If LAND_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Ctrl Down}{AppsKey Down}l{Ctrl Up}{AppsKey up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe and landing lights on")
  {
    If Not STROBE_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Shift Down}{Ctrl Down}{AppsKey Down}s{Shift Up}{Ctrl Up}{AppsKey Up} ; LUA
    }
    If Not LAND_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Shift Down}{Ctrl Down}{AppsKey Down}l{Shift Up}{Ctrl Up}{AppsKey up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="strobe and landing lights off")
  {
    If STROBE_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}s{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Ctrl Down}{AppsKey Down}s{Shift Up}{Ctrl Up}{AppsKey Up} ; LUA
    }

    If LAND_L
    {
      Send {Shift Down}{Ctrl Down}{Alt Down}l{Shift Up}{Ctrl Up}{Alt Up} ; MSFS toggle
      ; Send {Ctrl Down}{AppsKey Down}l{Ctrl Up}{AppsKey up} ; LUA
    }
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  ; Others
  ;
  Else If (CMD_Text="baro standard") ; TODO: auch in common_cmd_MS
  {
    Auto_Baro := False ; True
    ; Send {Shift Down}{Ctrl Down}{Alt Down}q{Alt Up}{Shift Up}{Ctrl Up}
    STD_On := True
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="baro QNH") ; TODO: auch in common_cmd_MS
  {
    Auto_Baro := False
    ; Send {Ctrl Down}{Alt Down}q{Alt Up}{Shift Up}{Ctrl Up}
    Send b
    STD_On := False
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="reload lua")
  {
    Send {AppsKey Down}9{AppsKey Up}	
    Err := _Text_to_Speech(CMD_Text)
  }
  Else If (CMD_Text="kill lua")
  {
    Send {AppsKey Down}9{AppsKey Up}	
    Err := _Text_to_Speech(CMD_Text)
  }
  ;
  #Include %A_ScriptDir%\Common_CMD_MS.ahk
  #Include %A_ScriptDir%\Common_CMD.ahk
Return

_Preflight_Procedure() {
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Preflight procedure")

  If _Is_CheckItem("When all flightplans are filed, load cargo and fuel!")
    If _Is_CheckItem("Check parking brake and thrust lever!")
    If _Is_CheckItem("Generator switches ON!")
    If _Is_CheckItem("Battery ON!")
    If _Is_CheckItem("Avionics switch DISPATCH!")
    If _Is_CheckItem("Emergency Lights Switch ARMED!")
    If _Is_CheckItem("Groundpower when required!")
    If _Is_CheckItem("Exterior Lights as required!")
    If _Is_CheckItem("Climate Control Selector OFF!")
    ; If _Is_CheckItem("EICAS CHECK!")
  If _Is_CheckItem("Check ACARS!")
    If _Is_CheckItem("Prepare flight management!")

  If _Is_CheckItem("Preflight procedure is complete. Request start up or switch to unicom!")
    PreflightProc_Ok := True

  PreflightProc_Ok := PreflightProc_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_Preflight_Checklist() {
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Preflight checklist")

  If _Is_CheckItem("Avionics Switch ON!")
    If _Is_CheckItem("Flightdirector switched ON?")
    If _Is_CheckItem("Check if heading on runway course!")
    If _Is_CheckItem("Set actual baro!")
    If _Is_CheckItem("Set initial climb and take off speed!")
    If _Is_CheckItem("Check com radios!")
    If _Is_CheckItem("Check departure and flightplan route!")
    If _Is_CheckItem("Check the fuel!")
    If _Is_CheckItem("Check transponder!")
    If _Is_CheckItem("Switch beacon light on!")

  If _Is_CheckItem("Preflight checklist is complete! Request push back or direct request taxi!")
    PreflightCheck_Ok := True

  PreflightCheck_Ok := PreflightCheck_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeTaxi_Checklist() {
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before Taxi Checklist")

  If _Is_CheckItem("Start the engines!")
    If _Is_CheckItem("Remove GPU!")

  If _Is_CheckItem("Climate Control Selector NORM!")
    If _Is_CheckItem("PASS Light Safety Button ON!")
    If _Is_CheckItem("Trims CHECK/SET!")
    If _Is_CheckItem("CHECK/SET ice protection!")
    If _Is_CheckItem("Speedbrake/Ground Spoilers CHECK!")
    If _Is_CheckItem("Flaps CHECK/SET!")
    If _Is_CheckItem("Set taxi lights on!")

  If _Is_CheckItem("Before taxi checklist is complete!")
    BeforeTaxi_Ok := True

  BeforeTaxi_Ok := BeforeTaxi_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_BeforeTakeOff_Checklist() {
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Before take off checklist")

  If _Is_CheckItem("Check the heading and navigation settings!")
    If _Is_CheckItem("Request ready for departure!")
    If _Is_CheckItem("Set transponder mode charly!")

  If _Is_CheckItem("Before take off checklist is complete. Run the timer!")
    BeforeTakeOff_Ok := True

  BeforeTakeOff_Ok := BeforeTakeOff_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_AfterTakeOff_Checklist() {
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

_BeforeApproach_Checklist() {
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

_BeforeLanding_Checklist() {
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

_AfterLanding_Checklist() {
  Critical ,Off
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("After landing checklist")

  If _Is_CheckItem("Check if the transponder in mode standby!")
    If _Is_CheckItem("Check the lights and if the flaps are full up!")

  If _Is_CheckItem("After landing checklist is complete! Stop timer and Request Taxi to the Gate!")
    AfterLanding_Ok := True

  AfterLanding_Ok := AfterLanding_Ok Or CheckOK_Break
  CheckList_Active := False
Return
}

_Parking_Checklist() {
  SetTimer,, Off
  CheckList_Active := True

  Err := _Text_to_Speech("Parking Checklist")

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
  ; Typ	Wertebereich								Länge
  ; byte	-128..127									8 Bit
  ; short	-32768..32767								16 Bit
  ; int	-2147483648..2147483647						32 Bit
  ; int64/long	-9223372036854775808..9223372036854775807	64 Bit

  ; Standard VARs read

  If AC_TYPE_read ; Nur beim ersten Durchlauf
  {
    Global AC_TYPE := 0x3D00
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, AC_TYPE, int, 14, char, &AC_TYPE, int, &dwResult)
  }

  Global ELV_TRIM := 0x0BC0 ; ELEVATOR Trimmung in %
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, ELV_TRIM, int, 2, short, &ELV_TRIM, int, &dwResult)

  Global POWER := 0 ; Power in %

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
  ;
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  ; Standard VARs convert

  If AC_TYPE_read
  {
    ; Zkette := StrGet(Quelle [, Länge] [, Codierung := Keine])
    AC_TYPE := StrGet(&AC_TYPE, 14, "UTF-8")

    If (AC_TYPE = "Cessna CJ4 Cit")
      AC_TYPE := "CJ4" ; 3 stellig
    Else
    {
      _Error_Message("AC_TYPE: CJ4 ->" AC_TYPE "<", 6)
      AC_TYPE := "????"
    }

    AC_TYPE_read := False
  }

  ELV_TRIM := ceil(NumGet(&ELV_TRIM, 0, "short") / 164)
  ; _Message(ELV_TRIM,0)

  POWER := ceil(100 - GetKeyState("3JoyZ"))
  ; _Message(POWER,0)

  GEAR 	:= NumGet(&GEAR, 0, "int") == 16383
  GS 		:= round(NumGet(&GS, 0, "int") / 65536 / 1000 * 3600) ; Ground Speed in km/h
  TAS 	:= round(NumGet(&TAS, 0, "int") / 128) ; True Air Speed in Kn
  IAS 	:= round(NumGet(&IAS, 0, "int") / 128) ; Indicated Air Speed in Kn

  VSPEED 	:= round(NumGet(&VSPEED, 0, "int") * 60 * 3.28084 / 256) ; Vertical Speed ft/ min
  VSPEED_TD := round(NumGet(&VSPEED_TD, 0, "int") * 60 * 3.28084 / 256) ; Touch down VSpeed  ft/ min
  TD_FLAG	:= Not (NumGet(&TD_FLAG, 0, "short") > 0) ; Touch down flag

  QALT 	:= round(NumGet(&QALT, 0, "int") * 3.28) ; von Meter in Fuss umrechenen
  GALT 	:= round(QALT - NumGet(&GALT, 0, "short") * 3.28) ; von Meter in Fuss umrechenen
  HDG		:= round(NumGet(&HDG, 0, "uint")*360/(65536*65536))

  ; PBRAKE 	:= NumGet(&PBRAKE, 0, "short")
  ; err := _message(PBRAKE, 0)

  PBRAKE 	:= NumGet(&PBRAKE, 0, "short") >= 22936 ; Parking brake: 0=off, 32767=on

  ; PUSHBACK 	:= NumGet(&PUSHBACK, 0, "int")

  FLAPS 	:= NumGet(&FLAPS, 0, "int")
  FLAPS_V	:= round(FLAPS / (16382/ANZ_Flaps)) ; ?= Anzahl Flaps
  FLAPS 	:= FLAPS > 0

  ; Com Radios and Transponder

  Global MSFS_TP := 0x0B46 ; Transponder State MSFS2020
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, MSFS_TP, int, 1, short, &MSFS_TP, int, &dwResult)

  Global COM1_ACT_F 	:= 0x034E
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_ACT_F, int, 2, short, &COM1_ACT_F, int, &dwResult)

  Global COM1_STB_F 	:= 0x311A
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM1_STB_F, int, 2, short, &COM1_STB_F, int, &dwResult)

  Global COM2_ACT_F 	:= 0x3118
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_ACT_F, int, 2, short, &COM2_ACT_F, int, &dwResult)

  Global COM2_STB_F 	:= 0x311C
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Read", int, COM2_STB_F, int, 2, short, &COM2_STB_F, int, &dwResult)

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", int, &dwResult)

  MSFS_TP	:= NumGet(&MSFS_TP, 0, "short") = 4 ; 4 = On

  COM1_ACT_F := NumGet(COM1_ACT_F, 0, "short") * 0x10 + 0x100000
  COM1_STB_F := NumGet(COM1_STB_F, 0, "short") * 0x10 + 0x100000
  COM2_STB_F := NumGet(COM2_STB_F, 0, "short") * 0x10 + 0x100000
  COM2_ACT_F := NumGet(COM2_ACT_F, 0, "short") * 0x10 + 0x100000

  ; Alle GA Flieger- VARs

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

  FD	:= NumGet(&FD, 0, "int") > 0
  AT	:= NumGet(&AT, 0, "int") > 0
  AP	:= NumGet(&AP, 0, "int") > 0

  HNAV 	:= NumGet(&HNAV, 0, "int") > 0
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

Return Err
}

Write_Statusbar:
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

  If (TTex_oFSVAR[TTex_Nr] <> PBRAKE)
  {
    TTex_oFSVAR[TTex_Nr] := PBRAKE
    Err := ToolTipEx("PBrake", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[PBRAKE], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
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
    Err := ToolTipEx("Flaps"FLAPS_V, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[FLAPS_V], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
  }

  ++TTex_Nr

  If (TTex_oFSVAR[TTex_Nr] <> FD)
  {
    TTex_oFSVAR[TTex_Nr] := FD
    Err := ToolTipEx("FD", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HGPS], "BLACK", "", "S")
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

  If (TTex_oFSVAR[TTex_Nr] <> AT)
  {
    TTex_oFSVAR[TTex_Nr] := AT
    Err := ToolTipEx("AT", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[HHDG], "BLACK", "", "S")
    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 2) + TTex_FontS
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

  If (TTex_oFSVAR[TTex_Nr] <> MSFS_TP)
  {
    TTex_oFSVAR[TTex_Nr] := MSFS_TP
    Err := ToolTipEx("TP", TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[MSFS_TP], "BLACK", "", "S")
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
    If Screen7_On
      Err := ToolTipEx(BlinkerChar, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "MAROON", "BLACK", "", "S")
    Else
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

    TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 3) + TTex_FontS
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

    If HVS
    {		Err := ToolTipEx("f/m "Format("{1:4}",HVS_V), TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, "RED", "WHITE", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 8) + TTex_FontS
    }
    Else
    {
      Str := QALT "/" GAlt "/" TAS "/" HDG "/" HVS_V ; !!!!!!!!!! hier  VS immer anzeigen
      Err := ToolTipEx(Str, TTex_StartPos[TTex_Nr], TTex_yVersatz, TTex_Nr, HFONT, ItemColor[0], "BLACK", "", "S")
      TTex_StartPos[TTex_Nr+1] := TTex_StartPos[TTex_Nr] + (TTex_FontB * 6) + TTex_FontS
    }

    ; ++TTex_Nr
    ; Err := ToolTipEx(,,,TTex_Nr)

    ++TTex_Nr
    Err := ToolTipEx(,,,TTex_Nr)

  }

Return

Aircraft_Scenario:
  ; ; Aircraft_Scenario:
  ; Global ACS_StartTime
  ; Global RFV_Time
  ; Global WSB_Time
  ; Global ACS_Time
  ; Global ACS_EndTime

  ; Global ACS_LastTime := 0 ; A_TickCount ; Aircraft_Scenario Time Tick

  Critical ,On

  ACS_StartTime := A_TickCount

  If Not _Read_FS_VARS()
  {
    gosub Stop_Aircraft_Scenario
    gosub Start_Aircraft_Scenario
    Return
  }

  RFV_Time := A_TickCount - ACS_StartTime

  Gosub Write_Statusbar
  WSB_Time := A_TickCount - ACS_StartTime - RFV_Time

  If Not PreflightCheck_Ok
    Goto Show_DEBUG_Info

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
Return

JOYSTICK_SECTION:
  ; JoyX Wireless Gamepad
  ; 2JoyX Basetech Gamepad
  ; 3JoyX HOTAS (Hands On Throttle And Stick)

3JoyPOV:
POV:
  Global POV_Step := 2

  Global POV_Value := GetKeyState("3JoyPOV")

  if (POV_Value < 0) Or (Aktu_Screen = 9)
    Return

  If Screen7_On ; Top Down View ; Drohnen Ansicht
  {
    if (POV_Value = 31500) ; Numpad7
    {
    }
    else if (POV_Value = 0) ; Numpad8
    {
      Send {Shift Down}{Up %POV_Step%}{Shift Up}
    }
    else if (POV_Value = 4500) ; Numpad9
    {
    }
    else if (POV_Value = 27000) ; Numbad4
    {
      Send {Shift Down}{Left %POV_Step%}{Shift Up}
    }
    else if (POV_Value = 9000) ; Numpad6
    {
      Send {Shift Down}{Right %POV_Step%}{Shift Up}
    }
    else if (POV_Value = 22500) ; Numpad1
    {
    }
    else if (POV_Value = 18000) ; Numpad2
    {
      Send {Shift Down}{Down %POV_Step%}{Shift Up}
    }
    else if (POV_Value = 13500) ; Numpad3
    {
    }

    Return
  }

  if (POV_Value = 31500) ; Numpad7
  {
    If (Aktu_Screen <> 7)
      Gosub Screen7
  }
  else if (POV_Value = 0) ; Numpad8
  {
    If (Aktu_Screen <> 8)
      Gosub Screen8
  }
  else if (POV_Value = 4500) ; Numpad9
  {
    If (Aktu_Screen <> 9)
      Gosub Screen9
  }
  else if (POV_Value = 27000) ; Numpad4
  {
    If (Aktu_Screen <> 4)
      Gosub Screen4
  }
  else if (POV_Value = 9000) ; Numpad6
  {
    If (Aktu_Screen <> 6)
      Gosub Screen6
  }
  else if (POV_Value = 22500) ; Numpad1
  {
    If (Aktu_Screen <> 1)
      Gosub Screen1
  }
  else if (POV_Value = 18000) ;Numpad2
  {
    If (Aktu_Screen <> 2)
      Gosub Screen2
  }
  else if (POV_Value = 13500) ; Numpad3
  {
    If (Aktu_Screen <> 3)
      Gosub Screen3
  }

Return

3Joy01_CheckitemOk:
  ; 3Joy1:: ; HOTAS _Joy_HM
  ; Brake in P3D
Return

3Joy02_MainPanel:
3Joy2:: ; HOTAS _Joy_VM
  Send {Alt Up}{Shift Up}{Ctrl Up} ; vorsichtshalber alle Rücksetzen

  Gosub Screen5
Return

3Joy03_SpeechOn:
  ; 3Joy3:: ; HOTAS_Joy_RH
  ; Zoom in -> in P3D configuriert
Return

3Joy04_ATC:
  ; 3Joy4:: ; HOTAS_Joy_RV
  ; Zoom out -> in P3D configuriert
Return

3Joy05_VS_Down:
3Joy5:: ; HOTAS_Thrust_HO/ XPlane

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

3Joy06_VS_Up:
3Joy06:: ; HOTAS_Thrust_HU
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

      Err := _CMD("hold vertical speed")
      Return
    }
  }
  If AP
    Err := _CMD("autopilot off")
  Else
    Err := _CMD("autopilot on")
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
  ; Flaps Step up
Return

3Joy10_FlapsStepDown_FlapsDown:
3Joy10:: ; HOTAS_Thrust_HU
  ; Flaps Step down
Return

3Joy11_ParkingBrake_Gear:
3Joy11:: ; HOTAS_Thrust_UL
  ; If PBRAKE
  ; {
  ; 	PBRAKE :=  0
  ; 	NumPut(PBRAKE, PBRAKE, 0, "short")
  ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC8, int, 2, short, &PBRAKE, int, &dwResult)
  ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
  ; 	Send {Ctrl Down}.{Alt Up}{Shift Up}{Ctrl Up}
  ; 	; Err := _CMD("parking brake off")
  ; }
  ; Else
  ; {
  ; 	PBRAKE :=  32000
  ; 	NumPut(PBRAKE, PBRAKE, 0, "short")
  ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC8, int, 2, short, &PBRAKE, int, &dwResult)
  ; 	Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
  ; 	Send {Ctrl Down}.{Alt Up}{Shift Up}{Ctrl Up}
  ; 	; Err := _CMD("parking brake on")
  ; }

Return

^.:: ; TODO:
  If PBRAKE
  {
    PBRAKE := 0
    NumPut(PBRAKE, PBRAKE, 0, "short")
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC8, int, 2, short, &PBRAKE, int, &dwResult)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
    Send {Ctrl Down}.{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _CMD("parking brake off")
  }
  Else
  {
    PBRAKE := 32000
    NumPut(PBRAKE, PBRAKE, 0, "short")
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0BC8, int, 2, short, &PBRAKE, int, &dwResult)
    Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Process", uint, &dwResult)
    Send {Ctrl Down}.{Alt Up}{Shift Up}{Ctrl Up}
    ; Err := _CMD("parking brake on")
  }

Return

3Joy12_TPstandby_Autostart:
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

  Err := _CMD("transponder mode standby")
  Err := _CMD("strobe and landing lights off")
  Err := _CMD("flaps full up")
Return

4Joy1_:
4Joy1::
  _Message("4Joy1", 3)
Return
4Joy2_:
4Joy2::
  _Message("4Joy2", 3)
Return
4Joy3_:
4Joy3::
  _Message("4Joy3", 3)
Return
4Joy4_:
4Joy4::
  _Message("4Joy4", 3)
Return
4Joy5_:
4Joy5::
  _Message("4Joy5", 3)
Return
4Joy6_:
4Joy6::
  _Message("4Joy6", 3)
Return

4Joy7_Speech:
4Joy7::
  _Message("4Joy7", 3)
Return
4Joy8_ATC:
4Joy8::
  _Message("4Joy8", 3)
Return
4Joy9_Cecklist_OK:
4Joy9::
  _Message("4Joy9", 3)
Return

4Joy10_Course_down:
4Joy10::
  Send {Ctrl Down}{Numpad1}{Ctrl Up}
  _Message("Course down", 0)
Return
4Joy11_Course_up:
4Joy11::
  _Message("Course up", 0)
Return

4Joy12_Speed_down:
4Joy12::
  Send {Ctrl Down}{NumpadEnd}{Ctrl Up}
  ; _Message("speed down", 0)
Return
4Joy13_Speed_up:
4Joy13::
  Send {Ctrl Down}{NumpadHome}{Ctrl Up}
  ; _Message("speed up", 0)
Return

4Joy14_Heading_down:
4Joy14::
  Send {Ctrl Down}{NumpadLeft}{Ctrl Up}
  ; _Message("Heading down", 0)
Return
4Joy15_Heading_up:
4Joy15::
  Send {Ctrl Down}{NumpadRight}{Ctrl Up}
  ; _Message("Heading up", 0)
Return

4Joy16_Altitude_down:
4Joy16::
  Send {Ctrl Down}{NumpadDown}{Ctrl Up}
  ; _Message("speed down", 0)
Return
4Joy17_Altitude_up:
4Joy17::
  Send {Ctrl Down}{NumpadUp}{Ctrl Up}
  ; _Message("speed up", 0)
Return

4Joy18_VS_down:
4Joy18::
  Send {Ctrl Down}{NumpadPgdn}{Ctrl Up}
  ; _Message("speed down", 0)
Return
4Joy19_VS_up:
4Joy19::
  Send {Ctrl Down}{NumpadPgup}{Ctrl Up}
  ; _Message("speed up", 0)
Return

KEYBOARD_SECTION:
  ; *		= wird immer ausgelöst auch wenn modifikaton
  ; $ 	= keine rekursion
  ; ~  	= Taste weiterleiten
  ; + 	= [Shift]-Taste
  ; ^ 	= [Ctrl]-Taste
  ; ! 	= [QALT]-Taste
  ; # 	= [Win] -Taste
  ; <# 	= [Left Win Taste]
Return

_NUMPAD_Send(ScreenX, KeyX) {
  WinActivate, %Aktu_Sim%

  If Screen7_On
  {
    Gosub Screen7
    Return
  }	

  Send {%KeyX%} 
  ; Send {%KeyX% Down} 
  Last_Screen := Aktu_Screen
  Aktu_Screen := ScreenX
  ; Sleep, 100
  ; Send {%KeyX% Up} 
Return
}

Screen7:
NumpadHome::
  ; Numpad7::
  Screen7_On := Not Screen7_On

  _Message("Numpad7", 0)

  Send {Home} 
  Last_Screen := Aktu_Screen
  Aktu_Screen := 7
Return

Screen8:
$NumpadUp::
  ; Numpad8::
  _Message("Numpad8", 0)

  ; send {Numpad8}

  _NUMPAD_Send(8, "NumpadUp")
Return

Screen9:
NumpadPgUp::
  ; Numpad9::
  _Message("Numpad9", 0)

  ; send {Numpad9}
  _NUMPAD_Send(9, "PgUp")
Return

Screen4:
$NumpadLeft::
  ; Numpad4::
  _Message("Numpad4", 0)

  ; Send {Numpad4}
  _NUMPAD_Send(4, "NumpadLeft")
Return

Screen5:
$NumpadClear::
  ; Numpad5::
  _Message("Numpad5", 0)

  ; send {Numpad5}
  _NUMPAD_Send(5, "NumpadClear")
Return

Screen6:
$NumpadRight::
  ; Numpad6::
  _Message("Numpad6", 0)

  ; send {Numpad6}
  _NUMPAD_Send(6, "NumpadRight")
Return

Screen1:
NumpadEnd::
  ; Numpad1::
  _Message("Numpad1", 0)

  ; send {Numpad1}
  _NUMPAD_Send(1, "NumpadEnd")
Return

Screen2:
NumpadDown::
  ; Numpad2::
  _Message("Numpad2", 0)

  ; send {Numpad2}
  _NUMPAD_Send(2, "NumpadDown")
Return

Screen3:
NumpadPgDn::
  ; Numpad3::
  _Message("Numpad3", 0)

  ; send {Numpad3}
  _NUMPAD_Send(3, "NumpadPgDn")
Return

Screen0:
NumpadIns::
  ; Numpad0::
  _Message("Numpad0", 0)

  ; send {Numpad0}
  _NUMPAD_Send(0, "NumpadIns")
Return

ScreenDel:
NumpadDel::
  ; NumpadDel::
  Screen7_On := Not Screen7_On ; Problem mit TopDown Screen

  ; CoordMode, Mouse, Screen
  ; Click,right, 1919,35
  ; MouseMove, 1930,5,0
Return
