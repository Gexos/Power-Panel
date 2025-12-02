# Power Panel

Power Panel is a small Windows utility that gives you quick, one-click access to common power actions like **Shutdown**, **Restart**, **Sleep**, **Hibernate**, **Lock**, and **Sign out** – plus optional **timed shutdown and restart** with a simple delay selector.

It’s designed to be simple, fast, and portable: drop the EXE on your desktop, taskbar, or USB stick and you’re ready to go.

---

## Features

- **One-click power actions:**
  - Shutdown now
  - Restart now
  - Sleep
  - Hibernate
  - Lock workstation
  - Sign out / Log off

- **Timed power actions:**
  - Schedule a shutdown after a delay
  - Schedule a restart after a delay
  - Delay presets via dropdown: **1, 5, 10, 15, 30, 60 minutes**
  - Cancel any scheduled shutdown/restart with a single button

- **Fast and lightweight**
  - No installer, no bloat – just a single EXE

- **Portable**
  - Runs from any folder or USB drive

- **Clean, minimal GUI**
  - Simple layout with clearly labeled buttons

- **No system modifications**
  - Does not touch the registry or change system settings

---

## Requirements

- **OS:** Windows 10 / 11  
- **Architecture:** 64-bit recommended  
- **Dependencies:** None (just the EXE)

---

## Download

You can download the latest version from the **Releases** page:

👉 Go to the **Releases** section of this repository and grab the newest `PowerPanel.exe`.

---

## Usage

1. Download `PowerPanel.exe` from the Releases page.
2. Place it anywhere you like (Desktop, Tools folder, USB stick, etc.).
3. Run it and use the buttons:

### Instant actions

- **Shutdown now** – immediately shuts down the computer.  
- **Restart now** – immediately restarts the computer.  
- **Sleep** – puts the system to sleep (if supported by your power settings).  
- **Hibernate** – hibernates the system (if enabled).  
- **Lock** – locks the current Windows session.  
- **Sign out** – signs out the current user.

Tip: Actions like Shutdown and Restart happen quickly. Make sure you’ve saved your work before using them.

### Timed actions

1. Choose a delay in **minutes** from the dropdown: `1, 5, 10, 15, 30, 60`.
2. Click **Schedule shutdown** or **Schedule restart**.
3. A small message will confirm that a timer was set.
4. If you change your mind, click **Cancel timer** to abort any pending shutdown/restart.

Under the hood, the app uses the built-in Windows `shutdown.exe` tool with `/t` (timer) and `/a` (abort) options.


## Antivirus / False Positives

Power Panel is written in **AutoIt** and compiled as a small EXE.  
Sometimes, antivirus tools may incorrectly flag small, custom utilities as suspicious because they are:

- Not widely known
- Packed into a single executable
- Built with scripting languages like AutoIt

If this happens:

- Verify the file hash from your trusted download source (this repository or gexsoft.org).
- Add an exception in your antivirus for the tool if you trust it.
- You can also compile the EXE yourself from the source code if you have it.

---

## Building from Source

Power Panel is written in **AutoIt**.

To build it yourself:

1. Install AutoIt and SciTE (AutoIt’s editor).
2. Clone or download this repository.
3. Open the `.au3` script in SciTE.
4. Click **Tools → Compile** to generate the EXE.

---

## Roadmap / Ideas

- Tray icon mode
- Configurable hotkeys
- Optional confirmation dialogs for timed actions
- Dark/light theme toggle
