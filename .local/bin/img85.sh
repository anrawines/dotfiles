#!/usr/bin/env bash
for file in "$@"; do
    if [[ "$file" =~ \.(jpg|jpeg|png|webp|bmp)$ ]]; then
        echo "Compressing: $(basename "$file")"
        magick "$file" -quality 85 "${file%.*}_compressed.jpg"
    fi
done
notify-send "Compression Complete" "Processed $# images"
