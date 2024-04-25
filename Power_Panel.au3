#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>

; Declare global variables
Global $hGUI, $hMenu, $ID_SHOW_INFO = 1000, $ID_EXIT = 1001, $hInfoWindow

; Create the main GUI window
$hGUI = GUICreate("Power Panel", 400, 300)
GUISetBkColor(0x000080) ; Set background color to dark blue

; Create buttons for different computer control functions
Global $btnShutdown = GUICtrlCreateButton("Shutdown", 30, 30, 100, 30)
GUICtrlSetBkColor($btnShutdown, 0xFFFFFF) ; Set button background color to white
Global $btnRestart = GUICtrlCreateButton("Restart", 30, 80, 100, 30)
GUICtrlSetBkColor($btnRestart, 0xFFFFFF)
Global $btnSleep = GUICtrlCreateButton("Sleep", 30, 130, 100, 30)
GUICtrlSetBkColor($btnSleep, 0xFFFFFF)
Global $btnLock = GUICtrlCreateButton("Lock Screen", 30, 180, 100, 30)
GUICtrlSetBkColor($btnLock, 0xFFFFFF)

; Create labels for button information
Global $infoShutdown = GUICtrlCreateLabel("Shuts down the computer", 150, 30, 200, 30)
GUICtrlSetColor($infoShutdown, 0xFFFFFF) ; Set label text color to white
GUICtrlSetFont($infoShutdown, 10, 800) ; Set font size to 10 and weight to bold
Global $infoRestart = GUICtrlCreateLabel("Restarts the computer", 150, 80, 200, 30)
GUICtrlSetColor($infoRestart, 0xFFFFFF)
GUICtrlSetFont($infoRestart, 10, 800)
Global $infoSleep = GUICtrlCreateLabel("Puts the computer to sleep", 150, 130, 200, 30)
GUICtrlSetColor($infoSleep, 0xFFFFFF)
GUICtrlSetFont($infoSleep, 10, 800)
Global $infoLock = GUICtrlCreateLabel("Locks the computer screen", 150, 180, 200, 30)
GUICtrlSetColor($infoLock, 0xFFFFFF)
GUICtrlSetFont($infoLock, 10, 800)

; Create menu
$hMenu = GUICtrlCreateMenu("Menu")
Global $mnuShowInfo = GUICtrlCreateMenuItem("About", $hMenu, $ID_SHOW_INFO)
Global $mnuShutdown = GUICtrlCreateMenuItem("Shutdown", $hMenu)
Global $mnuRestart = GUICtrlCreateMenuItem("Restart", $hMenu)
Global $mnuSleep = GUICtrlCreateMenuItem("Sleep", $hMenu)
Global $mnuLock = GUICtrlCreateMenuItem("Lock Screen", $hMenu)
Global $mnuSystemInfo = GUICtrlCreateMenuItem("System Info", $hMenu)
GUICtrlCreateMenuItem("", $hMenu, 0)
Global $mnuExit = GUICtrlCreateMenuItem("Exit", $hMenu, $ID_EXIT)

; Show the main GUI window
GUISetState(@SW_SHOW)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit ; Exit the script when the main GUI window is closed
        Case $btnShutdown, $mnuShutdown
            Shutdown(1) ; Shutdown the computer when the "Shutdown" button is clicked or menu item is selected
        Case $btnRestart, $mnuRestart
            Shutdown(2) ; Restart the computer when the "Restart" button is clicked or menu item is selected
        Case $btnSleep, $mnuSleep
            DllCall("PowrProf.dll", "none", "SetSuspendState", "int", 0, "int", 0, "int", 0) ; Put the computer to sleep
        Case $btnLock, $mnuLock
            DllCall("user32.dll", "bool", "LockWorkStation") ; Lock the computer screen
        Case $mnuSystemInfo
            Run("msinfo32.exe") ; Open the System Information utility
        Case $mnuShowInfo
            ShowInfo() ; Show information about the program when "Show Info" is selected from the menu
        Case $mnuExit, $ID_EXIT
            Exit ; Exit the script when "Exit" is selected from the menu
    EndSwitch
WEnd

; Function to show information about the program
Func ShowInfo()
    $hInfoWindow = GUICreate("About", 400, 200)
    GUISetBkColor(0x000080) ; Set background color to dark blue

    ; Text explaining the purpose of the program
    $purposeText = "This program is designed to provide easy access to common computer control functions." & @CRLF & _
                   "It allows users to perform actions such as shutting down the computer, restarting it," & @CRLF & _
                   "putting it to sleep, and locking the screen." & @CRLF & _
                   "Author: Giorgos Xanthopoulos aka gexos" & @CRLF & _
                   "Version: 1.0"

    GUICtrlCreateLabel($purposeText, 10, 10, 380, 150)
    GUICtrlSetColor(-1, 0xFFFFFF) ; Set label text color to white
    GUICtrlSetFont(-1, 11, 400) ; Set font size to 10

    ; Show the information window
    GUISetState(@SW_SHOW, $hInfoWindow)

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($hInfoWindow) ; Close the information window when the close button is clicked
                Return
        EndSwitch
    WEnd
EndFunc
