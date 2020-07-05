export VISUAL=vim
export EDITOR=vim
export BROWSER=brave

HISTIGNORE="jrnl *"

#export QT_STYLE_OVERRIDE=breeze
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

#export PAGER=~/.vim/bundle/vimpager/vimpager
export PAGER=less

export TODO_DB_PATH=~/Documents/.todos

export PATH=$PATH:/opt/microchip/xc16/v1.33/bin
export PATH=/home/joaj/bin:$PATH
export PATH=$PATH:/home/joaj/go/bin
export PATH=$PATH:/home/joaj/sources/ompp/bin

export HOSTNAME=$(hostname)

#source /usr/share/z/z.sh

TZ='Europe/Lisbon'; export TZ

source ~/.aliases

# vim: set ft=sh:
