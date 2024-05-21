# nvim-config
neovim configuration directory (written 100% by myself)

# installation
```
git clone https://github.com/daniele821/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

# TODO

- [x] transition from neovim 0.9.5 to 0.10.0:
    - [x] add toggle for inlay hints
    - [x] remove now default lsp mapping, like `K`, `[d`, `]d`, ...
    - [x] consider switching to builtin commenting system
    - [x] see how to deal with E325 (multiple programs opening the same file)
    - [x] try out lualine progress replacement for fidget
    - [x] remove all ensure installed lsp, and provide an user command to download them instead

- [x] lazy load -> have only lazy, colorscheme and statusline when running `nvim`:
    - [x] find way to lazily load lspconfig 
    - [x] lazy load lsplint (on filetype)
    - [x] lazy load conform (on filetype and `LspAttach`)
    - [x] lazy load completions (on `InsertEnter`)
    - [x] lazy load gitsigns and treesitter only if currently editing a file

- [x] update statusline:
    - [x] show active lsp
    - [x] show active formatters

# FIXES

- [x] `:StarterPackLsp` should not reinstall already installed lsp
