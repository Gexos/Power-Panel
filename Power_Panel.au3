#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=PowerPanel.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>

; ==========================
;  App info (edit these)
; ==========================
Global Const $APP_NAME    = "Power Panel"
Global Const $APP_VERSION = "v1.0.0"
Global Const $APP_AUTHOR  = "Giorgos Xanthopoulos (gexos)"

Global Const $APP_OPENSOURCE = "Open-source Windows power control utility."

; Links (edit the GitHub URL to your real repo)
Global Const $URL_BLOG    = "https://gexos.org"
Global Const $URL_GEXSOFT = "https://gexsoft.org"
Global Const $URL_GITHUB  = "https://github.com/Gexos/Power-Panel" ; change this

; ==========================
;  Globals
; ==========================
Global $hGUI

Global $btnShutdownNow, $btnRestartNow, $btnSleep, $btnHibernate, $btnLock, $btnSignOut
Global $lblInstant, $lblTimed, $lblDelay, $cDelay
Global $btnScheduleShutdown, $btnScheduleRestart, $btnCancelTimer, $btnAbout

; ==========================
;  Main window
; ==========================

$hGUI = GUICreate($APP_NAME, 430, 270, -1, -1, _
    BitOR($WS_CAPTION, $WS_SYSMENU, $WS_MINIMIZEBOX))

; ---------- Instant actions ----------
$lblInstant = GUICtrlCreateLabel("Instant actions", 20, 15, 200, 15, $SS_LEFT)

$btnShutdownNow = GUICtrlCreateButton("Shutdown now", 20, 40, 120, 35)
$btnRestartNow  = GUICtrlCreateButton("Restart now", 155, 40, 120, 35)
$btnSignOut     = GUICtrlCreateButton("Sign out", 290, 40, 120, 35)

$btnSleep       = GUICtrlCreateButton("Sleep", 20, 80, 120, 35)
$btnHibernate   = GUICtrlCreateButton("Hibernate", 155, 80, 120, 35)
$btnLock        = GUICtrlCreateButton("Lock", 290, 80, 120, 35)

; ---------- Timed actions ----------
$lblTimed = GUICtrlCreateLabel("Timed actions", 20, 130, 200, 15, $SS_LEFT)

