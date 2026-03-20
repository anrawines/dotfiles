### --- Export --- ###
set -U fish_user_paths $HOME/.local/bin $fish_user_paths


### --- PENGATURAN UMUM --- ###
set -g fish_greeting "" # Menghapus pesan selamat datang yang mengganggu

### --- ENVIRONMENT VARIABLES --- ###
set -gx EDITOR micro # Ganti dengan nvim/code jika perlu
set -gx VISUAL $EDITOR
set -gx BROWSER firefox

set TERM "xterm-256color"   
### SET FZF DEFAULTS
set -gx FZF_DEFAULT_OPTS "--layout=reverse --exact --border=bold --border=rounded --margin=3% --color=dark"

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan


### --- INTEGRASI TOOLS (MODERN STACK) --- ###

# Zoxide (Smart CD)
if type -q zoxide
    zoxide init fish | source
end

### FZF ###
# Enables the following keybindings:
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd

# FZF (Fuzzy Finder)
if type -q fzf
    fzf --fish | source
end

### --- ALIAS & ABBREVIATIONS --- ###

if status is-interactive
	# Changing "ls" to "eza"
	alias ls='eza -al --color=always --group-directories-first --icons --header --long --no-filesize --across' # my preferred listing
	alias la='eza -a --color=always --group-directories-first'  # all files and dirs
	alias ll='eza -l --color=always --group-directories-first'  # long format
	alias lt='eza -aT --color=always --group-directories-first' # tree listing
	alias l.='eza -a | egrep "^\."'
	alias l.='eza -al --color=always --group-directories-first ../' # ls on the PARENT directory
	alias l..='eza -al --color=always --group-directories-first ../../' # ls on directory 2 levels up
	alias l...='eza -al --color=always --group-directories-first ../../../' # ls on directory 3 levels up


    alias cat='bat'

    
    alias x='exit'
    alias c='clear'
    
    # get fastest mirrors
	alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
	alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
	alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
	alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

    #fzf package search yay & pac
    alias pacf="pacman -Slq | fzf --reverse --multi --preview 'pacman -Sii {1}' --preview-window=down:75% | xargs -ro sudo pacman -S"
    alias yayf="yay -Slq  | fzf --reverse --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
    
    # Arch Linux / Pacman Abbr (Mengetik singkat, mengembang jadi perintah asli)
    abbr -a update 'sudo pacman -Syu && yay -Syu'
    abbr -a install 'sudo pacman -S'
    abbr -a remove 'sudo pacman -Rns'
    abbr -a search 'pacman -Ss'
    

    
    # Git Abbr
    abbr -a gst 'git status'
    abbr -a gca 'git commit -v -a'
    abbr -a gp 'git push'
    
    # Fish
    abbr -a reload 'source ~/.config/fish/config.fish && echo "Reloaded .fishrc"'
    abbr -a fishrc '$EDITOR ~/.config/fish/config.fish'
    abbr -a bashrc '$EDITOR ~/.bashrc'
    abbr -a zshrc '$EDITOR ~/.zshrc'

    alias kittyrc='$EDITOR ~/.config/kitty/kitty.conf'
    alias weztermrc='$EDITOR ~/.config/wezterm/wezterm.lua'
    
    abbr -a tobash 'chsh -s "$(command -v bash)"'
    abbr -a tozsh 'chsh -s "$(command -v zsh)"'

    # Bind Ctrl+G untuk menjalankan fungsi helpme
    bind \cg helpme
    
end

### --- FUNGSI TAMBAHAN (OPSIONAL) --- ###

# Membuat folder dan langsung masuk ke dalamnya
function mkcd
    mkdir -p $argv && cd $argv
end

# Help for searching alias and abbr FZF
function helpme
    begin
        alias | string replace -r '^alias\s+(\S+).*' 'alias: $1'
        abbr --list | string replace -r '(.*)' 'abbr: $1'
    end | fzf --height 40% --layout=reverse --header "Cari Alias/Abbr" \
              --preview 'fish -c "type -a (string split \" \" {})[2]"' | read -l selected

    if test -n "$selected"
        set -l command_to_put (string split ' ' $selected)[2]
        commandline -r "$command_to_put"
        commandline -f repaint
    end
end


# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# sudo pacman -S pkgfile - sudo pkgfile -u
source /usr/share/doc/pkgfile/command-not-found.fish

# sudo pacman -S starshop
starship init fish | source

# Pastikan program tahu kita di i3
set -gx XDG_CURRENT_DESKTOP i3
set -gx DESKTOP_SESSION i3

# Ganti 'Adwaita-dark' dengan nama tema yang muncul di lxappearance Anda
set -gx GTK_THEME "Adwaita-dark"
