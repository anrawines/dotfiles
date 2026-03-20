#!/bin/bash
# install : https://github.com/BrycensRanch/gpu-screen-recorder-git-copr

# Configuration
SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"
FILENAME="recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"

# Check if already recording
if pgrep -x "gpu-screen-recorder" >/dev/null; then
    # If running, stop it gracefully
    pkill -SIGINT gpu-screen-recorder
    notify-send "Screen Recorder" "Recording stopped and saved."
else
    # Choose mode via Rofi
    MODE=$(echo -e "Full-Screen\nWindow\nCancel" | rofi -dmenu -p "Select Recording Mode:")

    case "$MODE" in
    "Full-Screen")
        notify-send "Screen Recorder" "Starting full-screen recording..."
        # Adjust 'screen-direct' to 'window' if on Wayland/Nvidia
        gpu-screen-recorder -w screen -f 60 -a "default_output" -o "$SAVE_DIR/$FILENAME" &
        ;;
    "Window")
        notify-send "Screen Recorder" "Click the window you want to record."
        # Allows you to select a specific window ID
        gpu-screen-recorder -w $(xdotool selectwindow) -f 60 -a "default_output" -o "$SAVE_DIR/$FILENAME" &
        ;;
    *)
        exit 0
        ;;
    esac
fi
