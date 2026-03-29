#!/bin/bash
url="$1"
stream_url=$(yt-dlp -g -f "bestvideo[height<=1080]+bestaudio/best[height<=1080]" "$url")
exec vlc --one-instance --playlist-enqueue "$stream_url"
