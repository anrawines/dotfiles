#!/usr/bin/env bash

displays=(HDMI-A-0)
profiles=(
	1:1:1
	1:.97:.94
	1:.93:.88
	1:.90:.81
	1:.86:.73
	1:.82:.64
	1:.77:.54
	1:.71:.42
	1:.68:.35
	1:.64:.28
	1:.59:.18
	1:.54:.08
	1:.32:.03
	1:.18:.01
)

config="${XDG_DATA_HOME:-$HOME/.local/share}/$(basename "$0" .sh)"

# Load current index or default to 0 (first profile)
if [[ -f "$config" ]]; then
    # shellcheck source=/dev/null
    source "$config"
else
    ind=0
fi

len=${#profiles[@]}

# Clear action names based on what you actually want to happen
case "$1" in
    "brighter"|"left"|"+" )   # Make it brighter
        new_ind=$((ind+1 > len-1 ? len-1 : ind+1))
        ;;
    "dimmer"|"middle"|"-" )   # Make it dimmer (right click in your config)
        new_ind=$((ind-1 < 0 ? 0 : ind-1))
        ;;
    "show"|"right" )          # Just show (middle click in your config)
        echo " ☀ ${ind}/$((len-1))"
        new_ind=0
        ;;
    "reset" )                 # Reset to default
        new_ind=0
        ;;
    * )                       # No argument - just show
        echo " ☀ ${ind}/$((len-1))"
        exit 0
        ;;
esac

new_prof="${profiles[$new_ind]}"

for display in "${displays[@]}"; do
    xrandr --output "$display" --gamma "${new_prof}"
done

# Save current index
echo "ind=${new_ind}" > "$config"

# Output for polybar
echo " ☀ ${new_ind}/$((len-1))"
