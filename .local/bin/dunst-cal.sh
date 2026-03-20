#!/bin/bash
# set dunst 
# ignore_newline = yes
# Get current date
year=$(date +%Y)
month=$(date +%m)
today=$(date +%e)

# Navigation logic
if [ "$1" == "next" ]; then
    next_date=$(date -d "$year-$month-01 +1 month" +%Y-%m)
    year=$(echo "$next_date" | cut -d- -f1)
    month=$(echo "$next_date" | cut -d- -f2)
elif [ "$1" == "prev" ]; then
    prev_date=$(date -d "$year-$month-01 -1 month" +%Y-%m)
    year=$(echo "$prev_date" | cut -d- -f1)
    month=$(echo "$prev_date" | cut -d- -f2)
fi

# Get calendar output
full_output=$(cal --color=never "$month" "$year")
cal_title=$(echo "$full_output" | head -n 1 | xargs)
cal_body=$(echo "$full_output" | tail -n +2)

# Highlight today: Dark text on Gold background
marked_body=$(echo "$cal_body" | sed "s/\b${today}\b/<b><span foreground='#0c101b' background='#c7a92d'>${today}<\/span><\/b>/")

# Send to Dunst with Monospace font wrapper
notify-send -r 999 "$cal_title" "<tt>$marked_body</tt>"
