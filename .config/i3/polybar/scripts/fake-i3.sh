#!/bin/bash

# 0. GET COLORS FROM XRDB
get_xrdb_color() {
    local color=$(xrdb -query | grep -m 1 "$1" | awk '{print $NF}')
    echo "${color:-$2}"
}

ACV=$(get_xrdb_color "color4" "#4c566a")
OCC=$(get_xrdb_color "color1" "#2e3440")
EMP=$(get_xrdb_color "color2" "#1a232e")
FG1=$(get_xrdb_color "color7" "#90959D")
FG2=$(get_xrdb_color "color6" "#646464")
UL=$(get_xrdb_color "color2" "#1a232e")
OL=$(get_xrdb_color "color2" "#1a232e")

# 1. 9 Workspace
workspaces=("1" "2" "3" "4" "5" "6" "7" "8" "9")

# 2. Get Data i3
ws_data=$(i3-msg -t get_workspaces)

# 3. Get workspace FOCUSED
focused=$(echo "$ws_data" | jq -r '.[] | select(.focused==true).name')

output=""

for ws in "${workspaces[@]}"; do
    action="%{A1:i3-msg workspace $ws:}"
    end_action="%{A}"

    # CHECK
    is_occupied=$(echo "$ws_data" | jq -r '.[].name' | grep -x "$ws")

    if [ "$ws" == "$focused" ]; then
        # ACTIVE: Using $FG for the background and $BG for text
        output+="$action%{F$FG1}%{B$ACV} $ws %{B-}%{F-}$end_action"
    elif [ -n "$is_occupied" ]; then
        # OCCUPIED: Using $LC (color2) for the background
        #output+="$action%{F$FG}%{B$OCC}%{o$OL}%{+o}%{u$UL}%{+u} $ws %{-u}%{-o}%{B-}%{F-}$end_action"
        output+="$action%{F$FG1}%{B$OCC} $ws %{B-}%{F-}$end_action"
    else
        # EMPTY: Using your default dark background
        output+="$action%{F$FG2}%{B$EMP} $ws %{B-}%{F-}$end_action"
    fi
done

echo "$output"
