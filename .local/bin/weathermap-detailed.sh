#!/bin/sh

get_icon() {
    case $1 in
        # Day icons
        01d) icon="" ;; # clear sky - sun
        02d) icon="" ;; # few clouds - sun with cloud
        03d) icon="" ;; # scattered clouds - cloud
        04d) icon="" ;; # broken clouds - sun behind cloud
        09d) icon="" ;; # shower rain - cloud with rain
        10d) icon="" ;; # rain - sun with rain
        11d) icon="" ;; # thunderstorm - thunder cloud
        13d) icon="" ;; # snow - snow cloud
        50d) icon="" ;; # mist - hazy
        
        # Night icons
        01n) icon="" ;; # clear sky - moon
        02n) icon="" ;; # few clouds - moon with cloud
        03n) icon="" ;; # scattered clouds - cloud
        04n) icon="" ;; # broken clouds - moon behind cloud
        09n) icon="" ;; # shower rain - cloud with rain night
        10n) icon="" ;; # rain - moon with rain
        11n) icon="" ;; # thunderstorm - thunder cloud night
        13n) icon="" ;; # snow - snow cloud night (using same as thunder)
        50n) icon="" ;; # mist - hazy (same as day)
        
        *) icon="" ;; # default to sun
    esac

    echo $icon
}

KEY="0867dd59b3bfcbdf3f98937d4df8c340"
CITY_NAME="Singapore"
COUNTRY="SG"
UNITS="metric"
SYMBOL="°C"

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&q=$CITY_NAME,$COUNTRY&units=$UNITS")

if [ ! -z "$weather" ] && [ "$weather" != "null" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description // empty" 2>/dev/null)
    weather_temp=$(echo "$weather" | jq ".main.temp" 2>/dev/null | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon // empty" 2>/dev/null)
    
    if [ ! -z "$weather_desc" ] && [ ! -z "$weather_temp" ]; then
        icon=$(get_icon "$weather_icon")
        echo "$icon $weather_desc, $weather_temp$SYMBOL"
    else
        echo "󰅙 Error: Invalid weather data"
    fi
else
    echo "󰅙 Error: Could not fetch weather"
fi
