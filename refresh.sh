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

if [[ -v "INLINE_OUTPUT" ]]; then
    tput rmam
    refresh_nvim 2>&1 | while read -r line; do
        if [[ -n "$line" ]]; then
            echo -ne "\r\033[2K"
            echo -n $line
        fi
    done
    echo -ne "\r\033[2K"
    tput smam
else
    refresh_nvim
fi
