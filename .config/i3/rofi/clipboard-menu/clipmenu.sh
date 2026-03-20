#!/bin/bash

# Get item
item=$(greenclip print | rofi -dmenu -i -p "📋 Clipboard" -line-padding 1 -hide-scrollbar -show-icons -theme ~/.config/i3/rofi/clipboard-menu/clipboard-theme-1.rasi)
if [ -n "$item" ]; then
    # Set to clipboard
    greenclip print "$item"
    # Send to Dunst
    notify-send "Clipboard Updated" "$item" -t 2000
fi




