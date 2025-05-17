#!/bin/bash

rm -rf ~/{.local/{share,state},.cache}/nvim

nvim --headless "+StarterPack" \
    "+lua require('nvim-treesitter.configs').setup { ensure_installed = {       \
    'bash','rust','cpp','javascript','css','html','python'                      \
    }, sync_install = true }" "+qa"
