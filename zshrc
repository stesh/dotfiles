# STESH - .zshrc

[[ -z "$PS1" ]] && return # Don't bother if it's not an interactive shell

cd

export PATH=$PATH:~/bin

local blue="%{"$'\e[1;34m'"%}"
local cyan="%{"$'\e[1;36m'"%}"
local red="%{"$'\e[1;31m'"%}"
local gray="%{"$'\e[1;30m'"%}"
local GRAY="%{"$'\e[0;37m'"%}"
local green="%{"$'\e[1;32m'"%}"
local GREEN="%{"$'\e[0;32m'"%}"
local white="%{"$'\e[1;37m'"%}"
local NOCOLOR="%{"$'\e[0m'"%}"
local cyan="%{"$'\e[1;36m'"%}"

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*' format "$green%B---- %d ----%b"
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}searching for %B%d%b%{\e[0m%}'
zstyle ':completion:*:messages' format '%B%U%d%u%b'
zstyle ':completion:*:warnings' format "%B$red%}no match for $white%d%b"
zstyle ':completion:*' group-name '' 
zstyle ':completion:*' menu yes select

zstyle :compinstall filename "$HOME/dotfiles/zshrc"

autoload -Uz compinit
compinit

setopt autocd
setopt extendedglob
setopt cdablevars
setopt ignoreeof
#setopt noclobber
setopt interactivecomments
setopt BANG_HIST
setopt nomatch
setopt SH_WORD_SPLIT
setopt notify
setopt correct
setopt correctall

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

alias nano="vim" 
alias nmap="nmap -A" 
alias screen="TERM=screen screen"
alias grep="grep --color" # Highlighting in grep
alias mkdir="mkdir -p"
alias ping="ping -c 4" 
alias newtex="~/bin/newtex"
alias csc="mono-csc"


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

if [[ $( uname ) == Darwin ]]; then
	if [[ "$TERM" != "dumb" ]]; then # make sure it isn't a dumb terminal
		alias ls="ls -G" # Coloured ls
	fi
	export PATH="/opt/local/bin:$PATH"
    #source /sw/bin/init.sh
	alias fishow="defaults write com.apple.finder AppleShowAllFiles -bool true;killall Finder" #show hidden files in Finder
	alias fihide="defaults write com.apple.finder AppleShowAllFiles -bool false;killall Finder" #hide them again
	alias Vim="mvim"
    local hostname=`hostname`

elif [[ $( uname ) == Linux ]]; then
	if [[ "$TERM" != "dumb" ]]; then
		alias ls="ls --color" # Coloured ls
        alias Vim="vim -g"
        local hostname=`hostname --long`
	fi
fi

local hostColour=${cyan}

if echo hostname | egrep "*.s?css?.tcd.ie" > /dev/null; then

else
    HISTFILE=~/.history
    HISTSIZE=1000
    SAVEHIST=1000
    setopt HIST_REDUCE_BLANKS
    setopt appendhistory
fi


if [ $UID = 0 ]; then
    PRIV="#"
else
    PRIV="$"
fi


PROMPT="${hostColour}%m%1 ${white}:${blue}%~${NOCOLOR} %n${white}$PRIV ${NOCOLOR}"
RPS1="${NOCOLOR}[${GREEN}%T${NOCOLOR}]"

[ -e "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

[ ! -f "$HOME/.nosyntax" -a -d "$HOME/.zsh-syntax-highlighting" ] && source "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 
