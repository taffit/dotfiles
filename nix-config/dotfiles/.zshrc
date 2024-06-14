

typeset -U path cdpath fpath manpath

# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Aliases
alias -- '..'='cd ..'
alias -- '...'='cd ../..'
alias -- 'd'='docker run --rm -it'
alias -- 'dc'='docker compose'
alias -- 'hm'='home-manager'
alias -- 'hmg'='home-manager generations'
alias -- 'hmrmg'='home-manager remove-generations'
alias -- 'hmxg'='home-manager expire-generations'
alias -- 'l'='ls -als --color'
alias -- 'n'='nnn'
alias -- 'nxs'='nix run . switch -- --flake .'
alias -- 'vimdiff'='nvim -d'

# Named Directory Hashes




