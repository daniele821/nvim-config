# nvim-config
neovim configuration directory (written 100% by myself)

# installation
```
git clone https://github.com/daniele821/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

# customizations

look at file `lua/settings/init.lua`

# BUGS

- autocmd error if parser not installed for certain languages -> just install lua, vimdoc, markdown treesitter parser 

# TODO

- [ ] fix qqq not immediatly exiting macro recording (probably a plugin mapping)
