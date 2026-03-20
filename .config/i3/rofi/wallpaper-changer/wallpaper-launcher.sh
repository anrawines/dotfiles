#!/bin/bash

# Set some variables
wall_dir="$HOME/Media/Wallpapers"
cacheDir="$HOME/.cache/thumbnails/rofi-wallpapers"
RASI_THEME="$HOME/.config/i3/rofi/wallSelect.rasi"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ]; then
    mkdir -p "${cacheDir}"
fi

# Fixed icon size (simpler approach)
icon_size=300

# Check for ImageMagick version and use appropriate command
if command -v magick >/dev/null 2>&1; then
    # ImageMagick v7+
    IM_COMMAND="magick"
elif command -v convert >/dev/null 2>&1; then
    # ImageMagick v6
    IM_COMMAND="convert"
else
    echo "Error: ImageMagick not found. Install with: sudo pacman -S imagemagick"
    exit 1
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    # Skip if no files match the pattern
    [ -f "$imagen" ] || continue
    
    nombre_archivo=$(basename "$imagen")
    cache_file="${cacheDir}/${nombre_archivo}"
    
    # Skip if thumbnail already exists and is newer than source
    if [ -f "$cache_file" ] && [ "$cache_file" -nt "$imagen" ]; then
        continue
    fi
    
    # Create thumbnail
    if [ "$IM_COMMAND" = "magick" ]; then
        magick "$imagen" -strip -thumbnail ${icon_size}x${icon_size}^ \
                -gravity center -extent ${icon_size}x${icon_size} \
                -quality 85 "$cache_file" 2>/dev/null
    else
        convert -strip "$imagen" -thumbnail ${icon_size}x${icon_size}^ \
                -gravity center -extent ${icon_size}x${icon_size} \
                -quality 85 "$cache_file" 2>/dev/null
    fi
    
    # Check if thumbnail was created successfully
    if [ ! -f "$cache_file" ]; then
        echo "Warning: Failed to create thumbnail for $nombre_archivo"
        # Create a placeholder or skip this file
        continue
    fi
done

# Build the list of wallpapers for rofi
wall_list=""
while IFS= read -r -d '' file; do
    nombre_archivo=$(basename "$file")
    cache_file="${cacheDir}/${nombre_archivo}"
    
    # Only add if thumbnail exists
    if [ -f "$cache_file" ]; then
        wall_list+="$nombre_archivo\0icon\x1f$cache_file\n"
    else
        # Add without icon if thumbnail missing
        wall_list+="$nombre_archivo\n"
    fi
done < <(find "$wall_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

# Select a picture with rofi
if [ -n "$wall_list" ]; then
    wall_selection=$(echo -en "$wall_list" | rofi -dmenu -show-icons -theme "$RASI_THEME" -p "Select wallpaper")
else
    echo "No wallpapers found in $wall_dir"
    exit 1
fi

# Set the wallpaper and generate pywal colors
if [[ -n "$wall_selection" ]]; then
    wallpaper="${wall_dir}/${wall_selection}"
    
    echo "Setting wallpaper: $wall_selection"
    
    # Set wallpaper with feh
    if command -v feh >/dev/null 2>&1; then
        feh --bg-fill "$wallpaper"
    else
        echo "Error: feh not installed"
        exit 1
    fi
    
    # Generate pywal colorscheme if installed
    if command -v wal >/dev/null 2>&1; then
        echo "Generating pywal colors..."
        wal -i "$wallpaper" -q
        echo "✓ Pywal colors generated"
    else
        echo "Note: Pywal not installed, skipping color generation"
    fi
    
    exit 0
else
    echo "No wallpaper selected"
    exit 1
fi
