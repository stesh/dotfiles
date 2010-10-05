# STESH - .zshrc

[[ -z "$PS1" ]] && return # Don't bother if it's not an interactive shell

cd

# Load tab completion
autoload -U compinit
compinit
 
# Load the prompt stuff
autoload -U promptinit
promptinit

PROMPT="${white}%n@${GRAY}%m%1 ${white}:${blue}%~${white}$ ${NOCOLOR}"
# Put a prompt in xterm window titles
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

# Define some colours
local blue="%{"$'\e[1;34m'"%}"
local gray="%{"$'\e[1;30m'"%}"
local GRAY="%{"$'\e[0;37m'"%}"
local GREEN="%{"$'\e[0;32m'"%}"
local white="%{"$'\e[1;37m'"%}"
local NOCOLOR="%{"$'\e[0m'"%}"

# Altered commands
alias nano="vim" # Wean off nano 
alias nmap="nmap -A" # Digs deeper
alias s="screen -U -dR"
alias screen="TERM=screen screen"
alias grep="grep --color" # Highlighting in grep
alias mkdir="mkdir -p"
alias ping="ping -c 4" # Four is enough for anyone
alias top="nice top" # Don't hog my resources pls
alias newtex="~/bin/newtex"

# SSH Shortcuts
alias d="ssh -L 8080:127.0.0.1:8080 stesh@server.stephen-shaw.net"
alias b="ssh -i ~/.ssh/shawbox  -L 5480:127.0.0.1:548 stesh@shawbox.stephen-shaw.net" # Forward AFP
alias cs="ssh -i ~/.ssh/macneill shawsd@macneill.cs.tcd.ie"
alias nexus="ssh -i ~/.ssh/nexus stesh@ducss.cs.tcd.ie"
alias spoon="ssh -i ~/.ssh/spoon -L 8000:localhost:8000 stesh@spoon.netsoc.tcd.ie"
alias matrix="ssh -i ~/.ssh/matrix stesh@matrix.netsoc.tcd.ie"
alias cube="ssh -i ~/.ssh/cube stesh@cube.netsoc.tcd.ie"
alias titanic="ssh -i ~/.ssh/titanic stesh@titanic.netsoc.tcd.ie"

export PATH=$PATH:~/bin

# OS X-specific things
if   [[ $( uname ) == Darwin ]]; then
	if [[ "$TERM" != "dumb" ]]; then # make sure it isn't a dumb terminal
		alias ls="ls -G" # Coloured ls
	fi
	export PATH="/opt/local/bin:$PATH"
    #source /sw/bin/init.sh
	alias fishow="defaults write com.apple.finder AppleShowAllFiles -bool true;killall Finder" #show hidden files in Finder
	alias fihide="defaults write com.apple.finder AppleShowAllFiles -bool false;killall Finder" #hide them again
	alias Vim="mvim"

# Linux-specific things
elif [[ $( uname ) == Linux ]]; then
	if [[ "$TERM" != "dumb" ]]; then
		alias ls="ls --color" # Coloured ls
	fi
fi

local hostColour=${gray}

if [[ -e "$HOME/.zshrc.local" ]]; then 
	source "$HOME/.zshrc.local"
fi

PROMPT="${white}%n@${hostColour}%m%1 ${white}:${blue}%~ ${NOCOLOR}[${GREEN}%T${NOCOLOR}]${white}%# ${NOCOLOR}"
