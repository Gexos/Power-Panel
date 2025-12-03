# Power Panel

Power Panel is a small Windows utility that gives you quick, one-click access to common power actions like **Shutdown**, **Restart**, **Sleep**, **Hibernate**, **Lock**, and **Sign out** – without digging through the Start menu.

It’s designed to be simple, fast, and portable: drop the EXE on your desktop, taskbar, or USB stick and you’re ready to go.

---

## Features

- One-click power actions:
  - Shutdown
  - Restart
  - Sleep
  - Hibernate
  - Lock
  - Sign out / Log off
- Fast and lightweight – no installer, no bloat
- Portable – runs from any folder or USB drive
- Clean, minimal GUI with clearly labeled buttons
- No system modifications – does not touch the registry or change system settings

---

## Requirements

- OS: Windows 10 / 11  
- Architecture: 64-bit recommended  
- Dependencies: None (just the EXE)

---

## Download

You can download the latest version from the Releases page of this repository.

---

## Usage

1. Download `PowerPanel.exe` from the Releases page.
2. Place it anywhere you like (Desktop, Tools folder, USB stick, etc.).
3. Run it and click the button for the power action you want.
4. (Optional) Pin it to the taskbar or add it to your startup folder if you use it often.

Tip: Actions like Shutdown and Restart happen quickly. Make sure you’ve saved your work before using them.

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

