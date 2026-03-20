## dotfiles using gitbare

git init --bare $HOME/.dotfiles


alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/anrawines/dotfiles/ $HOME/.dotfiles
config checkout
