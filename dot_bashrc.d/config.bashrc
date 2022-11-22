# vi mode
set -o vi
# normal mode with jj
bind '"jj":vi-movement-mode'

# clear with Ctrl+L
bind -x '"\C-l": clear;'

# history
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=2000