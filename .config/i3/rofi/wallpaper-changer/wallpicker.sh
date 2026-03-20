#!/bin/bash

CACHE_DIR="$HOME/.cache/thumbnails/rofi"
WALL_DIR="$HOME/Media/Wallpapers"
RASI_THEME="$HOME/.config/i3/rofi/wallSelect.rasi"
#RASI_THEME="$HOME/.config/i3/rofi/wallpaper_ups.rasi"

mkdir -p "$CACHE_DIR"

mapfile -t originPath < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.svg" \))
declare -A bgresult
declare -A cachedresult

# 1. Proses Caching & Persiapan Data
strrr=""
for path in "${originPath[@]}"; do
    filename=$(basename "$path")
    name_no_ext="${filename%.*}"
    cache_path="$CACHE_DIR/${name_no_ext}.png"
    
    bgresult["$name_no_ext"]="$path"

    # Generate cache jika belum ada
    if [[ ! -f "$cache_path" ]]; then
        ffmpeg -i "$path" -loglevel quiet -vf "scale='if(gt(iw,ih),-1,600)':'if(gt(iw,ih),600,-1)',crop=600:600" "$cache_path" -y
    fi
    
    # Format untuk Rofi: Nama\0icon\x1f/path/ke/ikon\n
    strrr+="${name_no_ext}\0icon\x1f${cache_path}\n"
done

# 2. Eksekusi Rofi
selected_name=$(echo -en "$strrr" | rofi -dmenu -p "search" -theme "$RASI_THEME")

# 3. Apply Wallpaper (Menggunakan path asli dari array)
if [ -n "$selected_name" ]; then
    full_path="${bgresult[$selected_name]}"
    wal --backend colorz -q -i "$full_path"
    feh --bg-fill "$full_path"
fi
