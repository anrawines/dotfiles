#!/bin/bash

PROF=$(grep -Po "Default=\K.*" "$HOME/.mozilla/firefox/profiles.ini")
DB_PATH="$HOME/.mozilla/firefox/$PROF/places.sqlite"
TEMP_DB="/tmp/ff_toolbar_clean.sqlite"
# Check if the file actually exists before copying
if [ ! -f "$DB_PATH" ]; then
    echo "Error: Profile database not found at $DB_PATH"
    exit 1
fi

cp "$DB_PATH" "$TEMP_DB"

# Query dengan pembersihan URL:
# Menampilkan: Judul -- (domain.com) | URL
# Query untuk mengambil 100 riwayat terakhir
QUERY="SELECT title || ' -- (' || SUBSTR(url, INSTR(url, '//') + 2, 20) || ') | ' || url 
       FROM moz_places 
       WHERE title IS NOT NULL AND title != ''
       ORDER BY last_visit_date DESC 
       LIMIT 10000;"

CHOICE=$(sqlite3 "$TEMP_DB" "$QUERY" | dmenu -i -l 10 -p "Search Toolbar:")

if [ -n "$CHOICE" ]; then
    # Mengambil URL yang ada setelah karakter '|' terakhir
    URL=$(echo "$CHOICE" | awk -F ' | ' '{print $NF}')
    firefox "$URL" &
fi

rm "$TEMP_DB"
