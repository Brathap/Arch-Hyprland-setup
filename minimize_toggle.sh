#!/bin/bash
# Move the currently active window to the special workspace
hyprctl dispatch movetoworkspace special:minimized

# Then, toggle the special workspace. 
# Since the workspace is already active (by the move command), 
# this second command will hide the workspace, revealing your empty desktop.
hyprctl dispatch togglespecialworkspace minimized
