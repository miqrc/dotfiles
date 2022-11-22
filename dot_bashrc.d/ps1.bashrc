parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PROMPT_COMMAND=__prompt_command  
__prompt_command() {
    local EXIT="$?"               
    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local Blue='\[\e[0;34m\]'

    PS1="${Blue}\u@\h:\w${RCol}$(parse_git_branch)"

    if [ $EXIT != 0 ]; then
        PS1+="${Red}!${RCol}\$ "       
    else
        PS1+="\$ "       
    fi
}
