#!/bin/bash

function refresh_nvim() {
    [[ -v "PURGE_DATA" ]] && rm -rf ~/{.local/{share,state},.cache}/nvim

    nvim --headless "+StarterPack" \
        "+lua require('nvim-treesitter.configs').setup { ensure_installed = {       \
    'bash',             \
    'cpp',              \
    'css',              \
    'dockerfile',       \
    'git_config',       \
    'git_rebase',       \
    'gitattributes',    \
    'gitcommit',        \
    'gitignore',        \
    'go',               \
    'gomod',            \
    'gosum',            \
    'html',             \
    'javascript',       \
    'php',              \
    'python',           \
    'rust',             \
    'sql',              \
    'toml',             \
    'typescript',       \
    'yaml',             \
    }, sync_install = true }" "+qa"
}

if [[ -v "FULL_OUTPUT" ]]; then
    refresh_nvim
    echo
else
    tput rmam
    refresh_nvim 2>&1 | while read -r line; do
        if ! [[ $line =~ ^[[:space:]]*$ ]]; then
            echo -ne "\r\033[2K"
            echo -n "$line"
        fi
    done
    echo -ne "\r\033[2K"
    tput smam
fi
