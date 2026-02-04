# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

source /home/joaj/.profile
source /home/joaj/.aliases

# vim: set ft=sh:

#. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
#eval "$(atuin init bash)"

. "$HOME/.local/share/../bin/env"
