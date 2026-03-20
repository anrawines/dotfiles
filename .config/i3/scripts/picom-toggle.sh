#!/usr/bin/env bash

STATE_FILE="/tmp/picom-state"
CONFIG_PATH="$HOME/.config/i3/picom/picom.pijulius.conf"

toggle() {
    # Check if config exists
    if [ ! -f "$CONFIG_PATH" ]; then
        notify-send -i dialog-error "Picom" "Config not found: $CONFIG_PATH"
        exit 1
    fi
    
    # Initialize state file if missing
    [[ ! -f "$STATE_FILE" ]] && echo "on" > "$STATE_FILE"
    
    current=$(cat "$STATE_FILE")

    if [ "$current" = "on" ]; then
        killall -q picom
        while pgrep -u "$(whoami)" -x picom >/dev/null; do sleep 0.5; done
        
        echo "off" > "$STATE_FILE"
        notify-send -i utilities-terminal "Picom" "Disabled"
    else
        # Kill any ghost processes first
        killall -q picom
        
        # Launch using the explicit config path
        picom --config "$CONFIG_PATH" &
        echo "on" > "$STATE_FILE"
        notify-send -i utilities-terminal "Picom" "Enabled"
    fi
}

toggle
