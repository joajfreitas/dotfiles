#!/bin/bash

if [[ "$1" == base16-*.png ]]; then
	~/scripts/16script/16script.sh "${1::-4}" ~/scripts/16script/16scriptpart2.sh
	echo "${1::-4}" > ~/.background/colors
	if [[ -e ~/.background/wal ]]; then
		ln -s "$(< ~/.background/wal)" ~/.background/current
		rm ~/.background/wal
	fi
elif [[ "$1" == "-g" ]]; then
	pgrep -x xwinwrap > /dev/null && killall xwinwrap
	rm ~/.background/wal &> /dev/null
	rm ~/.background/current &> /dev/null
	ln -s "$(readlink -f "$2")" ~/.background/current
	if [[ "$2" == *.gif ]]; then
		xwinwrap -ov -ni -fs -- mpv --no-config -vo x11 -wid WID --keepaspect=no --loop --really-quiet "$2" &
	else
		feh --bg-fill ~/.background/current
	fi
elif [[ "$1" == "-e" ]]; then
	if [[ -e ~/.background/wal ]]; then
		if grep -q .gif ~/.background/wal; then
			xwinwrap -ov -ni -fs -- mpv --no-config -vo x11 -wid WID --keepaspect=no --loop -really-quiet "$(< ~/.background/wal)" &
		fi
		wal -i "$(< ~/.background/wal)"
	elif readlink -f "$(< ~/.background/current)" | grep -q .gif; then
		xwinwrap -ov -ni -fs -- mpv --no-config -vo x11 -wid WID --keepaspect=no --loop --really-quiet "$(< ~/.background/current)" &
	else
		feh --bg-fill ~/.background/current
	fi
elif [[ "$1" == "-s" ]]; then
	[[ -e ~/.background/wal ]] && (cat ~/.cache/wal/sequences &)
	[[ -e ~/.background/colors ]] && ~/.config/base16-shell/scripts/"$(< ~/.background/colors).sh"
else
	wal -i "$1"
	~/scripts/16script/16scriptpart2.sh
	pgrep -x xwinwrap && killall xwinwrap
	if [[ "$1" == *.gif ]]; then
		xwinwrap -ov -ni -fs -- mpv --no-config -vo x11 -wid WID --keepaspect=no --loop --really-quiet "$1" &
	fi
	[[ -f ~/.background/current ]] && rm ~/.background/current
	[[ -f ~/.background/colors ]] && rm ~/.background/colors
	readlink -f "$1" > ~/.background/wal
fi
disown &> /dev/null
