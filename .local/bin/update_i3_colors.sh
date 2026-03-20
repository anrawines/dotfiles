#!/bin/bash
# ~/.config/scripts/update_i3_colors.sh

# Wait for pywal to finish
sleep 1

# Extract colors from Xresources
bg=$(xrdb -query | grep 'color0:' | awk '{print $2}' | head -n 1)
fg=$(xrdb -query | grep 'color7:' | awk '{print $2}' | head -n 1)

# Update i3 config
sed -i "s/^set_from_resource \$fg.*/set_from_resource \$fg i3wm.color7 $fg/" ~/.config/i3/config
sed -i "s/^set_from_resource \$bg.*/set_from_resource \$bg i3wm.color0 $bg/" ~/.config/i3/config

# Reload i3
xrdb -merge ~/.Xresources
# Then reload i3
i3-msg reload
