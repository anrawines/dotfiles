#!/bin/bash

# No dupe instance
pkill clipnotify
last_clip=""

# Monitor
while clipnotify -s clipboard; do
    # Sleep to optimize on X11
    sleep 0.1
    # get clipboard content
    current_clip=$(xclip -selection clipboard -o 2>/dev/null)
   # validate no dupe cliboard or empty
    if [[ -n "$current_clip" && "$current_clip" != "$last_clip" ]]; then
        # get 50 text to avoid big clipboard
        short_text=$(echo "$current_clip" | head -n 1 | head -c 50)
        notify-send "Copied" "$short_text..." -t 1500 -i edit-copy
        last_clip="$current_clip"
        paplay ~/.config/i3/dunst/sounds/clipboard-pop.mp3
    fi
done 
