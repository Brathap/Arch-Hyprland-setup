#!/bin/bash

# CONFIG
theme="$HOME/.config/rofi/notifications.rasi"

# 1. READ HISTORY (Using Python instead of jq)
# This script reads the JSON, grabs the latest notifications,
# reverses them (newest first), and formats them cleanly.
notifications=$(dunstctl history | python3 -c "
import sys, json
try:
    # Load Dunst History
    data = json.load(sys.stdin)['data'][0]
    # Loop through notifications in reverse (Newest top)
    for n in reversed(data):
        app = n['appname']['data']
        summary = n['summary']['data']
        # Remove newlines from body to keep list clean
        body = n['body']['data'].replace('\n', ' ')
        print(f'{app}   ::   {summary}   >>   {body}')
except:
    pass
")

# 2. HANDLE EMPTY HISTORY
if [ -z "$notifications" ]; then
    display_list="🚫   No New Logs"
else
    # Add Clear Button
    display_list="🗑️    CLEAR ALL LOGS\n$notifications"
fi

# 3. SHOW ROFI
selected=$(echo -e "$display_list" | rofi -dmenu -theme "$theme" -p "SYSTEM LOGS" -i)

# 4. ACTIONS
if [[ "$selected" == *"CLEAR ALL LOGS"* ]]; then
    dunstctl history-clear
    notify-send "System" "Logs Cleared"
elif [[ "$selected" == *"No New Logs"* ]]; then
    exit 0
elif [ ! -z "$selected" ]; then
    # Optional: Copy log to clipboard if clicked
    echo "$selected" | xclip -selection clipboard 2>/dev/null
fi
