#!/bin/bash

DB_PATH="/home/lenoarch/.mozilla/firefox/dxq0d7ya.default-release/places.sqlite"
TEMP_DB="/tmp/ff_toolbar_clean.sqlite"
cp "$DB_PATH" "$TEMP_DB"

# Query dengan pembersihan URL:
# Menampilkan: Judul -- (domain.com) | URL
QUERY="
WITH RECURSIVE toolbar_tree(id) AS (
    SELECT id FROM moz_bookmarks WHERE guid = 'toolbar_____'
    UNION ALL
    SELECT b.id FROM moz_bookmarks b
    JOIN toolbar_tree tt ON b.parent = tt.id
)
SELECT 
    (CASE WHEN (b.title IS NULL OR b.title = '') THEN 'Untitled' ELSE b.title END) 
    || ' -- (' || SUBSTR(p.url, INSTR(p.url, '//') + 2, 20) || ') | ' || p.url
FROM toolbar_tree tt
JOIN moz_bookmarks b ON tt.id = b.id
JOIN moz_places p ON b.fk = p.id
WHERE b.type = 1;"

CHOICE=$(sqlite3 "$TEMP_DB" "$QUERY" | dmenu -i -l 10 -p "Search Toolbar:")

if [ -n "$CHOICE" ]; then
    # Mengambil URL yang ada setelah karakter '|' terakhir
    URL=$(echo "$CHOICE" | awk -F ' | ' '{print $NF}')
    firefox "$URL" &
fi

rm "$TEMP_DB"

