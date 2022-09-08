; Common_CMD_XP_2022_09_05
;
Else If (CMD_Text="flaps full up") {

  Send {F6 8}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="flaps step up") {

  Send {F6}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="flaps step down") {

  Send {F7}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="flaps full down") {

  Send {F7 8}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="gear down") {

  Send g
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="gear up") {

  Send g
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="parking brake on") {

  Send v
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="parking brake off") {

  Send v
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="autostart") { ; Engines

  Send {Shift Down}{Ctrl Down}e{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="take off trim") {

  Send {Shift Down}{Ctrl Down}{NumpadClear}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="reset aircraft scenario") { ; Lua Script

  If (Aktu_Sim == XPLANE)
  {
    Gosub Stop_Aircraft_Scenario		
    ; mit VATSIM_IVAO_Switch.lua -> XUIPC-plugin neu starten
    Send {Ctrl Down}{Alt Down}{NumpadDiv}{Alt Up}{Shift Up}{Ctrl Up}
    sleep, 3000	
    Gosub Start_Aircraft_Scenario		
  }	

}
;
; Diffs zu CMD_P3D
;
; Else If (CMD_Text="reset heading") {
; 	{
; 		Send d
; 		Err := _Text_to_Speech(CMD_Text)
; 	}
Else If (CMD_Text="run timer") {

  Send {Shift Down}{Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="stop timer") {

  Send {Ctrl Down}{Alt Down}u{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="reset timer") {

  Send {Shift Down}{Ctrl Down}u{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="baro standard") {

  Auto_Baro := True
  Send {Shift Down}{Ctrl Down}{Alt Down}q{Alt Up}{Shift Up}{Ctrl Up}
  STD_On := True
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="baro QNH") {

  Auto_Baro := False
  Send {Ctrl Down}{Alt Down}q{Alt Up}{Ctrl Up}
  STD_On := False
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="synchronised heading") {

  Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="switch radio") {

  Send {Shift Down}{Ctrl Down}{Alt Down}y{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="push back") {

  Send {Shift Down}{Ctrl Down}p{Shift Up}{Ctrl Up} ; Better pushback
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="stop push back") {

  Send {Ctrl Down}p{Ctrl Up} ; Better pushback
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="ground handling") {

  Send {Ctrl Down}s{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="tablet") {

  Send {Ctrl Down}5{Ctrl Up}
  ; Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="avi tab") {

  Send {Ctrl Down}5{Ctrl Up}
  ; Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="transponder mode charly") { ; ggf. LUA

  Send {Shift Down}{Ctrl Down}{Alt Down}x{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="transponder mode standby") { ; ggf. LUA

  Send {Ctrl Down}{Alt Down}x{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}