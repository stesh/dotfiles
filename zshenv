setopt correct # Turn on spelling correction 
setopt correctall
setopt extended_glob

export PAGER="/usr/bin/env less"
export EDITOR="/usr/bin/env vim"
export PATH=$PATH:~/bin

# Options for less
export LESSCHARSET=utf-8
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
