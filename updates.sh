#!/bin/bash

# globals
set -e
SCRIPT_PWD="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "${SCRIPT_PWD}")"

# configuration variables
LSP_LIST=(
)

# download / update lsp configs
REPO_URL="https://github.com/neovim/nvim-lspconfig"
LSP_DIR="${SCRIPT_DIR}/lsp"
mkdir -p "$LSP_DIR"
TMP_DIR="$(mktemp -d)"
git clone "$REPO_URL" "$TMP_DIR" &>/dev/null
for lsp in "${LSP_LIST[@]}"; do
    NEW_FILE="$TMP_DIR/lsp/$lsp.lua"
    OLD_FILE="$LSP_DIR/$lsp.lua"
    if [[ ! -f "$NEW_FILE" ]]; then
        echo -e "\e[1;31m$lsp\e[m: "
        echo "is not a known lsp!"
    elif [[ ! -f "$OLD_FILE" ]]; then
        echo -e "\e[1;33m$lsp\e[m: missing! file is being copied..."
        cp "$NEW_FILE" "$OLD_FILE"
    elif ! diff -sq "$NEW_FILE" "$OLD_FILE" &>/dev/null; then
        echo -e "\e[1;33m$lsp\e[m: not up to date! file is being copied..."
        cp "$NEW_FILE" "$OLD_FILE"
    else
        echo -e "\e[1;32m$lsp\e[m: up to date!"
    fi
done
rm -rf "$TMP_DIR"
