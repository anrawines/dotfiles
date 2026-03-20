#!/usr/bin/env bash
# Terminate already running bar instances
#polybar-msg cmd quit
killall -q polybar 

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
polybar -c ~/.config/i3/polybar/themes/default/config.ini &
#polybar -c ~/.config/i3/polybar/themes/slim-colorfull/config.ini &
