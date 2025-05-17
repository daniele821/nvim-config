#!/bin/bash

rm -rf ~/{.local/{share,state},.cache}/nvim

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
