#!/bin/bash

if command -v xclip 1>/dev/null; then
	if [[ -p /dev/stdin ]] ; then
		xclip -i -selection clipboard
	else
		xclip -o -selection clipboard
	fi
else
	echo "Remember to install xclip"
fi
