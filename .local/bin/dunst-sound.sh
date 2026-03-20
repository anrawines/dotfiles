#!/bin/sh

APPNAME="$1"
SUMMARY="$2"
BODY="$3"
URGENCY="$5"

# Different sounds for different apps
case "$APPNAME" in
    "Telegram"|"WhatsApp"|"Messenger"|"clipnotify")
        paplay ~/.config/i3/dunst/sounds/pop-sound.mp3
        ;;
    "Thunderbird"|"Geary"|"Mail")
        paplay ~/sounds/email.wav
        ;;
    "Spotify"|"Rhythmbox")
        # No sound for music apps
        exit 0
        ;;
    *)
        # Default sound for everything else
        paplay ~/sounds/default.wav
        ;;
esac

# Speak critical notifications aloud
if [ "$URGENCY" = "critical" ]; then
    echo "Critical alert from $APPNAME: $SUMMARY" | espeak
fi
