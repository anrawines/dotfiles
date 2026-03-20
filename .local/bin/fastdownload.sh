#!/bin/bash
# Get link from clipboard
LINK=$(xclip -selection clipboard -o)

# Check if the link is empty
if [ -z "$LINK" ]; then
    echo "Clipboard is empty!"
    exit 1
fi

echo "Downloading: $LINK"
# -x 16: use 16 connections
# -s 16: split into 16 pieces
# --continue: resume if interrupted
aria2c -x 16 -s 16 --continue "$LINK"
