

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/qlqypbb4z48g6xsfc9d79w2fka2c8635-zsh-5.9/share/zsh/$ZSH_VERSION/help"





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


if [[ $TERM != "dumb" ]]; then
  eval "$(/home/sysop/.nix-profile/bin/starship init zsh)"
fi

eval "$(/nix/store/8rcb0v4g2amx5fbqf2a0pvrk979wxynz-direnv-2.34.0/bin/direnv hook zsh)"


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




