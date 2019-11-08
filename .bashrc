# Taken from the default .bashrc from a (WSL-)bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Set visual bell style in bash (right mouse click -> options in mintty)
set bell-style visible

# bash prompt including git branch and python virtualenv
source ~/.bash_prompt

# git functions / prompt
#source ~/.git-prompt

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#PROMPT_BEFORE="$txtcyn\u@\h $txtwht\w$txtrst"
#PROMPT_AFTER="\\n\\\$ "
#PROMPT_COMMAND='__git_ps1 "$PROMPT_BEFORE" "$PROMPT_AFTER"'

#export GIT_PS1_SHOWDIRTYSTATE="true"
#export GIT_PS1_SHOWSTASHSTATE="true"
#export GIT_PS1_SHOWUNTRACKEDFILES="true"
#export GIT_PS1_SHOWUPSTREAM="auto"
#export GIT_PS1_SHOWCOLORHINTS="true"

# Doing some OS-related settings
# The following check was taken from https://stackoverflow.com/a/3466183/1785391
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac


# Putting all general aliases in a separate file
# Eventually those aliases are then overwritten depending on the OS
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


#echo ${machine}
if [ ${machine} == 'Cygwin' ]; then
  # Start the graphical emacs within Windows
  alias emacs="cygstart /c/~NoInstall/Editoren/emacs-25.3/bin/emacsclientw.exe -na \"C:/~NoInstall/Editoren/emacs-25.3/bin/runemacs.exe\" -c -n"
  alias semacs="EMACS_USER_DIRECTORY=~/.spacemacs.d cygstart /c/~NoInstall/Editoren/emacs-25.3/bin/emacsclientw.exe -na \"C:/~NoInstall/Editoren/emacs-25.3/bin/runemacs.exe\" -c -n";
  # For preventing the BrokenFilesystemwarning in cygwin / werkzeug
  export PYTHONIOENCODING=utf-8
  # For the python shell in cygwin
  #export PYTHONUNBUFFERED=1

  alias c='cd /c'
  alias w='cd /c/~ws'
fi

# Setting the XDG-environment variables
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Eventually use an already set environment variable
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=~/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=~/.local}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Run other commands, depending on the host we are on (do not check in)
if [ -f ~/.bash_host ]; then
    . ~/.bash_host
fi

