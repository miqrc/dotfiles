# CONFIG

## vi mode
set -o vi
## normal mode with jj
bind '"jj":vi-movement-mode'

EDITOR=nvim

## clear with Ctrl+L
bind -x '"\C-l": clear;'

## history
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=2000


# ALIASES

alias ll='ls -lFh'
alias la='ls -AlFh'
alias l='ls -CF'

alias gst='git status'
alias gco='git checkout'
alias gaa='git add -A'


# ENV

export PATH=$PATH:$HOME/bin
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export PATH=$PATH:$HOME/Android/Sdk/platform-tools
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/jre-openjdk/


# PS1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND=__prompt_command  
__prompt_command() {
    local EXIT="$?"               
    local RCol='\[\e[0m\]'

    local Red='\[\033[01;31m\]'
    local Green='\[\033[01;32m\]'
    local White='\[\033[01;32m\]'
    local Blue='\[\033[01;34m\]'

    #PS1="${Green}\u@\h${White}:${Blue}\w${RCol}$(parse_git_branch)"
    PS1="${Green}\u${White}:${Blue}\w${RCol}$(parse_git_branch)"

    if [ $EXIT != 0 ]; then
        PS1+="${Red}!${RCol}\$ "       
    else
        PS1+="\$ "       
    fi
}


# Z

. ~/.zjump/z.sh

