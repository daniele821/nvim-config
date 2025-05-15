# nvim-config
neovim configuration directory (written 100% by myself)

# installation
```
git clone https://github.com/daniele821/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

# ideas

- [neovim 0.11 lsp setup](https://davelage.com/posts/neovim-lsp-0.11/)
- [mason lsp list](https://davelage.com/posts/)
- [lspconfig lsp list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
- [neovim setup pluginless](https://boltless.me/posts/neovim-config-without-plugins-2025/)
- [neovim config files](https://github.com/boltlessengineer/nvim_rocks)
- [blink completions](https://cmp.saghen.dev/)
- [list of treesitters](https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers) 

# notes 

- oil.nvim can be set as default file explorer IF NOT LAZY LOADED. 
    - nvim oil-ssh@server/path/to/file

# todo

- [ ] lsp?
    - [ ] manually add lsp configuration (use NO plugins)
    - [ ] how to customize lsp settings?
    - [ ] cleanup lsp on exit
    - [ ] :Commands which wrap lua code to download and handle lsp servers?
- [ ] formatting? 
    - [ ] no formatting on save, but i would like a `gff` binding
    - [ ] do i really want to use `Conform` again?
