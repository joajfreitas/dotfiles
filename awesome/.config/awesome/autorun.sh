#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run nm-applet
run conky
run compton -f
run wallpapers.py
run blueman-applet
run /home/joaj/.screenlayout/layout.sh
