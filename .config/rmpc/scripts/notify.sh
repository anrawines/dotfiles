#!/bin/bash
# Mengambil info lagu dari mpc
SONG_INFO=$(mpc current -f "%title% - %artist%")

# Kirim ke dunst (notify-send)
notify-send -a "MPD" -i audio-x-generic "Now Playing" "$SONG_INFO"
