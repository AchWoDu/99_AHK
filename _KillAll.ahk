Version := "KillAll V.2022_10_29"

DEFINITIONEN:

  #NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
  ; #Warn ; Enable warnings to assist with detecting common errors.
  SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
  SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

  Err := _Is_admin()

  TrayTip, %Version% ,startet..., 2

  Gosub Kill_Start_Aircraft_File
  Gosub Kill_MFFS_Files
  Gosub Kill_P3D_Files
  Gosub Kill_XPlan_Files
  Gosub Kill_FS_Tools
  ; Gosub Kill_Allgem_Tools

  Run, "C:\Program Files\AutoHotkey\AutoHotkeyU32.exe" "d:\diverses\Scripte_AHK\PRIVATE.ahk"
ExitApp

Kill_Start_Aircraft_File:

  Process, Exist ,StartAircraft.exe
  If ErrorLevel {
    Process, Close ,StartAircraft.exe
    ToolTip Kill StartAircraft.exe
    Sleep, 1000
  }
Return

Kill_MFFS_Files:

  Process, Exist ,FlightSimulator.exe
  If ErrorLevel {
    Process, Close ,FlightSimulator.exe
    ToolTip Kill FlightSimulator.exe
    Sleep, 1000
  }

  Process, Exist ,FSUIPC7.exe
  If ErrorLevel {
    Process, Close ,FSUIPC7.exe
    ToolTip Kill FSUIPC7.exe
    Sleep, 1000
  }
Return

Kill_P3D_Files:

  Process, Exist ,P3D.exe
  If ErrorLevel {
    Process, Close ,P3D.exe
    ToolTip Kill P3D.exe
    Sleep, 1000
  }
  Process, Exist ,Prepar3D.exe
  If ErrorLevel {
    Process, Close ,Prepar3D.exe
    ToolTip Kill Prepar3D.exe
    Sleep, 1000
  }

  Process, Exist ,AS_P3Dv4.exe
  If ErrorLevel {
    Process, Close ,AS_P3Dv4.exe
    ToolTip Kill AS_P3Dv4.exe
    Sleep, 1000
  }

  Process, Exist ,AS Cloud Art.exe
  If ErrorLevel {
    Process, Close ,AS Cloud Art.exe
    ToolTip Kill Art.exe
    Sleep, 1000
  }

  Process, Exist ,SimObjectDisplayEngine.exe
  If ErrorLevel {
    Process, Close ,SimObjectDisplayEngine.exe
    ToolTip Kill SimObjectDisplayEngine.exe
    Sleep, 1000
  }

  Process, Exist ,CameraPositionX_P3D_V4.exe
  If ErrorLevel {
    Process, Close ,CameraPositionX_P3D_V4.exe
    ToolTip Kill CameraPositionX_P3D_V4.exe
    Sleep, 1000
  }
Return

Kill_XPlan_Files:

  Process, Exist ,X-Plane.exe
  If ErrorLevel {
    Process, Close ,X-Plane.exe
    ToolTip Kill X-Plane.exe
    Sleep, 1000
  }

  Process, Exist ,AS_XPL.exe ; Active Sky
  If ErrorLevel {
    Process, Close ,AS_XPL.exe
    ToolTip Kill AS_XPL.exe
    Sleep, 1000
  }

  While WinExist("WebFMC") {
    WinActivate, WebFMC
    Sleep, 1000
    send {ALT Down}{F4}{ALT Up}
  }
Return

