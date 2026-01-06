# 🌌 Arch-Hyprland Cyber-Setup & J.A.R.V.I.S.

Welcome to my personal **Arch Linux** configuration. This repository contains my dotfiles for **Hyprland** and the source code for **J.A.R.V.I.S. Rectified**, a custom AI desktop assistant.

![Desktop Screenshot](screenshot.png)
*(Replace this with your actual desktop screenshot)*

## 🛠️ The Tech Stack
* **OS:** Arch Linux
* **Window Manager:** Hyprland
* **Terminal:** Kitty (Catppuccin/Neon Themes)
* **Bar:** Waybar (Tokyo Night / Custom CSS)
* **Launcher:** Rofi (Custom "Cyber-Shards" & "Holo-Deck" themes)
* **AI:** J.A.R.V.I.S. (Python + Tkinter)

---

## 🤖 Feature: J.A.R.V.I.S. Rectified
Located in `hypr/jarvis.py`, this is a voice-controlled AI integrated into the desktop.

* **Reactive HUD:** Sci-fi visual interface that pulses with voice input.
* **Automation:**
    * **WhatsApp:** Auto-send messages via web automation.
    * **Web:** Voice search for Google, YouTube, and GitHub.
    * **Typing:** Dictate text to be typed into any window.
* **Brain:** Powered by Pollinations.ai for multi-model LLM responses.

### 🎤 Jarvis Commands
| Voice Command | Action |
| :--- | :--- |
| *"Open Google [query]"* | Searches Google |
| *"Send message to [name]"* | Automates WhatsApp Web |
| *"Type [text]"* | Types text after 4s delay |
| *"Wipe memory"* | Clears conversation history |

---

## 🎨 Feature: Dotfiles & Custom Scripts
This setup includes several custom Rofi scripts found in the `rofi/` folder:

* **Control Center:** A "Cosmic" dashboard for volume, wifi, and media controls.
* **Phone Portal:** A Python script (`phone_portal.py`) to share clipboard text between phone and PC via local HTTP.
* **Eco Mode:** One-click script (`eco_mode.sh`) to disable animations and dim the screen to save battery.
* **Wallpaper Engine:** Custom Rofi menu to switch wallpapers and effects.

---

## 📦 Installation

### 1. System Requirements
You need these packages installed on Arch Linux:
```bash
sudo pacman -S hyprland kitty waybar rofi python-tk xdotool mpv
pip install SpeechRecognition pyaudio
