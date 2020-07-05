#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -1 --color=auto'
PS1='[\u@\h \W]\$ '

source .profile

#EDITOR=/usr/bin/vim
#export PATH=$PATH:/opt/microchip/xc16/v1.33/bin
#PATH="$PATH:$HOME/bin"
#PATH="$PATH:/opt/microchip/mplabx/v4.05/mplab_ipe"
#export PATH=$PATH:/opt/microchip/mplabx/v4.05/mplab_ipe/
#export PATH=$PATH:/usr/lib/emscripten
# personal config starts here

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
