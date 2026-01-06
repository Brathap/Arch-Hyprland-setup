#!/bin/bash

# --- ICONS & STATUS ---
# WiFi
if [ "$(nmcli radio wifi)" = "enabled" ]; then
    WIFI="  WiFi On"
else
    WIFI="✈ WiFi Off"
fi

# Bluetooth
if [ "$(rfkill list bluetooth | grep -q 'yes' && echo 'no' || echo 'yes')" = "yes" ]; then
    BT=" BT On"
else
    BT=" BT Off"
fi

# Audio
VOL=$(pamixer --get-volume)
if [ "$(pamixer --get-mute)" = "true" ]; then
    AUDIO=" Muted"
else
    AUDIO=" $VOL%"
fi

# Brightness
BRIGHT=$(brightnessctl g)
MAX=$(brightnessctl m)
PERC=$(( BRIGHT * 100 / MAX ))
LIGHT=" $PERC%"

# --- THE BUTTON GRID ---
# We lay them out in order
OPTIONS="$WIFI\n$BT\n$AUDIO\n$LIGHT\n  Screenshot\n  Random Wall\n  Vol -\n  Vol +\n  Media Play\n  Lock\n  Power"

# --- OPEN ROFI DASHBOARD ---
# Select theme
SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Dashboard" -theme ~/.config/rofi/dashboard.rasi)

# --- ACTIONS ---
case "$SELECTED" in
    *"WiFi On") nmcli radio wifi off ;;
    *"WiFi Off") nmcli radio wifi on ;;
    *"BT On") rfkill block bluetooth ;;
    *"BT Off") rfkill unblock bluetooth ;;
    *"Muted") pactl set-sink-mute @DEFAULT_SINK@ 0 ;;
    *"%") pactl set-sink-mute @DEFAULT_SINK@ 1 ;; # Click volume to mute
    *"Vol -") pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    *"Vol +") pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    *"Screenshot") grim -g "$(slurp)" ;;
    *"Lock") hyprlock ;;
    *"Power") wlogout ;;
    *"Random Wall") ~/.config/hypr/scripts/wallpaper_engine.sh ;; # Triggers your randomizer if setup
    *"Media Play") playerctl play-pause ;;
esac
