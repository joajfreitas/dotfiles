#!/bin/bash

cachedir="${HOME}/.cache/16script"
scriptdir="${HOME}/.config/base16-shell/scripts"
confdir="${HOME}/.config"
xresurl="https://raw.githubusercontent.com/chriskempson/base16-xresources/master/xresources"
shurl="https://github.com/chriskempson/base16-shell.git"

xresch(){
	if [[ -f "${cachedir}/Xresources/${1}.Xresources" ]] && \
	grep -q 'color[0-21]' "${cachedir}/Xresources/${1}.Xresources" ; then
		echo "Xresources file found :)"
		xres="$(< ${cachedir}/Xresources/${1}.Xresources)"
		xrdb "${HOME}/.Xresources" > /dev/null
		xrdb -merge <<< "${xres}"
	else
		echo "Downloading Xresources from GitHub"
		curl -s "${xresurl}/${1}-256.Xresources" > "${cachedir}/Xresources/${1}.Xresources"
		xresch "${1}"
	fi
}

relthings(){
	echo "Reloading things."
	if [[ -d ${scriptdir} ]]; then
		for term in /dev/pts/[0-9]*; do
			[[ -w "${term}" ]] && "${scriptdir}/${1}.sh" > "${term}" &
		done
	else
		echo "base16-shell doesn't seem to be installed."
	fi
	if pgrep -x i3 > /dev/null && grep -q set_ "${confdir}/i3/config"; then
		i3-msg reload
	fi
	if pgrep -x polybar > /dev/null; then
		pkill -USR1 polybar
	fi
}

main(){
	if [[ ! -d "${cachedir}" ]]; then
		mkdir "${cachedir}"
		mkdir "${cachedir}/Xresources"
		curl http://ix.io/CTB > "${cachedir}/list"
	fi
	if [[ ! -d "${scriptdir}" ]] && [[ ! -f "${cachedir}/instno" ]]; then
		shinst
	fi
	if [[ -n "${1}" ]]; then
		if grep -q "${1}" "${cachedir}/list"; then
			echo "${1}" > "${cachedir}/lastuse"
			xresch "${1}"
			relthings "${1}"
		fi
	fi
	if [[ "${1}" == "-l" ]]; then
		main "$(< ${cachedir}/lastuse )"
	fi
	if [[ -x "${2}" ]]; then
		bash "${2}"
	fi
}

main "${@}"
