#!/bin/bash

# Get weather data
weather_data=$(curl -s "https://wttr.in/1.054507,104.004120?format=%t+%C" 2>/dev/null)

if [[ -z "$weather_data" ]] || [[ $weather_data == *"Unknown"* ]] || [[ $weather_data == *"Sorry"* ]]; then
    echo "%{F#ff5555}%{F-} N/A"  # Red icon, normal text
    exit 0
fi

# Extract data
temp=$(echo "$weather_data" | awk '{print $1}' | tr -d '[:space:]'| tr -d '+')
condition=$(echo "$weather_data" | cut -d ' ' -f2- | tr '[:upper:]' '[:lower:]')

# Get colored icon based on condition
case $condition in
    *clear*|*sunny*)
        echo "%{F#ffb86c}%{F-} $temp"  # Orange icon
        ;;
    *partly*cloudy*)
        echo "%{F#bd93f9}󰖕 %{F-} $temp"  # Purple icon
        ;;
    *cloudy*|*overcast*)
        echo "%{F#6272a4}%{F-} $temp"  # Grey-blue icon
        ;;
    *rain*|*drizzle*|*shower*)
        echo "%{F#8be9fd}󰖖 %{F-} $temp"  # Cyan icon
        ;;
    *thunder*|*storm*|*lightning*)
        echo "%{F#f1fa8c}%{F-} $temp"  # Yellow icon
        ;;
    *snow*)
        echo "%{F#ffffff}%{F-} $temp"  # White icon
        ;;
    *fog*|*mist*|*haze*)
        echo "%{F#aaaaaa}%{F-} $temp"  # Light grey icon
        ;;
    *)
        echo "%{F#ff79c6}%{F-} $temp"  # Pink icon
        ;;
esac
