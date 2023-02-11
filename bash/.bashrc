#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -1 --color=auto'
PS1='[\u@\h \W]\$ '

source .profile
source .aliases

export HISTFILE="${XDG_STATE_HOME}"/bash/history

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
