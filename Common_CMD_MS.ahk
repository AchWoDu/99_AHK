; Common_CMD_P3D_2022_09_09
; 
Else If (CMD_Text="flaps full up") {

  Send {F5}
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

  Send {F8}
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

  Send {Ctrl Down}.{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text) 
}
Else If (CMD_Text="parking brake off") {

  Send {Ctrl Down}.{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="autostart") { ; Engines

  ; Send {Shift Down}{Ctrl Down}e{Alt Up}{Shift Up}{Ctrl Up} ; autostop
  Send {Ctrl Down}e{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
;
; Diffs zu CMD_XP
;
Else If (CMD_Text="reset heading") {

  Send d
  Err := _Text_to_Speech(CMD_Text)
}
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
  Send {Shift Down}{Ctrl Down}{Alt Down}q{Shift Up}{Ctrl Up}{Alt Up}
  STD_On := True
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="baro QNH") {

  Auto_Baro := False
  Send b
  ; Send {Ctrl Down}{Alt Down}q{Ctrl Up}{Alt Up}
  STD_On := False
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="synchronised heading") {

  Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up}
  Send {Shift Down}{Ctrl Down}{Alt Down}h{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="switch radio") {

  Send {Shift Down}{Ctrl Down}{Alt Down}y{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="push back") {

  Run, "D:\Games\00_FS_ORDNER\20_TOOLS\00_MSFS_TOOLS\PushBack-helper\PushbackHelper.exe",,Hide

  NoWinactivate := True
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="stop push back") {

  ; Send {Ctrl Down}p{Ctrl Up}
  Err := _Text_to_Speech("not implementet") 
}
Else If (CMD_Text="transponder mode charlie") { 

  MSFS_TP := 0x0B46

  NumPut(4, MSFS_TP, 0, "short") ; 4 = ON

  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0B46, int, 1, short, &MSFS_TP, int, &dwResult)

  Err := _Text_to_Speech(CMD_Text)

}
Else If (CMD_Text="transponder mode standby") { 

  MSFS_TP := 0x0B46

  NumPut(1, MSFS_TP, 0, "short") ; 1 = OFF
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", int, 0x0B46, int, 1, short, &MSFS_TP, int, &dwResult)

  Err := _Text_to_Speech(CMD_Text)

}