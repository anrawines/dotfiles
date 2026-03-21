#	            ▄▄                
#	            ██                
#	▀▀▀██ ▄█▀▀▀ ████▄ ████▄ ▄████ 
#	  ▄█▀ ▀███▄ ██ ██ ██ ▀▀ ██    
#	▄██▄▄ ▄▄▄█▀ ██ ██ ██    ▀████ 
#	
# https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type+Something+&x=none&v=4&h=4&w=80&we=false
# main 	: coder mini
# sub   : calvin s                                                                    

# This finds every directory inside ~/.local/bin and adds it to PATH
export PATH="$HOME/.local/bin:$PATH"

for d in $HOME/.local/bin/*/; do
    export PATH="$PATH:$d"
done

colorscript -r

# ============================================================================
# ZSH BASIC SETTINGS
# ============================================================================
#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
# https://github.com/gh0stzk/dotfiles/blob/master/home/.zshrc
autoload -Uz compinit; compinit

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'
zstyle ':fzf-tab:*' fzf-flags --style=full --height=90% --pointer '>' \
                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold' \
                --input-label ' Search ' --color 'input-border:blue,input-label:blue:bold' \
                --list-label ' Results ' --color 'list-border:green,list-label:green:bold' \
                --preview-label ' Preview ' --color 'preview-border:magenta,preview-label:magenta:bold'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --theme=base16 $realpath'
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use Ctrl+P and Ctrl+N like bash/readline
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Perbaikan untuk Home, End, dan Delete
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey '^[^?' backward-kill-word
# Perbaikan untuk Ctrl+Panah (pindah antar kata)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘

setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# ============================================================================
# EXPORTS
# ============================================================================
export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR='fresh'
export BROWSER='firefox'
export VISUAL="$EDITOR"

# ============================================================================
# TOOLS INITIALIZATION (ZSH VERSION)
# ============================================================================

# Starship
eval "$(starship init zsh)"

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# FZF
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
elif [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# change your default USER shell
alias tobash="chsh $USER -s /bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="chsh $USER -s /bin/zsh && echo 'Log out and log back in for change to take effect.'"
alias tofish="chsh $USER -s /bin/fish && echo 'Log out and log back in for change to take effect.'"

## ============================================================================
#	┌─┐┬  ┬┌─┐┌─┐
#	├─┤│  │├─┤└─┐
#	┴ ┴┴─┘┴┴ ┴└─┘
## ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# LS Variants (eza)
alias ls='eza -lha --grid --no-filesize --long --color=always --icons=always --no-user --group-directories-first --across'
alias ll='eza -lh --icons --grid --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lgit='eza --long --git --icons'

# Bat
alias cats='bat --style=plain'
alias bathelp='bat --plain --language=help'
alias preview='bat --style=numbers,changes,header'

# ============================================================================
# FILE OPERATIONS
# ============================================================================
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias rmi='rm -ri'

alias mkdir='mkdir -pv'
alias zip='bsdtar -xf'

# ============================================================================
# system maintain
# ============================================================================
# Pacman & Yay (Arch)
alias yays='yay -Syu --noconfirm'
alias pac='sudo pacman -Syu'
alias pacs='sudo pacman -Ss'
alias paci='sudo pacman -Qs'
alias pacr='sudo pacman -Rns'
alias pclean='sudo pacman -Sc && yay -Sc'
alias premove='sudo pacman -Rns $(pacman -Qtdq)'
alias lastins='grep -E "installed|removed" /var/log/pacman.log | tail -n 60'

#fzf package search yay & pac
alias pacf="pacman -Slq | fzf --reverse --multi --preview 'pacman -Sii {1}' --preview-window=down:75% | xargs -ro sudo pacman -S"
alias yayf="yay -Slq  | fzf --reverse --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S --noconfirm"

#fzf package installed yay & pac / remove
alias pacrf="pacman -Qq | fzf --reverse --multi --preview 'pacman -Qi {1}' --preview-window=down:75% | xargs -ro sudo pacman -Rns"
alias yayrf="yay -Qmq | fzf --reverse --multi --preview 'yay -Qi {1}' --preview-window=down:75% | xargs -ro yay -Rns"

alias pnpmf='read -p "Search pnpm: " query; pnpm search "$query" | fzf --reverse --multi --preview "pnpm info {1}" --preview-window=down:75% | awk "{print \$1}" | xargs -ro pnpm add -g'
;alias npmf='read -p "Search npm: " query; npm search "$query" --parseable | fzf --reverse --multi --preview "npm view {1}" --preview-window=down:75% | awk -F"\t" "{print \$1}" | xargs -ro npm install -g'
;alias npmf="npm search --parseable | fzf --reverse --multi --preview 'npm view {1}' --preview-window=down:75% | xargs -ro npm install -g"
alias pipf="pip list --outdated | fzf --reverse --multi --header 'Select to Upgrade' | awk '{print \$1}' | xargs -ro pip install --upgrade"
alias aptf="apt-cache search . | awk '{print \$1}' | fzf --reverse --multi --preview 'apt-cache show {1}' --preview-window=down:75% | xargs -ro sudo apt-get install -y"
alias flatf="flatpak remote-ls --columns=application | fzf --reverse --multi --preview 'flatpak remote-info flathub {1}' --preview-window=down:75% | xargs -ro flatpak install -y"

# System Info
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='btop || htop || top'
alias ff='fastfetch'
alias ffs='fastfetch -c examples/$((RANDOM % 20 + 1))'
lsbc="lsblk | bat -l conf -p"

# Program
alias c='clear'
alias x='exit'
alias v='$VISUAL'
alias e='$EDITOR'
alias o='xdg-open'
alias g='git'
alias nv='neovim'
alias vv='vim'

# Config alias

alias zshrc='${EDITOR} ~/.zshrc'
alias bashrc='${EDITOR} ~/.bashrc'
alias fishrc='${EDITOR} ~/.config/fish/config.fish'
alias reload='source ~/.zshrc && echo "Zsh config reloaded!"'

alias vimrc='${EDITOR} ~/.vimrc'
alias nvimrc='${EDITOR} ~/.config/nvim/'

alias kittyrc='${EDITOR} ~/.config/kitty/kitty.conf'
alias weztermrc='${EDITOR} ~/.config/wezterm/wezterm.lua'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'

# Utils
alias x='exit'
alias c='clear'
alias h='history'
alias cx='chmod +x '

alias font='sudo fc-cache -f -v'
alias merge='xrdb -merge ~/.Xresources'
alias chx='chmod +x'
alias tree='tree -LaFc'
alias trez='tree -LaFcs'

#python
alias vact='source venv/bin/activate'
alias pipi='pip install -r'
alias venvx='python -m venv venv'

#ffmpeg
vdo() {
  # speed the video for smooth playback
  ffmpeg -i "$1" -filter:v "setpts=0.8*PTS" -an "$1".smooth.mp4
}

vdo-cmprs() {
  # compress video to be less than 10mb
  ffmpeg -i "$1" -vcodec libx264 -b:v 800k -vf "scale=1280:720" -fs 10M "$1"-cmprs.mp4
}

fzi() {
  fzf --layout=reverse --color=16,current-bg:-1,current-fg:-1 --prompt= --marker= --pointer= --info inline-right --preview-window='70%,border-none' --preview='kitty icat --clear --transfer-mode=memory --stdin=no --scale-up --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {}'
}

#to windows
#check windows list at 
#grep -i 'windows' /boot/grub/grub.cfg
alias towindows= sudo grub-reboot 'osprober-efi-CE51-1600' && reboot

## ============================================================================
#	┌─┐┌─┐┬  ┌┬┐┌─┐┬─┐
#	├┤ │ ││   ││├┤ ├┬┘
#	└  └─┘┴─┘─┴┘└─┘┴└─
## ============================================================================
alias md='~/Documents/md'

# GUI Apps Swallowing
alias thunar='devour thunar'
alias firefox='devour firefox'
alias gimp='devour gimp'
alias evince='devour evince'
alias mpv='devour mpv'
alias sxiv='devour sxiv'
alias zathura='devour zathura'

## ============================================================================
#	┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌
#	├┤ │ │││││   │ ││ ││││
#	└  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘
## ============================================================================

# fastfetch images
ffi() {
    # Clear screen first
    clear
    
    local ascii_colors=("blue" "green" "cyan" "magenta" "red" "yellow" "white")
    local all_files=(
        $HOME/.config/fastfetch/images/*.{png,jpg,jpeg,gif,webp}(N)
        $HOME/.config/fastfetch/ascii/*.txt(N)
    )
    
    if [ ${#all_files[@]} -eq 0 ]; then
        echo "No logo files found"
        fastfetch -c $HOME/.config/fastfetch/config.jsonc
        return
    fi
    
    local random_file=${all_files[$((RANDOM % ${#all_files[@]} + 1))]}
    local random_color=${ascii_colors[$((RANDOM % ${#ascii_colors[@]} + 1))]}
    
    echo "🎲 Using: $(basename "$random_file") (Color: $random_color)"
    
    # For images, specify iterm protocol
    if [[ "$random_file" == *.(png|jpg|jpeg|gif|webp) ]]; then
        fastfetch --logo "$random_file" \
                  --logo-type iterm \
                  --logo-width 25 \
                  -c $HOME/.config/fastfetch/config.jsonc
    else
        # For ASCII, use random color
        # NOTE: --logo-color-1 only works for built-in ASCII logos, not file-based ones
        fastfetch --logo "$random_file" \
                  --logo-color-1 "$random_color" \
                  -c $HOME/.config/fastfetch/config.jsonc
    fi
}

ffx() {
    
    clear
    local logo_dir="$HOME/.config/fastfetch/images"
    local config_file="$HOME/.config/fastfetch/config.jsonc"
    
    # Find all image files (including nested)
    local images=($logo_dir/**/*.{png,jpg,jpeg,gif,webp,svg}(N))
    
    if [ ${#images[@]} -eq 0 ]; then
        # Fallback to ascii logos
        local ascii_files=($HOME/.config/fastfetch/ascii/*.txt(N))
        if [ ${#ascii_files[@]} -gt 0 ]; then
            local random_ascii=${ascii_files[$((RANDOM % ${#ascii_files[@]} + 1))]}
            echo "📄 Using ASCII: $(basename "$random_ascii")"
            fastfetch --logo "$random_ascii" -c "$config_file"
        else
            fastfetch -c "$config_file"
        fi
        return
    fi
    
    local random_img=${images[$((RANDOM % ${#images[@]} + 1))]}
    echo "🎲 Random image: $(basename "$random_img")"
    
    # WezTerm specific settings - note the backslashes for line continuation
    fastfetch --logo "$random_img" \
              --logo-type kitty \
              --logo-width 40 \
              --logo-height 16 \
              --logo-padding-right 3 \
              --logo-padding-top 1 \
              -c "$config_file"
}

# Auto-activate Python Venv saat masuk folder
function chpwd() {
    if [ -f venv/bin/activate ]; then
        source venv/bin/activate
    fi
}

# Fungsi Pacman
pacx() {
    echo "--- Paket Explicit Install ---"
    sudo pacman -Qeq
    echo "--- Total Explicit Install ---"
    sudo pacman -Qeq | wc -l
}

maintain() {
    echo "--- Memulai Update Sistem ---"
    sudo pacman -Syu
    echo "--- Membersihkan Orphan Packages ---"
    sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "Tidak ada orphan."
    echo "--- Membersihkan Cache Pacman ---"
    sudo pacman -Sc --noconfirm
}

# Fungsi Translator (Sesuai script Anda)
tc() {
    local VENV="~/Tools/easygoogletranslate/venv/bin/python"
    local result=$($VENV - <<EOF "$@"
import sys
from easygoogletranslate import EasyGoogleTranslate
if len(sys.argv) < 3: sys.exit()
print(EasyGoogleTranslate(target_language=sys.argv[1]).translate(" ".join(sys.argv[2:])))
EOF
    )
    if [ -n "$result" ]; then
        echo "$result"
        echo -n "$result" | xclip -selection clipboard
    fi
}

# Fungsi cari font dan salin ke clipboard
findfont() {
    local font
    font=$(fc-list : family | cut -d, -f1 | sort -u | fzf --height 40% --layout=reverse --border --prompt="🔍 Cari Font: ")
    
    if [[ -n "$font" ]]; then
        # Untuk Linux (X11)
        echo -n "$font" | xclip -selection clipboard 2>/dev/null || echo -n "$font" | wl-copy 2>/dev/null
        # Untuk macOS
        echo -n "$font" | pbcopy 2>/dev/null
        
        echo "Selected: $font (Copied to clipboard)"
    fi
}

findfontfam() {
    local selected
    # Mengambil path, family, dan style
    selected=$(fc-list : file family style | sort | fzf --height 40% --layout=reverse --border --prompt="🔍 Cari Font: ")

    if [[ -n "$selected" ]]; then
        # Mengambil hanya nama family untuk dicopy (opsional: ubah sesuai kebutuhan)
        local font_name=$(echo "$selected" | cut -d: -f2 | sed 's/^ //')
        
        # Copy ke clipboard
        echo -n "$font_name" | xclip -selection clipboard 2>/dev/null || echo -n "$font_name" | wl-copy 2>/dev/null
        echo -n "$font_name" | pbcopy 2>/dev/null
        
        echo "Selected Details: $selected"
        echo "Copied to clipboard: $font_name"
    fi
}

# YouTube audio downloader
alias ytmp3="python3 -m yt-dlp -x --audio-format mp3"
alias ytbest="python3 -m yt-dlp -x --audio-format best"
alias ytvideo="python3 -m yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"

# in your .bashrc/.zshrc/*rc
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# Letakkan di .bashrc atau .zshrc
frg() {
  rg --column --line-number --no-heading --color=always --smart-case "$1" | \
  fzf --ansi \
      --delimiter : \
      --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

# better df
bdf() {
    df -h --output=source,fstype,size,used,avail,pcent,target | \
    (read -r header; echo "$header"; printf "%s\n" "$header" | sed 's/./-/g'; sort -hk6 -r) | \
    bat --style=grid,numbers --color=always
}
