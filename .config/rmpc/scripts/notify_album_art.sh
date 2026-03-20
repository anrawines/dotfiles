#!/bin/bash

# Path untuk menyimpan sementara cover art
TMP_COVER="/tmp/mpd_cover.jpg"
MUSIC_DIR="/home/$(whoami)/Media/Music"
TITLE=$(mpc current -f "%title%")
ARTIST=$(mpc current -f "%artist%")
ALBUM=$(mpc current -f "%album%")
TIME=$(mpc current -f "%time%")

# 1. Ambil path file yang sedang diputar
FILE_PATH=$(mpc current -f "%file%")
FULL_PATH="$MUSIC_DIR/$FILE_PATH"

# 2. Ekstrak cover art dari file audio (menggunakan ffmpeg)
# Jika gagal mengambil dari file, coba cari cover.jpg di folder tersebut
ffmpeg -y -i "$FULL_PATH" -an -vcodec copy "$TMP_COVER" > /dev/null 2>&1

if [ ! -f "$TMP_COVER" ]; then
    # Jika tidak ada embedded art, cari file gambar di folder lagu
    ALBUM_DIR=$(dirname "$FULL_PATH")
    find "$ALBUM_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec cp {} "$TMP_COVER" \; -quit
fi

# 3. Ambil info lagu
TITLE=$(mpc current -f "%title%")
ARTIST=$(mpc current -f "%artist%")

# 4. Kirim notifikasi dengan gambar
if [ -f "$TMP_COVER" ]; then
    notify-send -a "MPD" \
    -i "$TMP_COVER" \
    "󰎈 $TITLE" \
    "<i>by</i> <b>󰠃 $ARTIST</b>\n<span color='#b3e5fc'>󰀥 $ALBUM\n󱎫 $TIME</span>"
    # rm "$TMP_COVER" # Hapus temp setelah dikirim
else
    notify-send -a "MPD" -i audio-x-generic "$TITLE" "$ARTIST"
fi
