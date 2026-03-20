#!/bin/bash

if pgrep -x "rofi" > /dev/null; then
    pkill -x rofi
    exit 0
fi

rofi -show window -modi window -window-format '{w} | {c}' -show-icons -kb-cancel "Alt+Escape,Escape" -kb-accept-entry "!Alt-Tab,Return" -kb-row-down "Alt+Tab,Alt+Down" -kb-row-up "Alt+Shift+Tab,Alt+Up" -theme ~/.config/i3/rofi/alt-tab/style-6.rasi
