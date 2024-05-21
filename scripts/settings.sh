#!/bin/bash

SCRIPT_PWD="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PWD}")"
NVIM_DIR="$(dirname "${SCRIPT_DIR}")"
USER_SETTING_FILE="${NVIM_DIR}/lua/settings/user.lua"

function help_msg() {
	echo -e "\
options:
- e     edit user settings file with neovim
- h     print this help message
- i     initialize user file with normal preset
- r     remove user file"
}
function edit() {
	nohup nvim "${USER_SETTING_FILE}" &>/dev/null
}
function init() {
	echo 'return require("settings.presets.normal")' >"${USER_SETTING_FILE}"
}
function remove() {
	rm "${USER_SETTING_FILE}"
}

while getopts ':ehir' OPTION; do
	case "${OPTION}" in
	e)
		edit
		exit 0
		;;
	h)
		help_msg
		exit 0
		;;
	i)
		init
		exit 0
		;;
	r)
		remove
		exit 0
		;;
	*)
		echo -e "${CLR_ERROR} flag (-${OPTARG}) is not valid!"
		exit 1
		;;
	esac
done

help_msg
exit 1
