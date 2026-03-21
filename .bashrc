#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\e[36m\][\u] \[\e[34m\]\w \[\e[33m\]❯ \[\e[0m\]"

export TERM="xterm-256color"                        # getting proper colors
export HISTCONTROL=ignoredups:erasedups:ignorespace # no duplicate entries
#default editor
export EDITOR='micro'
export VISUAL="$EDITOR"
export BROWSER='firefox'

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# This finds every directory inside ~/.local/bin and adds it to PATH
for d in $HOME/.local/bin/*/; do
    export PATH="$PATH:$d"
done

# --- SHOPT CUSTOMIZATIONS ---

# Enter a directory by just typing its name (no 'cd' required)
shopt -s autocd
# Correct minor spelling errors in 'cd' directory names
shopt -s cdspell
# Append to history file instead of overwriting it (prevents losing commands)
shopt -s histappend
# Make 'ls' and wildcards ignore case (finds .jpg and .JPG)
shopt -s nocaseglob
# Allow '**' to search all subdirectories recursively
shopt -s globstar
# Include hidden files (starting with '.') in wildcard results
shopt -s dotglob
# Enable advanced patterns like !(file) to mean 'everything except'
shopt -s extglob
# Update terminal window size values after every command
shopt -s checkwinsize
shopt -s direxpand

# ============================================================================
# STARSHIP
# ============================================================================

eval "$(starship init bash)" # Jika pakai Bash

# ============================================================================
# NAVIGATION
# ============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'

# Pindah folder sekaligus list isinya
cl() {
    cd "$1" && ll
}

# Set up zoxide
# Mengganti perintah 'cd' secara total dengan 'z' milik zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)" # Gunakan bash jika Anda pakai bash
fi

eval "$(zoxide init bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# ============================================================================
# LS VARIANTS
# ============================================================================

alias ls='eza -lah --icons --group-directories-first'
alias ll='eza -lh --icons --grid --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lgit='eza --long --git --icons'

#alias l='ls -CF --group-directories-first --color=auto'
#alias ls='ls -lhF --group-directories-first --color=auto'
#alias ll='ls -lah --color=auto'
#alias lz='ls -lSrh'
#alias la='ls -A'
#alias lh='ls -lath'

# ============================================================================
# CAT - BAT
# ============================================================================

alias cat='bat --style=plain'               # Mirip cat tapi tetap ada warna
alias bathelp='bat --plain --language=help' # Untuk baca help dengan warna
alias preview='bat --style=numbers,changes,header'

# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias cp='cp -iv'
alias cpn='cp -ivn'

alias mv='mv -iv'
alias mvn='mv -ivn'

alias rm='rm -Iv'

alias mkdir='mkdir -pv'

# Unzip
alias zip='bsdtar -xf'

# ============================================================================
# system maintain
# ============================================================================
# AUR yay
# Upgrade system and AUR packages
alias yay='yay -Syu --noconfirm'
# Install packages
alias yayi='yay -S'
# Search packages
alias yays='yay -Ss --color auto'
# Show installed packages
alias yayq='yay -Q'
# Remove packages
alias yayr='yay -Rns'

# Arch pacman
# Upgrade system only (no AUR)
alias pac='sudo pacman -Syu --color auto'
# Install packages
alias paci='sudo pacman -S'
# Search packages
alias pacs='sudo pacman -Ss --color auto'
# Show installed packages
alias pacqs='sudo pacman -Qs --color auto'
# Remove packages
alias pacr='sudo pacman -Rns --color auto'

# Membersihkan cache paket yang tidak terpakai
alias pclean='sudo pacman -Sc && yay -Sc'

# Menghapus paket beserta dependensi yang tidak diperlukan lagi (orphans)
alias premove='sudo pacman -Rns $(pacman -Qtdq)'

# Explicit install
pacx() {
    echo "--- Paket Explicit Install ---"
    sudo pacman -Qeq
    echo "--- Total Explicit Install ---"
    sudo pacman -Qeq | wc -l
}

pacq() {
    echo "--- Paket Native Install ---"
    sudo pacman -Qn
    echo "--- Total Native Install ---"
    sudo pacman -Qn | wc -l
}

# Update sistem + membersihkan file log & cache dalam satu perintah
maintain() {
    echo "--- Memulai Update Sistem ---"
    sudo pacman -Syu
    echo "--- Membersihkan Orphan Packages ---"
    sudo pacman -Rns $(pacman -Qtdq) || echo "Tidak ada orphan."
    echo "--- Membersihkan Cache Pacman ---"
    sudo pacman -Sc --noconfirm
}

# Mencari file sampah (cache/log) yang memakan ruang besar
check-logs() {
    echo "Ukuran Journalctl:"
    journalctl --disk-usage
    echo "Ukuran Cache Pacman:"
    sudo du -sh /var/cache/pacman/pkg/
}

#lastinstall
alias lastins='grep -E "installed|removed" /var/log/pacman.log | tail -n 60'
#list-app
alias pactab='expac -H M "%m\t%n" | sort -h'

alias merge="xrdb -merge ~/.Xresources"
# ============================================================================
# SYSTEM INFO
# ============================================================================
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias top='btop || htop || top'
alias mem='free -h && echo && ps aux | head -1 && ps aux | sort -rnk 4 | head -5'
alias cpu='ps aux | head -1 && ps aux | sort -rnk 3 | head -5'

# ============================================================================
# NETWORK
# ============================================================================
alias myip="hostname -I | awk '{print \$1}' && echo -n 'External: ' && curl -s ifconfig.me && echo"
alias ports='netstat -tulanp'
alias listening='lsof -P -i -n'

# ============================================================================
# GIT
# ============================================================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpu='git push -u origin main'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gclone='git clone'

# git bare
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Lazy config commit "Last Command"
cfglazy() {
  # 1. Define the full git command so it works inside the function
  local _cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

  # 2. Get the last command. 
  # Note: 'fc -ln -1' is more reliable than 'history' inside a function for Zsh/Bash
  local msg=$(fc -ln -1 | sed 's/^[[:space:]]*//')

  # 3. Add files (if provided) or all modified tracked files (if no args)
  if [ $# -eq 0 ]; then
    $_cfg add -u
  else
    $_cfg add "$@"
  fi

  # 4. Commit with the last command as the message
  if ! $_cfg diff --cached --quiet; then
    $_cfg commit -m "After: $msg"
    echo "✔ Committed with message: 'After: $msg'"
  else
    echo "∅ No changes to save."
  fi
}

