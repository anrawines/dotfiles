# 🐧 Dotfiles (Bare Git Repo)

My personal configuration files managed via a Bare Git Repository.

## 1. Local Setup (New Machine)
To get these configs onto a fresh install:

```bash
# Clone the repo as bare
git clone --bare [https://github.com/anrawines/dotfiles.git](https://github.com/anrawines/dotfiles.git) $HOME/.dotfiles

# Define the alias for the current session
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Backup existing config files that might conflict
mkdir -p .dotfiles-backup
cfg checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

# Checkout the actual files
cfg checkout

# Hide untracked files (so 'cfg status' stays clean)
cfg config --local status.showUntrackedFiles no
