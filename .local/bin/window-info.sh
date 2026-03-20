#!/bin/bash
echo "Click on a window to inspect:"
WID=$(xdotool selectwindow)

echo "=== Window Geometry ==="
xdotool getwindowgeometry $WID

echo -e "\n=== Window Properties ==="
xprop -id $WID | grep -E '(WM_NAME|WM_CLASS|WM_NORMAL_HINTS)'

echo -e "\n=== Window State ==="
xprop -id $WID | grep -E '(NET_WM_STATE|WM_STATE)'
