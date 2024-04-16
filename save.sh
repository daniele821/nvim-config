#!/bin/env bash

SCRIPT_PWD="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PWD}")"

git -C "${SCRIPT_DIR}" pull
git -C "${SCRIPT_DIR}" prune origin
if [[ -n "$(git -C "${SCRIPT_DIR}" status -s)" ]]; then
    git -C "${SCRIPT_DIR}" status -s 
    echo -n "write the new commit name: "
    read -r msg </dev/tty
    if [[ -n "${msg}" ]]; then
        git -C "${SCRIPT_DIR}" add "${SCRIPT_DIR}"
        git -C "${SCRIPT_DIR}" commit -m "${msg}"
        git -C "${SCRIPT_DIR}" push 
    fi
fi
