# Fish shell aliases.
#
# Corresponds to the aliases defined for Bash and Zsh in
# `~/.config/shell/aliases.sh`, kept in sync so both shells share the same
# shortcuts.

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cm='chezmoi'
alias cma='chezmoi apply'
alias cmdiff='chezmoi diff'
alias cmstatus='chezmoi status'
alias cmupdate='chezmoi update'

alias g='git'
alias gst='git status --short --branch'
alias gl='git log --oneline --decorate --graph -20'

alias n='nnn'
alias v='nvim'
