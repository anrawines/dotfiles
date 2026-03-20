#!/bin/bash
CURRENT_THEME=$(cat "$HOME/.config/i3/.current_theme")
STATE_FILE="/tmp/polybar-state"
# 1. Path to your custom config
#CONFIG_PATH="/home/lenoarch/.config/i3/polybar/themes/candy/launch.sh"
CONFIG_PATH="$HOME/.config/i3/polybar/themes/$CURRENT_THEME/launch.sh"
# 2. The actual name of the bar defined inside your config file (e.g., [bar/mybar])
BAR_NAME="main"

toggle() {
    # Initialize state file if missing
    [[ ! -f "$STATE_FILE" ]] && echo "on" > "$STATE_FILE"
    
    current=$(cat "$STATE_FILE")

    if [ "$current" = "on" ]; then
        pkill polybar
        echo "off" > "$STATE_FILE"
        notify-send -i utilities-terminal "Polybar" "Disabled"
    else
        # Kill any ghost processes first
        pkill polybar
        
        # Launch using the explicit config path
        #polybar "$BAR_NAME" -c "$CONFIG_PATH" &
        bash "$CONFIG_PATH" &
        echo "on" > "$STATE_FILE"
        notify-send -i utilities-terminal "Polybar" "Enabled"
    fi
}

toggle

