#!/bin/sh
#
#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources
#fi
#
#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi
#
#if [ -f "$userresources" ]; then
#    xrdb -merge "$userresources"
#fi
#
#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi
#
## start some nice programs
#
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi

export XDG_CONFIG_HOME="$HOME/.config"
source ~/.aliases

# keyboard
setxkbmap us
setxkbmap -option "caps:escape"
setxkbmap -option "compose:ralt"
xset r rate 150 55

/home/joaj/bin/layout.sh
dbus-update-activation-environment --systemd DISPLAY

#wal -R
exec i3
