#!/bin/bash


# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path ke file database emoji Anda
EMOJI_DB="$SCRIPT_DIR/emoji.db"


# Pastikan file db ada
if [[ ! -f "$EMOJI_DB" ]]; then
    echo "Error: File $EMOJI_DB tidak ditemukan!"
    exit 1
fi

# Menjalankan Rofi dengan data dari emoji.db
# Menggunakan mode dmenu dan pencarian fuzzy
#selected=$(cat "$EMOJI_DB" | rofi -dmenu -i -p "🔎 Cari Emoji" -matching fuzzy)
selected=$(cat "$EMOJI_DB" | rofi -dmenu -i -theme-str 'listview {columns: 11;}' -p "🔎 Cari Emoji"  -config ~/.config/i3/rofi/emoji-picker/emoji-theme.rasi)
# Jika ada yang dipilih, ambil karakter emoji saja (kolom pertama) dan salin ke clipboard
if [[ -n "$selected" ]]; then
    emoji=$(echo "$selected" | awk '{print $1}')
    echo -n "$emoji" | xclip  -selection clipboard # Gunakan 'xclip -selection clipboard' jika di X11
    notify-send "Emoji Tersalin" "$emoji telah siap ditempel."
fi
