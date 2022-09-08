; Common_CMD_P3D_2022_09_05
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
Else If (CMD_Text="gear up") {

  Send g
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="gear down") {

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
Else If (CMD_Text="autostart") { ; GA- Engines

  Send {Ctrl Down}e{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="avatar on") {

  Send {Shift Down}{Ctrl Down}e{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="avatar off") {

  Send {Shift Down}{Ctrl Down}e{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
;
; Diffs zu CMD_XP
;
Else If (CMD_Text="reset heading") {

  Send d
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="reset baro") {

  Send b
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="open main door") {

  Send {Shift Down}e{Shift Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="close main door") {

  Send {Shift Down}e{Shift Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="push jetway") {

  Send {Tab Down}s{Tab Up} ; "auto jetway
  Send {Ctrl Down}j{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}

Else If (CMD_Text="push back") {

  ; Send {Shift Down}p{Shift Up}
  transform, PUSHBACK, Chr, 0
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x31f4, uint, 2, uint, &PUSHBACK, uint, &dwResult)
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="push right") {

  transform, PUSHBACK, Chr, 1
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x31f4, uint, 2, uint, &PUSHBACK, uint, &dwResult)
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="push left") {

  transform, PUSHBACK, Chr, 2
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x31f4, uint, 2, uint, &PUSHBACK, uint, &dwResult)
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="stop push back") {

  transform, PUSHBACK, Chr, 3
  Err := DllCall(FSUIPC_LibPfad . "\FSUIPC_Write", uint, 0x31f4, uint, 2, uint, &PUSHBACK, uint, &dwResult)
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="reset view") {

  Send {Ctrl Down}{Space}{Ctrl Up}{Backspace} ; reset view P3D
  Send {Ctrl Down}{Enter}{Ctrl Up} ; reset view when Lorby not minimized

  loop ,%MAX_TOOLTIPS% ; Statusanzeige zurücksetzen
    TTex_oFSVAR[A_Index ] := 999
}
Else If (CMD_Text="last view") {

  Send %Last_Screen%
  ; Send {Ctrl Down}s{Ctrl Up}
  temp := Aktu_Screen
  Aktu_Screen := Last_Screen
  Last_Screen := temp
}
Else If (CMD_Text="transponder mode charlie") { ; LUA

  Send {Shift Down}{Ctrl Down}{Alt Down}x{Alt Up}{Shift Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}
Else If (CMD_Text="transponder mode standby") { ; LUA

  Send {Ctrl Down}{Alt Down}x{Alt Up}{Ctrl Up}
  Err := _Text_to_Speech(CMD_Text)
}