#!/bin/bash

# Configuration
FULL_LEVEL=99
LOW_LEVEL=35
NOTIFIED_LOW=false
NOTIFIED_FULL=false
# Track the last known status to detect transitions (Plug/Unplug)
PREV_STATUS=$(cat /sys/class/power_supply/BAT0/status)

while true; do
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

    # 1. Detect Plug-in / Unplug (Transition detection)
    if [ "$STATUS" != "$PREV_STATUS" ]; then
        if [ "$STATUS" = "Charging" ]; then
            notify-send -u low -i battery-charging "Charger Connected" "Battery is now charging ($CAPACITY%)" -t 4321
            NOTIFIED_FULL=false # Reset full notification flag
        elif [ "$STATUS" = "Discharging" ]; then
            notify-send -u low -i battery-discharging "Charger Disconnected" "Running on battery ($CAPACITY%)" -t 4321
            NOTIFIED_LOW=false  # Reset low notification flag
        fi
        PREV_STATUS="$STATUS"
    fi

    # 2. Handle Low Battery (15% and Discharging)
    if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le "$LOW_LEVEL" ]; then
        if [ "$NOTIFIED_LOW" = false ]; then
            notify-send -u critical -i battery-low "Battery Critical" "Level: $CAPACITY%. Please plug in!" -t 1234
            NOTIFIED_LOW=true
        fi
    fi

    # 3. Handle Full Battery (99%)
    if [ "$STATUS" = "Charging" ] && [ "$CAPACITY" -ge "$FULL_LEVEL" ]; then
        if [ "$NOTIFIED_FULL" = false ]; then
            notify-send -u normal -i battery-full "Battery Full" "Level: $CAPACITY%. You can unplug now." -t 1234
            NOTIFIED_FULL=true
        fi
    fi

    sleep 10 # Check every 10 seconds for faster response to plug/unplug
done
