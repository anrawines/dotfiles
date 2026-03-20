VOL=$(pamixer --get-volume)
BAR=$(seq -s "█" $((VOL/5)) | tr -d '[:digit:]')
EMPTY=$(seq -s "░" $((20 - VOL/5)) | tr -d '[:digit:]')

notify-send "Volume [$BAR$EMPTY] ${VOL}%" \
-h string:x-dunst-stack-tag:volume \
-u low \
-r "9993" \
