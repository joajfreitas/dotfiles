#!/bin/bash #!/bin/sh userresources=$HOME/.Xresources usermodmap=$HOME/.Xmodmap sysresources=/etc/X11/xinit/.Xresources sysmodmap=/etc/X11/xinit/.Xmodmap # merge in defaults and keymaps 
if [ -f $sysresources ]; then
    #xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
xrdb "XDG_CONFIG_HOME/X11/xresources"

setxkbmap us
setxkbmap -option "caps:escape"
xset r rate 150 55


xrandr --output DVI-D-0 --off --output HDMI-0 --mode 2560x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --mode 1920x1080 --pos 2560x0 --rotate normal

clipmenud &
/home/joaj/bin/layout.sh

wal -R
exec i3
