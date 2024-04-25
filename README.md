# Power Panel

Power Panel is a script written in AutoIt, designed to automate common computer control functions, simplifying the daily tasks of managing system power and security. With the click of a button or a selection from the menu, users can effortlessly initiate actions such as shutting down or restarting their computer, putting it to sleep, or locking the screen. Whether it's powering down at the end of the day or securing the screen during breaks, Power Panel streamlines the user experience, enhancing productivity and peace of mind.

![power panel](https://hackmd.io/_uploads/rk2--NPZC.png)

# Features
**User-friendly GUI:** Provides a graphical interface with buttons for common computer control functions.
**Menu Bar:** Offers options to access functions and display system information.
**Functionality:**
*   Shutdown: Initiates a system shutdown.
*   Restart: Triggers a system restart.
*   Sleep: Puts the computer into sleep mode.
*   Lock Screen: Locks the computer screen.

**How It Works**

Upon execution, the Power Panel GUI window is displayed, featuring buttons labeled with the respective actions they perform. Users can click on the buttons to trigger the desired actions. Additionally, the script includes a menu bar with options to access these functions and display system information.

**Implementation Details**

The script is written in AutoIt, a scripting language designed for automating the Windows graphical user interface and general scripting. It utilizes AutoIt's built-in functions and libraries to create the graphical interface, handle user interactions, and execute system commands.
 
**Code Overview**

The codebase is structured for clarity and modularity, making it easy for developers to understand and extend. Detailed comments are provided within the code to facilitate comprehension and modification.

```AutoIt 
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
``` 

**Getting Started**

To use Power Panel, follow these steps:

Clone the repository to your local machine.
Run the power_panel.au3 script using AutoIt.

**Downloading the Binary**

You can download the executable binary directly from this GitHub repository. Follow these steps to get started:

Go to the [Releases](https://github.com/Gexos/Power-Panel/releases) page of this repository.

Find the latest release version and click on it to expand.

Verify Integrity: For added security, you can verify the integrity of the downloaded binary using checksums provided in the release notes.

Run the Binary: Once downloaded, you can execute the binary on your system according to the instructions provided in the project documentation.

If you encounter any issues during the download or execution process, feel free to open an issue on this repository for assistance.

**Contributing**

Contributions to Power Panel are highly encouraged! If you have any suggestions for enhancements, bug fixes, or feature requests, please feel free to submit pull requests or open issues on the GitHub repository.

**License**

This project is licensed under the MIT License.


Author

Giorgos Xanthopoulos (gexos)