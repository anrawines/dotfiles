# Autostart X after TTY login.
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

export PATH=$HOME/.local/bin:$PATH
