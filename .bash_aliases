
# Some useful aliases
alias grep='grep --color=auto --exclude==*.pyc'
alias du='du -chax'
alias dus='du -chaxd 1 | sort -hr'
alias df='df -h --total'

# ls
alias l='ls -hals --color=auto --group-directories-first'
alias ls='ls -hFX --color=auto --group-directories-first'
alias ll='ls -l'

# cd
alias back='cd $OLDPWD' # same as 'cd -'?
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias h='cd ~'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

