# nvim-config
neovim configuration directory (written 100% by myself)

# installation
```
git clone https://github.com/daniele821/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

# ideas

- [mason lsp list](https://mason-registry.dev/registry/list)
- [lspconfig lsp list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)
- [neovim setup pluginless](https://boltless.me/posts/neovim-config-without-plugins-2025/)
- [list of treesitters](https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers)
- [manually add treesitters](https://thevaluable.dev/tree-sitter-neovim-overview/)
- [vim spell files](https://www.vim.org/mirrors.php) 
- [linting article](https://www.josean.com/posts/neovim-linting-and-formatting)

# notes 

- oil.nvim can be set as default file explorer IF NOT LAZY LOADED. 
    - nvim oil-ssh@server/path/to/file

# todo

- [ ] lsp (on `experimental`)
    - [x] manually add lsp configuration (use NO plugins)
    - [x] how to customize lsp settings?
    - [x] cleanup lsp on exit
    - [x] show diagnostic messages as virtual text
    - [x] show sources of diagnostic errors
- [ ] formatting? 
    - [ ] no formatting on save, but i would like a `gff` binding
    - [ ] do i really want to use `Conform` again?
- [x] status line -> JUST USE TELESCOPE TO LIST DIAGNOSTICS AND GIT STATUS
    - [x] ~add count of diagnostic hint, info, warns, errors~
    - [x] ~add amount of changed git lines~
- [x] cmd to autoinstall all treesitter parser (:TSInstall) and lsps (:MasonInstall)
- [ ] linter?
    - [x] ~[lsp wrapper](https://github.com/mattn/efm-langserver)~ (a pain to deal with)
    - [ ] [nvim-lint](https://github.com/mfussenegger/nvim-lint) (kinda buggy and problematic)
