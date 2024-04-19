#!/bin/env bash

# paths variables
SCRIPT_PWD="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PWD}")"
# flag variables
FLAG_DIFF='n'

# utility functions
function help_msg () {
    echo -n "script to automagically pull from origin and commit new changes 

flags:
-d      show diffs
-h      show this help message
"
}

# parse flags
while getopts ':dh' OPTION; do
    case "${OPTION}" in
        d) FLAG_DIFF='y' ;;
        h) help_msg; exit 0;;
        *) echo -e "flag (-${OPTARG}) is not valid!"; exit 1;;
    esac
done

git -C "${SCRIPT_DIR}" pull
git -C "${SCRIPT_DIR}" remote prune origin
if [[ -n "$(git -C "${SCRIPT_DIR}" status -s)" ]]; then
    git -C "${SCRIPT_DIR}" status -s 
    [[ "${FLAG_DIFF}" == 'y' ]] && git -C "${SCRIPT_DIR}" diff HEAD
    echo -n "write the new commit name: "
    read -r msg </dev/tty
    git -C "${SCRIPT_DIR}" add "${SCRIPT_DIR}"
    git -C "${SCRIPT_DIR}" commit -m "${msg}"
    git -C "${SCRIPT_DIR}" push 
    git -C "${SCRIPT_DIR}" restore --staged "${SCRIPT_DIR}"
fi
