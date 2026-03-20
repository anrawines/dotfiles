#!/bin/bash

if pgrep -x "gammastep" > /dev/null; then
    pkill -x gammastep
    notify-send -i video-display "Gammastep" "Filter Disabled"
else
    # Replace coordinates/temps with your specific needs
    gammastep -l 3.6:98.4 -t 6500:3500 -m randr & 
    notify-send -i video-display "Gammastep" "Filter Enabled"
fi
