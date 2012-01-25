# STESH - .zshrc

[ -z "$PS1" ] && return # Don't bother if it's not an interactive shell

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
alias screen="TERM=screen screen"
alias grep="grep --color" 
alias mkdir="mkdir -p"
alias newtex="~/bin/newtex"
alias csc="mono-csc"

alias su="/usr/bin/su"
alias sudo="/usr/bin/sudo"
alias ssh="/usr/bin/ssh"

case $TERM in
	xterm*|rxvt|(K|a)term)
	precmd() {
		print -Pn "\033]0;%m:%~ %n\a" 
	}
	preexec() {
		print -Pn "\033]0;%m:%~ %n\a" 
	}
	;;
esac

# OS-specific
case $(uname) in 
    'Darwin') 

        # See MacPorts, if it's installed
        [ -d '/opt/local' ] && export PATH="/opt/local/bin:$PATH"

    	alias Vim='mvim' # MacVim
        local hostname=$(hostname)

        # Use GNU ls instead of BSD ls, if it's installed
        if [ -x '/opt/local/libexec/gnubin/ls' ]; then
            alias ls='/opt/local/libexec/gnubin/ls --color -F'
        else
            alias ls ='/bin/ls -FG'
        fi
    ;;

    'Linux')
        alias ls='ls --color -F'
        alias Vim='vim -g' # GVim
        local hostname=$(hostname --long)
    ;;
esac

# no history on boxes I don't have root on
$(hostname | egrep "*.s?css?.tcd.ie" > /dev/null) || (
    HISTFILE='~/.history'
    HISTSIZE=1000
    SAVEHIST=1000
    setopt HIST_REDUCE_BLANKS
    setopt appendhistory
)

# sh-style privilege markers
PRIV='$'
[ $UID = 0 ] && PRIV='#'

# hostname:directory user<privilege marker> [time]


long_hostname() {
    case $(uname) in
        'Darwin')
            /bin/hostname ;;
        'Linux')
            /bin/hostname --long
    esac
}


local hostColour=${cyan}
PROMPT="${hostColour}$(long_hostname)%1 ${white}:${blue}%~${NOCOLOR} %n${white}$PRIV ${NOCOLOR}"
RPS1="${NOCOLOR}[${GREEN}%T${NOCOLOR}]"


[ ! -f "$HOME/.nosyntax" -a -d "$HOME/.zsh-syntax-highlighting" ] && source "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 

# Machine-specific settings
[ -e "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
