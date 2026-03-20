#!/bin/bash

# --- 1. Konfigurasi Path ---
wall_dir="$HOME/Media/Wallpapers"
cacheDir="$HOME/.cache/thumbnails/rofi-wallpapers"
# Folder untuk background Rofi launcher (wall.thmb & wall.blur)
rofi_bg_dir="$HOME/.config/i3/rofi/app-launcher/backgrounds"
RASI_THEME="$HOME/.config/i3/rofi/wallpaper-changer/wallSelect.rasi"

icon_size=300

# Buat folder jika belum ada
mkdir -p "$cacheDir" "$rofi_bg_dir"

# Cek ImageMagick
if command -v magick >/dev/null 2>&1; then
    IM_COMMAND="magick"
else
    IM_COMMAND="convert"
fi

# --- 2. Generate Thumbnails untuk Preview di Rofi ---
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    [ -f "$imagen" ] || continue
    nombre_archivo=$(basename "$imagen")
    cache_file="${cacheDir}/${nombre_archivo}"
    
    if [ ! -f "$cache_file" ] || [ "$imagen" -nt "$cache_file" ]; then
        $IM_COMMAND "$imagen" -strip -thumbnail ${icon_size}x${icon_size}^ \
            -gravity center -extent ${icon_size}x${icon_size} \
            -quality 85 "$cache_file" 2>/dev/null
    fi
done

# --- 3. Build List & Jalankan Rofi ---
wall_list=""
while IFS= read -r -d '' file; do
    nombre_archivo=$(basename "$file")
    cache_file="${cacheDir}/${nombre_archivo}"
    [ -f "$cache_file" ] && wall_list+="$nombre_archivo\0icon\x1f$cache_file\n"
done < <(find "$wall_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

wall_selection=$(echo -en "$wall_list" | rofi -dmenu -show-icons -theme "$RASI_THEME" -p "Select wallpaper")

# --- 4. Proses Setelah Wallpaper Dipilih ---
if [[ -n "$wall_selection" ]]; then
    wallpaper="${wall_dir}/${wall_selection}"
    
    # A. Set Wallpaper (feh)
    feh --bg-fill "$wallpaper"

    # B. GENERATE BACKGROUND UNTUK LAUNCHER (REPLIKA HYDE)
    # Kita buat wall.thmb (untuk kiri) dan wall.blur (untuk bar samping)
    echo "Generating Rofi launcher backgrounds..."
    $IM_COMMAND "$wallpaper" -resize 800x "${rofi_bg_dir}/wall.thmb"
    $IM_COMMAND "$wallpaper" -resize 200x -blur 0x8 "${rofi_bg_dir}/wall.blur"

    # C. Generate Pywal (Jika ada)
	if command -v wal >/dev/null 2>&1; then
        wal -i "$wallpaper" -q
        sleep 1 
    fi
	
	# D. Dunst
	DUNST_DIR="$HOME/.config/i3/dunst"
    TEMPLATE="$DUNST_DIR/dunstrc.template"
    CONFIG="$DUNST_DIR/dunstrc"
    
    if [[ -f "$HOME/.cache/wal/colors.sh" && -f "$TEMPLATE" ]]; then
        # Ambil warna dan export sekaligus
        set -a
        source "$HOME/.cache/wal/colors.sh"
        set +a
       
        # Generate config
        envsubst < "$TEMPLATE" > "$CONFIG"
        
        # Restart Dunst dengan bersih
        killall -q dunst
        while pgrep -u $USER -x dunst >/dev/null; do sleep 0.2; done
        dunst -config "$CONFIG" &
        
    fi
	
	xrdb -merge ~/.Xresources
	notify-send "Color Reloaded" "Wallpaper, Polybar, Dunst"
    echo "Done!"
else
    echo "No wallpaper selected"
    exit 1
fi
