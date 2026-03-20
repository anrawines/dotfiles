## dotfiles using gitbare

````bash
git init --bare $HOME/.dotfiles
````

### add alias
````bash
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
````

### clone
````bash 
git clone --bare https://github.com/anrawines/dotfiles/ $HOME/.dotfiles
````

### checkout
````bash
cfg checkout 
````