$lblDelay = GUICtrlCreateLabel("Delay:", 20, 160, 45, 20, $SS_LEFT)
$cDelay   = GUICtrlCreateCombo("5", 70, 158, 60, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData($cDelay, "1|5|10|15|30|60", "5")
GUICtrlCreateLabel("minute(s)", 135, 160, 70, 20, $SS_LEFT)

$btnScheduleShutdown = GUICtrlCreateButton("Schedule shutdown", 220, 150, 120, 35)
$btnScheduleRestart  = GUICtrlCreateButton("Schedule restart", 220, 190, 120, 35)

$btnCancelTimer      = GUICtrlCreateButton("Cancel timer", 20, 200, 120, 35)

; ---------- About ----------
$btnAbout            = GUICtrlCreateButton("About", 350, 200, 60, 35)

GUISetState(@SW_SHOW, $hGUI)

; ==========================
;  Main loop
; ==========================

While 1
    Local $msg = GUIGetMsg()

    Switch $msg
        Case $GUI_EVENT_CLOSE
            ExitLoop

        Case $btnShutdownNow
            _ShutdownNow()

        Case $btnRestartNow
            _RestartNow()

        Case $btnSleep
            _SleepNow()

        Case $btnHibernate
            _HibernateNow()

        Case $btnLock
            _LockNow()

        Case $btnSignOut
            _SignOutNow()

        Case $btnScheduleShutdown
            _ScheduleShutdown()

        Case $btnScheduleRestart
            _ScheduleRestart()

        Case $btnCancelTimer
            _CancelTimer()

        Case $btnAbout
            _ShowAbout()
    EndSwitch
WEnd

GUIDelete($hGUI)

; ==========================
;  Helper functions
; ==========================

Func _ConfirmAndRun($sTitle, $sMessage, $sCommand)
    Local $answer = MsgBox(33, $sTitle, $sMessage)
    If $answer = 1 Then
        Run($sCommand, "", @SW_HIDE)
    EndIf
EndFunc

Func _ShutdownNow()
    _ConfirmAndRun("Confirm shutdown", _
        "Are you sure you want to SHUT DOWN the computer now?", _
        "shutdown.exe /s /t 0")
EndFunc

Func _RestartNow()
    _ConfirmAndRun("Confirm restart", _
        "Are you sure you want to RESTART the computer now?", _
        "shutdown.exe /r /t 0")
EndFunc

Func _SleepNow()
    ; Try to put the system to sleep using PowrProf.dll
    Local $aRet = DllCall("PowrProf.dll", "int", "SetSuspendState", _
        "int", 0, "int", 0, "int", 0)

    If @error Then
        MsgBox(16, "Error", "Failed to put system to sleep (not supported or blocked).")
    EndIf
EndFunc

Func _HibernateNow()
    ; Hibernate using built-in shutdown tool
    Run("shutdown.exe /h", "", @SW_HIDE)
EndFunc

Func _LockNow()
    ; Lock the workstation
    Run("rundll32.exe user32.dll,LockWorkStation", "", @SW_HIDE)
EndFunc

Func _SignOutNow()
    _ConfirmAndRun("Confirm sign out", _
        "Are you sure you want to SIGN OUT the current user?", _
        "shutdown.exe /l")
EndFunc

Func _GetDelaySeconds()
    Local $sVal = GUICtrlRead($cDelay)
    Local $iMinutes = Int($sVal)

    If $iMinutes <= 0 Then
        MsgBox(48, "Invalid value", "Please select a valid delay in minutes.")
        Return SetError(1, 0, 0)
    EndIf

    Return $iMinutes * 60
EndFunc

Func _ScheduleShutdown()
    Local $iSeconds = _GetDelaySeconds()
    If @error Then Return

    Local $iMinutes = $iSeconds / 60
    Local $sCmd = "shutdown.exe /s /t " & $iSeconds

    Local $rc = Run($sCmd, "", @SW_HIDE)
    If $rc = 0 Then
        MsgBox(16, "Error", "Failed to schedule shutdown.")
    Else
        MsgBox(64, "Timer set", _
            "Shutdown scheduled in " & $iMinutes & " minute(s)." & @CRLF & _
            "You can cancel it with the 'Cancel timer' button.")
    EndIf
EndFunc

Func _ScheduleRestart()
    Local $iSeconds = _GetDelaySeconds()
    If @error Then Return

    Local $iMinutes = $iSeconds / 60
    Local $sCmd = "shutdown.exe /r /t " & $iSeconds

    Local $rc = Run($sCmd, "", @SW_HIDE)
    If $rc = 0 Then
        MsgBox(16, "Error", "Failed to schedule restart.")
    Else
        MsgBox(64, "Timer set", _
            "Restart scheduled in " & $iMinutes & " minute(s)." & @CRLF & _
            "You can cancel it with the 'Cancel timer' button.")
    EndIf
EndFunc

Func _CancelTimer()
    ; /a aborts any pending shutdown/restart timer
    Local $rc = Run("shutdown.exe /a", "", @SW_HIDE)
    If $rc = 0 Then
        MsgBox(48, "Cancel timer", _
            "No active shutdown/restart timer was found or abort is not allowed.")
    Else
        MsgBox(64, "Cancel timer", "Shutdown / restart timer has been cancelled.")
    EndIf
EndFunc

; ==========================
;  About window
; ==========================

Func _ShowAbout()
    Local $hAbout = GUICreate("About " & $APP_NAME, 360, 230, -1, -1, _
        BitOR($WS_CAPTION, $WS_SYSMENU), -1, $hGUI)

    Local $sInfo = $APP_NAME & " " & $APP_VERSION & @CRLF & _
        $APP_OPENSOURCE & @CRLF & @CRLF & _
        "Author: " & $APP_AUTHOR

    GUICtrlCreateLabel($sInfo, 20, 20, 320, 60, $SS_LEFT)

    GUICtrlCreateLabel("Links:", 20, 90, 100, 20, $SS_LEFT)

    Local $btnBlog    = GUICtrlCreateButton("Open blog",        20, 115, 100, 30)
    Local $btnGexSoft = GUICtrlCreateButton("Open gexsoft.org", 130, 115, 120, 30)
    Local $btnGitHub  = GUICtrlCreateButton("Open GitHub",      260, 115, 80, 30)

    Local $btnClose   = GUICtrlCreateButton("Close", 140, 165, 80, 30)

    GUISetState(@SW_SHOW, $hAbout)

    While 1
        Local $msg = GUIGetMsg()

        Switch $msg
            Case $GUI_EVENT_CLOSE, $btnClose
                ExitLoop

            Case $btnBlog
                ShellExecute($URL_BLOG)

            Case $btnGexSoft
                ShellExecute($URL_GEXSOFT)

            Case $btnGitHub
                ShellExecute($URL_GITHUB)
        EndSwitch
    WEnd

    GUIDelete($hAbout)
EndFunc
