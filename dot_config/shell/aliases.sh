# Shared aliases for Bash and Zsh.
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alF'
alias la='ls -A'
if command -v eza >/dev/null 2>&1; then
    alias l='eza -al --color=always --group-directories-first --icons=always'
else
    alias l='ls -als --color=auto --group-directories-first'
fi

alias cm='chezmoi'
alias cma='chezmoi apply'
alias cmdiff='chezmoi diff'
alias cmstatus='chezmoi status'
alias cmupdate='chezmoi update'

alias g='git'
alias gst='git status --short --branch'
alias gl='git log --oneline --decorate --graph -20'
alias dc='docker compose'
alias n='nnn'
alias v='nvim'
