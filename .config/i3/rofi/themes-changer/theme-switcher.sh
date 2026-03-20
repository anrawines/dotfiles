#!/usr/bin/env bash

# --- Configuration ---
THEMES_DIR="$HOME/.config/i3/polybar/themes"
I3_CONFIG_DIR="$HOME/.config/i3"
DUNST_CONFIG_DIR="$HOME/.config/i3/dunst"
PICOM_CONFIG_DIR="$HOME/.config/i3/picom"

# --- 1. Get Theme List from Folder ---
# This reads all directories in the themes folder
themes=$(ls -d "$THEMES_DIR"/*/ | xargs -n 1 basename)

# --- 2. Rofi Menu ---
chosen_theme=$(echo "$themes" | rofi -dmenu -i -p "󰃟 Select Theme:" -config "$I3_CONFIG_DIR/rofi/config.rasi")

# Exit if nothing is chosen
if [ -z "$chosen_theme" ]; then
    exit 1
fi

TARGET_DIR="$THEMES_DIR/$chosen_theme"

# --- 3. The Re-Linking Logic ---

# i3 Colors & Gaps
ln -sf "$TARGET_DIR/i3-colors" "$I3_CONFIG_DIR/colors.conf"
ln -sf "$TARGET_DIR/i3-gaps"   "$I3_CONFIG_DIR/gaps.conf"

# Dunst
if [ -f "$TARGET_DIR/dunstrc" ]; then
    ln -sf "$TARGET_DIR/dunstrc" "$DUNST_CONFIG_DIR/dunstrc"
fi

# Picom Logic
if [ -f "$TARGET_DIR/picom.pijulius.conf" ]; then
    # Link the theme's picom to the specific name your system uses
    ln -sf "$TARGET_DIR/picom.pijulius.conf" "$PICOM_CONFIG_DIR/picom.pijulius.conf"
    
    killall -q picom
    # Point this to the actual symlink name you just created
    while pgrep -u $USER -x picom >/dev/null; do sleep 0.5; done
	picom --config ~/.config/i3/picom/picom.pijulius.conf &
fi

# --- 4. Apply Changes (Refresh System) ---

# Set Wallpaper (using the first image found in the theme's wallpaper folder)
wallpaper=$(find "$TARGET_DIR/wallpapers" -type f | shuf -n 1)
if [ -f "$wallpaper" ]; then
    feh --bg-fill "$wallpaper"
fi

# Restart Dunst
pkill dunst && dunst -config "$HOME/.config/i3/dunst/dunstrc" &

# Restart Picom
#pkill picom && picom --config "$PICOM_CONFIG_DIR/picom.pijulius.conf" &



# Reload i3 (This picks up new colors.conf and gaps.conf)
i3-msg reload

# Link the active launcher script so autostart knows what to run
ln -sf "$TARGET_DIR/launch.sh" "$HOME/.config/i3/polybar/active_launch.sh"

# 1. Save the current theme name to a hidden file
echo "$chosen_theme" > "$HOME/.config/i3/.current_theme"

# 2. Save the wallpaper path
echo "$wallpaper" > "$HOME/.config/i3/.current_wallpaper"

# Launch Polybar (using the specific theme's launcher)
if [ -f "$TARGET_DIR/launch.sh" ]; then
    bash "$TARGET_DIR/launch.sh"
fi


notify-send "Theme Applied" "Switched to $chosen_theme theme."
