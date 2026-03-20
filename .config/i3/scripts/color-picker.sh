#!/bin/bash

# Menjalankan xcolor dan menyimpan output ke variabel
COLOR=$(xcolor -s clipboard -P 151 -S 8)

# Jika pengambilan warna tidak dibatalkan (variabel tidak kosong)
if [ -n "$COLOR" ]; then
    # Kirim notifikasi (membutuhkan libnotify / dunst)
    notify-send "Color Picked" "Warna $COLOR telah disalin ke clipboard." -i color-picker
fi
