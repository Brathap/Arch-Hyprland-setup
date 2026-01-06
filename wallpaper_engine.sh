#!/bin/bash

# Directory where your wallpapers are (1.png, 2.png, etc.)
DIR="$HOME/Pictures/Workspaces"

# Ensure the engine is running
swww-daemon --format xrgb &

# Function to switch wallpaper
change_wall() {
    local ws=$1
    # Find the image (png, jpg, or jpeg)
    if [ -f "$DIR/$ws.png" ]; then img="$DIR/$ws.png";
    elif [ -f "$DIR/$ws.jpg" ]; then img="$DIR/$ws.jpg";
    elif [ -f "$DIR/$ws.jpeg" ]; then img="$DIR/$ws.jpeg";
    else return; fi # No image found, do nothing

    # SWITCH INSTANTLY (No transition)
    swww img "$img" --transition-type grow --transition-pos 0.5,0.5 --transition-step 90 --transition-fps 60
}

# Listen to Hyprland socket for workspace changes (Zero Latency)
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ $line == "workspace>>"* ]]; then
        # Extract the workspace ID (e.g., from "workspace>>2" -> "2")
        ws=${line#*>>}
        change_wall "$ws"
    fi
done
