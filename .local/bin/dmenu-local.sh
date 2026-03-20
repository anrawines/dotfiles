#!/bin/sh
export _JAVA_AWT_WM_NONREPARENTING=1

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add include folder
for d in $HOME/.local/bin/*/; do
    export PATH="$PATH:$d"
done

# Use the original dmenu_path or create our own
if [ -x "$(command -v dmenu_path)" ]; then
    dmenu_path | dmenu "$@" | ${SHELL:-"/bin/sh"} &
else
    # Fallback: generate path ourselves
    echo "$PATH" | tr ':' '\n' | xargs -I {} find {} -maxdepth 1 -type f -executable 2>/dev/null | sort -u | dmenu "$@" | ${SHELL:-"/bin/sh"} &
fi
