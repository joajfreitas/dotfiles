#!/bin/bash #!/bin/sh userresources=$HOME/.Xresources usermodmap=$HOME/.Xmodmap sysresources=/etc/X11/xinit/.Xresources sysmodmap=/etc/X11/xinit/.Xmodmap # merge in defaults and keymaps 
if [ -f $sysresources ]; then
	echo "ola"
    #xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	echo "ola"
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	echo "ola"
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	echo "ola"
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
xrdb .Xresources

setxkbmap pt
#xcape -e 'Ctrl=Escape'
#setxkbmap -option ctrl:swapcaps
#
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape'
#
setxkbmap -option "caps:swapescape"
xset r rate 150 55


xrandr --output LVDS-1 --primary --mode 1366x768 --pos 1280x256 --rotate normal --output DP-1 --off --output HDMI-1 --off --output VGA-1 --mode 1280x1024 --pos 0x0 --rotate normal

#source ~/.profile
#source ~/.bashrc

#if [ -n "$GTK_MODULES" ]; then
#    GTK_MODULES="${GTK_MODULES}:unity-gtk-module"
#else
#    GTK_MODULES="unity-gtk-module"
#
#if [ -z "$UBUNTU_MENUPROXY" ]; then
#    UBUNTU_MENUPROXY=1

#qmenu_registrar &
clipmenud &
/home/joaj/bin/layout.sh
exec awesome
function i3 {
	exec i3
}

function xmonad {
	exec xmonad
}

#default=awesome
#session=${1:-$default}
#case $session in
#    i3			) i3;;
#	xmonad		) xmonad;;
#	awesome		) awesome;;
#    # No known session, try to run it as command
#    *) exec $1;;
#esac
