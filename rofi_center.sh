#!/bin/bash

# --- STATUS CHECKS ---
if [ "$(nmcli radio wifi)" = "enabled" ]; then
    WIFI_ICON="  On"  # Shorter text
else
    WIFI_ICON="✈ Off"
fi

if [ "$(rfkill list bluetooth | grep -q 'yes' && echo 'no' || echo 'yes')" = "yes" ]; then
    BT_ICON=" On"
else
    BT_ICON=" Off"
fi

if [ "$(pamixer --get-mute)" = "true" ]; then
    AUDIO_ICON=" Muted"
else
    AUDIO_ICON=" 100%"
fi

# --- THE GRID ---
# We use shorter names to fit the tiles perfectly
OPTIONS="$WIFI_ICON\n$BT_ICON\n$AUDIO_ICON\n  Snap\n  Lock\n  Power"

# --- OPEN ROFI ---
# (Keep the rest of your script logic below this the same...)
SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Control" -theme ~/.config/rofi/control_center.rasi)

# --- ACTIONS (Update the case statement to match new labels) ---
case "$SELECTED" in
    *"  On")
        nmcli radio wifi off
        ;;
    *"✈ Off")
        nmcli radio wifi on
        ;;
    *" On")
        rfkill block bluetooth
        ;;
    *" Off")
        rfkill unblock bluetooth
        ;;
    *" 100%")
        pactl set-sink-mute @DEFAULT_SINK@ 1
        ;;
    *" Muted")
        pactl set-sink-mute @DEFAULT_SINK@ 0
        ;;
    *"  Snap")
        grim -g "$(slurp)"
        ;;
    *"  Lock")
        hyprlock
        ;;
    *"  Power")
        wlogout
        ;;
esac
