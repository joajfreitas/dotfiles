#!/bin/bash

if [[ -n $1 ]]; then
	readlink -f "$1" > ~/scripts/lastbitbg
	xsetroot -bitmap $1 -bg "$(xrdb -query | grep 'background' | cut -f2 | head -n 1)" -fg $(xrdb -query | grep 'color21' | cut -f2 | head -n 1) && echo "Success!"
else
	cat ~/scripts/lastbitbg
fi