cfgac() {
  # We use double quotes here so $HOME expands correctly
  local _cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

  if [ $# -eq 0 ]; then
    $_cfg add -u
  else
    $_cfg add "$@"
  fi
  
  # Added the missing 'diff' subcommand before '--cached'
  if ! $_cfg diff --cached --quiet; then
    $_cfg commit -m "Update: $(date '+%Y-%m-%d %H:%M')"
    echo "✔ Changes committed with timestamp."
  else
    echo "∅ No changes detected to commit."
  fi
}

# ============================================================================
# EDITORS AND CONFIG
# ============================================================================
alias v='nvim'
alias vv='nvim .'
alias e='micro'
alias n='nano'

# Config files
alias reload='source ~/.bashrc && echo "Reloaded .bashrc"'
alias bashrc='${EDITOR} ~/.bashrc'
alias zshrc='${EDITOR} ~/.zshrc'
alias fishrc='${EDITOR} ~/.config/fish/config.fish'

# text editor
alias vimrc='${EDITOR} ~/.vimrc'
alias nvimrc='${EDITOR} ~/.config/nvim/init.vim'

# terminal
alias tmuxconf='${EDITOR} ~/config/.tmux.conf'
alias kittyrc='${EDITOR} ~/.config/kitty/kitty.conf'
alias weztermrc='${EDITOR} ~/.config/wezterm/wezterm.lua'

# Change Terminal Shell
alias tozsh='chsh -s "$(command -v zsh)"'
alias tofish='chsh -s "$(command -v fish)"'

# ============================================================================
# DIRECTORY SHORTCUTS
# ============================================================================
alias g.='cd ~/.config'
alias gd='cd ~/Downloads'
alias gD='cd ~/Documents'
alias gv='cd ~/Media/Videos'

# ============================================================================
# UTILITIES
# ============================================================================
alias x='exit'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias now='date +"%Y-%m-%d %T"'
alias week='date +%V'

# Services
alias service='systemctl list-units --type=service --state=running'

# Disk usage
alias biggest='du -h --max-depth=1 | sort -h'

# Misc
alias weather='curl wttr.in/orlando?u'
#fastfetch
alias ff='fastfetch -c examples/13'
#update grub
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

## Colorize the grep command output for ease of use (good for log files)##
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias serv="ssh root@192.168.2.234"

alias fc="sudo fc-cache -fv"

extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# GUI Apps Swallowing
alias thunar='devour thunar'
alias firefox='devour firefox'
alias gimp='devour gimp'
alias evince='devour evince'
alias mpv='devour mpv'
alias sxiv='devour sxiv'
alias zathura='devour zathura'
# ============================================================================
# UTILITIES
# ============================================================================
#python
alias vact='source venv/bin/activate'
alias pipi='pip install -r'
alias venvx='python -m venv venv'

cd() {
    builtin cd "$@" && [ -f venv/bin/activate ] && source venv/bin/activate
}

mkcd() {
    if [ $# != 1 ]; then
        echo "Usage: mkcd <dir>"
    else
        mkdir -p $1 && cd $1
    fi
}
cdls() {
    cd "$@" && l
}

open() {
    xdg-open "$@" &
}

#translate
alias tt='f(){ ~/Tools/easygoogletranslate/venv/bin/python -c "from easygoogletranslate import EasyGoogleTranslate; import sys; print(EasyGoogleTranslate(target_language=\"en\").translate(\" \".join(sys.argv[1:])))" "$@"; }; f'
alias tr='f(){ ~/Tools/easygoogletranslate/venv/bin/python -c "import sys; from easygoogletranslate import EasyGoogleTranslate; print(EasyGoogleTranslate(target_language=sys.argv[1]).translate(\" \".join(sys.argv[2:])))" "$@"; }; f'

tc() {
    local VENV="~/Tools/easygoogletranslate/venv/bin/python"

    # Jalankan translasi
    local result=$(
        $VENV - "$@" <<EOF
import sys
from easygoogletranslate import EasyGoogleTranslate
if len(sys.argv) < 3: sys.exit()
print(EasyGoogleTranslate(target_language=sys.argv[1]).translate(" ".join(sys.argv[2:])))
EOF
    )

    if [ -n "$result" ]; then
        echo "$result"
        # Otomatis salin ke clipboard
        echo -n "$result" | xclip -selection clipboard
    fi
}

trans() {
    local VENV="~/Tools/easygoogletranslate/venv/bin/python"

    # Jalankan translasi dan simpan ke variabel
    local result=$(
        $VENV - "$@" <<EOF
import sys
from easygoogletranslate import EasyGoogleTranslate
if len(sys.argv) < 3: sys.exit()
print(EasyGoogleTranslate(target_language=sys.argv[1]).translate(" ".join(sys.argv[2:])))
EOF
    )

    # Tampilkan hasil di terminal
    echo "$result"

    # Salin ke clipboard (Gunakan xclip atau wl-copy)
    if command -v xclip >/dev/null; then
        echo -n "$result" | xclip -selection clipboard
    elif command -v wl-copy >/dev/null; then
        echo -n "$result" | wl-copy
    fi
}

trans-mode() {
    local LANG=$1
    if [ -z "$LANG" ]; then
        echo "Usage: trans-mode [lang_code] (e.g., trans-mode ja)"
        return
    fi

    echo "--- Interactive Translate Mode: $LANG ---"
    echo "Type your text and press Enter. Press Ctrl+C to exit."

    # Loop terus-menerus
    while true; do
        echo -n "> "
        read -r text

        # Jika input kosong, skip
        if [ -n "$text" ]; then
            # Panggil fungsi transc yang sudah kita buat sebelumnya
            tc "$LANG" "$text"
        fi
    done
}

# fix fish shell problem
# Jika ini adalah sesi interaktif, jalankan fish
#if [[ $- == *i* ]]; then
#    exec fish
#fi

export PATH="$PATH:~/.clispot/bin"
export SPOTIFY_CLIENT_ID="d26d81e3f1a04d129b596ab5f532ff67"
export SPOTIFY_CLIENT_SECRET="9c53eac610154c17be6b2973d6e39732"