Kill_FS_Tools:

  If WinExist("SimBrief.com") {
    ; _Message("SimBrief.com found!",3)
    WinActivate, SimBrief.com
    Sleep, 1000
    send {ALT Down}{F4}{ALT Up}
  }

  If WinExist("VATSIM map") {
    ; _Message("VATSIM map found!",3)
    WinActivate, VATSIM map
    Sleep, 1000
    send {ALT Down}{F4}{ALT Up}
  }

  If WinExist("Volanta") {
    ; _Message("Volanta found!",3)
    WinActivate, Volanta
    Sleep, 1000
    send {ALT Down}{F4}{ALT Up}
  }

  Process, Exist ,LittleNavMap.exe
  if ErrorLevel {
    Process, Close ,LittleNavMap.exe
    ToolTip Kill LittleNavMap.exe
    Sleep, 1000
  }

  Process, Exist ,vaBaseLive.exe
  If ErrorLevel {
    Process, Close ,vaBaseLive.exe
    ToolTip Kill vaBaseLive.exe
  }

  Process, Exist ,PilotUI.exe ; IVAO
  If ErrorLevel {
    Process, Close ,PilotUI.exe
    ToolTip Kill PilotUI.exe
    Sleep, 1000
  }

  Process, Exist ,VPilot.exe ; VATSIM
  If ErrorLevel {
    Process, Close ,VPilot.exe
    ToolTip Kill VPilot.exe
    Sleep, 1000
  }

  Process, Exist ,XPilot.exe ; VATSIM
  If ErrorLevel {
    Process, Close ,XPilot.exe
    ToolTip Kill X
    Pilot.exe
    Sleep, 1000
  }

  Process, Exist ,SimBrief Downloader.exe
  If ErrorLevel {
    Process, Close ,SimBrief Downloader.exe
    ToolTip Kill Simbrief Downloader
    Sleep, 1000
  }

  Process, Exist, AutoHotkey.exe
  If ErrorLevel {
    Process, Close, AutoHotkey.exe
    ToolTip Kill AutoHotkey.exe
    Sleep, 1000
  }

  Process, Exist, AutoHotkeyU32.exe
  If ErrorLevel {
    Process, Close, AutoHotkeyU32.exe
    ToolTip Kill AutoHotkeyU32.exe
    Sleep, 1000
  }

  Process, Exist, AutoHotkeyU64.exe
  If ErrorLevel {
    Process, Close ,AutoHotkeyU64.exe
    ToolTip Kill AutoHotkeyU64.exe
    Sleep, 1000
  }

  ; Process, Exist ,PRIVATE.exe
  ; If ErrorLevel
  ; {
  ;   Process, Close ,PRIVATE.exe
  ;   ToolTip Kill PRIVATE.exe
  ;   Sleep, 1000
  ; }

  ; Process, Exist ,ts3client_win64.exe
  ; If ErrorLevel {
  ; 	Process, Close ,ts3client_win64.exe
  ; 	ToolTip Kill ts3client_win64.exe
  ; 	Sleep, 1000
  ; }

  ; Process, Exist ,Discord.exe
  ; If ErrorLevel {
  ; 	Process, Close ,Discord.exe
  ; 	ToolTip Kill Discord
  ; 	Sleep, 1000
  ; }
Return

Kill_Allgem_Tools:

  Process, Exist ,fdm.exe
  If ErrorLevel {
    Process, Close ,fdm.exe
    ToolTip Kill Free Download Manager
    Sleep, 1000
  }

  Process, Exist, GoogleDriveFS.exe
  If ErrorLevel {
    Process, Close, GoogleDriveFS.exe.exe
    ToolTip Kill google drive
    Sleep, 500
    Process, Close, GoogleDriveFS.exe
    Sleep, 1000
  }

  Process, Exist , KeePass.exe
  If ErrorLevel {
    Process, Close ,KeePass.exe
    ToolTip Kill KeePass.exe
    Sleep, 1000
  }

  Process, Exist , PowerToys.exe
  If ErrorLevel {
    Process, Close ,PowerToys.exe
    ToolTip Kill PowerToys.exe
    Sleep, 1000
  }
Return

_Is_admin() {

  full_command_line := DllCall("GetCommandLine", "str")

  if Not (A_IsAdmin Or RegExMatch(full_command_line, " /restart(?!\S)")) {
    try {
      if A_IsCompiled
        Run *RunAs "%A_ScriptFullPath%" /restart
      else
        Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }

    ExitApp
  }
Return 0
}