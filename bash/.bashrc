# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

source /home/joaj/.profile
source /home/joaj/.aliases

# vim: set ft=sh:
