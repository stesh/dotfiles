# STESH - .zshrc

[[ -z "$PS1" ]] && return # Don't bother if it's not an interactive shell

cd

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle :compinstall filename "$HOME/dotfiles/zshrc"

autoload -Uz compinit
compinit

if echo `hostname` | egrep "*.s?css?.tcd.ie" > /dev/null; then

else
    HISTFILE=~/.history
    HISTSIZE=1000
    SAVEHIST=1000
    setopt HIST_REDUCE_BLANKS
    setopt appendhistory
fi

setopt nohup
setopt autocd
setopt extendedglob
setopt cdablevars
setopt ignoreeof
setopt noclobber
setopt interactivecomments
setopt nobanghist
setopt nomatch
setopt SH_WORD_SPLIT
setopt notify
setopt correct
setopt correctall

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

PROMPT="${white}%n@${GRAY}%m%1 ${white}:${blue}%~${white}$ ${NOCOLOR}"

case $TERM in
	xterm*|rxvt|(K|a)term)
	precmd () {
		print -Pn "\033]0;%n@%m:%~\a" 
	}
	preexec () {
		print -Pn "\033]0;%n@%m:%~\a" 
	}
	;;
esac

local blue="%{"$'\e[1;34m'"%}"
local gray="%{"$'\e[1;30m'"%}"
local GRAY="%{"$'\e[0;37m'"%}"
local GREEN="%{"$'\e[0;32m'"%}"
local white="%{"$'\e[1;37m'"%}"
local NOCOLOR="%{"$'\e[0m'"%}"

alias nano="vim" # Wean off nano 
alias nmap="nmap -A" # Digs deeper
alias s="screen -ax"
alias screen="TERM=screen screen"
alias grep="grep --color" # Highlighting in grep
alias mkdir="mkdir -p"
alias ping="ping -c 4" # Four is enough for anyone
alias top="nice top" # Don't hog my resources pls
alias newtex="~/bin/newtex"

export PATH=$PATH:~/bin

if [[ $( uname ) == Darwin ]]; then
	if [[ "$TERM" != "dumb" ]]; then # make sure it isn't a dumb terminal
		alias ls="ls -G" # Coloured ls
	fi
	export PATH="/opt/local/bin:$PATH"
    #source /sw/bin/init.sh
	alias fishow="defaults write com.apple.finder AppleShowAllFiles -bool true;killall Finder" #show hidden files in Finder
	alias fihide="defaults write com.apple.finder AppleShowAllFiles -bool false;killall Finder" #hide them again
	alias Vim="mvim"

elif [[ $( uname ) == Linux ]]; then
	if [[ "$TERM" != "dumb" ]]; then
		alias ls="ls --color" # Coloured ls
        alias Vim="vim -g"
	fi
fi

local hostColour=${gray}

if [[ -e "$HOME/.zshrc.local" ]]; then 
	source "$HOME/.zshrc.local"
fi

PROMPT="${white}%n@${hostColour}%m%1 ${white}:${blue}%~ ${NOCOLOR}[${GREEN}%T${NOCOLOR}]${white}%# ${NOCOLOR}"
