#!/bin/bash

if [[ -z $1 ]]; then
	echo "usage: qems <qemu image> <boot iso>"
fi

if [[ -z $2 ]]; then
	qemu-system-x86_64 -soundhw hda -smp 6 -m 4G -enable-kvm -boot order=d $1
else
	qemu-system-x86_64 -soundhw hda -smp 6 -m 4G -enable-kvm -cdrom $2 -boot order=d $1 -sp
fi
