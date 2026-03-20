#!/usr/bin/env bash


# Autostart applications
## Polybar (bar) #############
CURRENT_THEME=$(cat "$HOME/.config/i3/.current_theme")
THEME_LAUNCHER="$HOME/.config/i3/polybar/themes/$CURRENT_THEME/launch.sh"

if [ -f "$THEME_LAUNCHER" ]; then
    bash "$THEME_LAUNCHER" &
else
    # Fallback if file doesn't exist
    bash "$HOME/.config/i3/polybar/themes/default/launch.sh" &
fi

## polkit ###########
# lxpolkit &

## picom (Compositor) ##############
#picom --config ~/.config/i3/picom/picom.conf -b &

killall -q picom
while pgrep -u $USER -x picom >/dev/null; do sleep 0.5; done
picom --config ~/.config/i3/picom/picom.pijulius.conf &

## Feh (background)  #########
#feh --bg-fill "$(< "${HOME}/.cache/wal/wal")" &
if [ -f "$HOME/.config/i3/.current_wallpaper" ]; then
    feh --bg-fill "$(cat "$HOME/.config/i3/.current_wallpaper")" &
else
    feh --bg-fill "$(< "${HOME}/.cache/wal/wal")" &
fi

## sxhkd (Hotkey daemon) #############
pkill -x sxhkd
sxhkd -c ~/.config/i3/sxhkd/sxhkdrc &

## dunst (notification) ###########
#dunst -config ~/.config/i3/dunst/dunstrc &
#killall dunst && sleep 0.5 && dunst -config ~/.config/i3/dunst/dunstrc &

killall -q dunst
while pgrep -u $USER -x dunst >/dev/null; do sleep 0.5; done
dunst -config "$HOME/.config/i3/dunst/dunstrc" &

## autorandr ############
autorandr --change

## autotiling i3 #############
pkill autotiling
/usr/bin/autotiling -w 1 2 3 4 5 -sw 0.85 & 

## xcorners
#pkill xcorners
#xcorners -W 1920 -H 14 -y 35 -r 14 -1 &

## gammastep
#pkill gammastep
#gammastep -l 3.6:98.4 -t 6500:3500 -m randr -c /dev/null &

## battery & charging monitor ###
killall -q low-bat-notify.sh
~/.config/i3/scripts/low-bat-notify.sh &

## --- Clipboard Manager ---
# 1. Kill any existing instances to prevent duplicates
pkill greenclip
pkill clip_watcher.sh
pkill clipnotify

# 2. Wait a moment for processes to die
sleep 0.5

# 3. Start the daemon
# We use 'nohup' or '&' to ensure it stays in background
greenclip daemon &

sleep 0.5
# 4. Start your custom watcher
~/.config/i3/rofi/clipboard-menu/clip_watcher.sh &

notify-send "Clipboard Manager" "Services restarted successfully" -i preferences-desktop-remote-desktop -t 1000

## xrdb color ##
xrdb -merge ~/.Xresources
