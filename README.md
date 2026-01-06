# 🌌 Arch-Hyprland Cyber-Setup 

Welcome to my personal **Arch Linux** configuration. This repository contains my dotfiles for **Hyprland** 


## 🛠️ The Tech Stack
* **OS:** Arch Linux
* **Window Manager:** Hyprland
* **Terminal:** Kitty (Catppuccin/Neon Themes)
* **Bar:** Waybar (Tokyo Night / Custom CSS)
* **Launcher:** Rofi (Custom "Cyber-Shards" & "Holo-Deck" themes)

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
