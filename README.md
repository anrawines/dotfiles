## dotfiles using gitbare

git init --bare $HOME/.dotfiles

### add alias
``` alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' ```

clone
``` git clone --bare https://github.com/anrawines/dotfiles/ $HOME/.dotfiles ```

and
``` config checkout ```
