#!/bin/sh


BAR_HEIGHT=32  # polybar height
BORDER_SIZE=1  # border size from your wm settings
YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value

# Konfigurasi Warna (Ganti kode HEX sesuai tema Anda)
BG="#df773d"
FG="#000000"
LC="#000000"
# Format:
# %{B#hex} = Background
# %{u#hex} = Underline color, %{+u} = Enable underline
# %{o#hex} = Overline color, %{+o} = Enable overline
# %{B-} %{u-} %{o-} = Reset ke default

# Format Polybar (Tag di luar command date)
PREFIX="%{T7}%{B$BG}%{F$FG}%{u$LC}%{o$LC}%{+u}%{+o}"
SUFFIX="%{-u}%{-o}%{B-}%{F-}%{T-}"

# Command Date (Hanya format waktu murni)
DATE_VAL=$(date +" %a %b/%d ")
TIME_VAL=$(date +" %H:%M ")

case "$1" in
--popup)
    if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
        exit 0
    fi

    eval "$(xdotool getmouselocation --shell)"
    eval "$(xdotool getdisplaygeometry --shell)"

    # X
    if [ "$((X + YAD_WIDTH / 2 + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
        : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE))
    elif [ "$((X - YAD_WIDTH / 2 - BORDER_SIZE))" -lt 0 ]; then #Left side
        : $((pos_x = BORDER_SIZE))
    else #Center
        : $((pos_x = X - YAD_WIDTH / 2))
    fi

    # Y
    if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
        : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
    else #Top
        : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
    fi

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
        --title="yad-calendar" --borders=0 >/dev/null &
    ;;
*)
    echo "${DATE_VAL}${PREFIX}${TIME_VAL}${SUFFIX}"
    ;;
esac
