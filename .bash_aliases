# From a default .bashrc of a (WSL-)bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


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

