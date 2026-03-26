#!/bin/sh
# Load resources
xrdb -merge ~/.Xresources

# Set Speed Keyboard Rate
xset r rate 220 35

# Set screensaver 300 detik (5 menit)
exec_always --no-startup-id xset s 300 300

# Start sxhkd
sxhkd &

# Start polybar
polybar main &

# Start compositor
picom &

# Set background
#feh --bg-fill ~/wallpaper.jpg

# Set GTK4/Libadwaita to dark mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' &

# Start window manager
exec i3
