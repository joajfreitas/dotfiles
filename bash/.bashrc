# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

source .profile
source .aliases

# vim: set ft=sh:
