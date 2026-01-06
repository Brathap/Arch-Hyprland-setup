#!/bin/bash
# CONFIG
theme="$HOME/.config/rofi/cyber_card.rasi"

# --- PART 1: CONTROL TILES (Top of the screen) ---
# We use the same icons so they match your theme
vol_up="   VOL UP"
vol_down="   VOL DOWN"
wifi="   WIFI"
apps="   APPS"
shot="   SHOT"
lock="   LOCK"
mute="   MUTE"
clear="   CLEAR LOGS"
exit="   EXIT"
blue="   BLUE LINK"
eco="🍃 ECO MODE"

# Combine controls into the first part of the list
# Note: We put 'Clear' near the end to separate controls from logs
controls="$vol_up\n$vol_down\n$mute\n$wifi\n$blue\n$shot\n$apps\n$lock\n$eco\n$clear\n$exit"

# --- PART 2: NOTIFICATION TILES (Bottom of the screen) ---
# We grab notifications and turn them into "Buttons"
# Format: "💬 App Name \n Message Preview"
notifications=$(dunstctl history | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)['data'][0]
    # Get last 6 notifications (so it fits on screen)
    for n in reversed(data[-3:]):
        app = n['appname']['data']
        # Cut message to 15 chars so it fits in the tile
        body = n['body']['data'].replace('\n', ' ')[:15]
        # Print as a Tile Item
        print(f'💬 {app}\n{body}...')
except:
    pass
")

# --- PART 3: MERGE THEM ---
if [ -z "$notifications" ]; then
    # If no messages, just show controls
    display_list="$controls"
else
    # Show Controls FIRST, then Notifications below
    display_list="$controls\n$notifications"
fi

# --- PART 4: LAUNCH ROFI ---
# 'row-tab' is not needed, just standard dmenu mode
selected="$(echo -e "$display_list" | rofi -dmenu -theme "$theme" -p "CONTROL CENTER")"

# --- PART 5: ACTIONS ---
case $selected in
    $vol_up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
    $vol_down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    $wifi) kitty -e nmtui ;;
    $apps) rofi -show drun -theme "$theme" ;;
    $shot) grim ~/Pictures/Screenshot_$(date +%s).png ;;
    $lock) pidof hyprlock || hyprlock ;;
    $mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    $exit) exit 0 ;;
    $blue)
    # 1. Kill old server
    pkill -f phone_portal.py

    # 2. Start Python Server
    python3 ~/.config/rofi/phone_portal.py &

    # 3. Show Connection Info (Wait 2s for IP to settle)
    sleep 2
    # Auto-detect the IP starting with 192 (Bluetooth PAN usually uses this range)
    ip=$(ip -4 addr show | grep -oP '(?<=inet\s)192\.168\.\d+\.\d+' | head -n 1)

    # Show QR Code or Text
    kitty --title "Bluetooth Uplink" --hold -e bash -c "echo 'SCAN OR TYPE:'; echo 'http://$ip:8000'; qrencode -t ANSI 'http://$ip:8000'; echo 'Server Active...'; sleep 3600" &
    ;;
    # Clear History
    $clear) 
        dunstctl history-clear
        notify-send "System" "All messages deleted"
        ;;
    
    $eco)
    ~/.config/rofi/eco_mode.sh &
    ;;
        
    # Clicking a Notification Tile
    *)
        if [[ "$selected" == *"💬"* ]]; then
            # Copy the message content to clipboard
            echo "$selected" | xclip -selection clipboard
            notify-send "Copied" "Message saved to clipboard"
        fi
        ;;

esac
