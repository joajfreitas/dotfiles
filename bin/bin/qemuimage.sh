#!/bin/bash

usage(){
	echo "usage: qemuimage FILE"
}

imgtype(){
	echo "1) raw"
	echo "2) qcow2"
	echo "Enter image format (1 or 2) and press [ENTER]:"
}

imgsize(){
	echo "Enter image size (ex: 4G) and press [ENTER]:"
}

main(){
	if [[ "$1" = "-h" ]]; then
		usage
	elif [[ -z "$1" ]]; then
		usage
	else
		imgtype
		read -r image
		imgsize
		read -r size
	fi
	if [[ "$image" -eq "1" ]]; then
		type="raw"
	fi
	if [[ "$image" -eq "2" ]]; then
		type="qcow2"
	fi
	if [[ ! -z "$image" ]]; then
		qemu-img create -f "$type" "$1" "$size"
	fi
}

main "$@"
