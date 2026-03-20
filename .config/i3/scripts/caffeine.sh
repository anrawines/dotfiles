#!/bin/bash
if pgrep -x "xset" > /dev/null; then
    # Jika aktif, kembalikan ke default (misal 300s)
    xset s 300 300 +dpms
    notify-send "Caffeine" "Deactivated - Screen will sleep"
else
    # Jika tidak, matikan (mode caffeine)
    xset -dpms s off
    notify-send "Caffeine" "Activated - Screen stays awake"
fi
