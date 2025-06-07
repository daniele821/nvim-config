return {
    -- mason packages to install.
    -- [lsp]: name of lsp provided by package
    -- [bin]: name of executable, so that local binary is reused if found
    lsps = {
        ["bash-language-server"] = { lsp = "bashls" },
        ["css-lsp"] = { lsp = "cssls" },
        ["gopls"] = { lsp = "gopls" },
        ["html-lsp"] = { lsp = "html" },
        ["json-lsp"] = { lsp = "jsonls" },
        ["lua-language-server"] = { lsp = "lua_ls" },
        ["ruff"] = { lsp = "ruff" },
        ["rust-analyzer"] = { lsp = "rust_analyzer", bin = "rust-analyzer" },
        ["shellcheck"] = {},
        ["typescript-language-server"] = { lsp = "ts_ls" },
    },
    -- languages for which to start treesitter parsers
    -- [map]: instead of installing it, remap it to the specified language
    parsers = {
        ["bash"] = {},
        ["c"] = {},
        ["cpp"] = {},
        ["css"] = {},
        ["go"] = {},
        ["html"] = {},
        ["javascript"] = {},
        ["json"] = {},
        ["markdown"] = {},
        ["php"] = {},
        ["python"] = {},
        ["rust"] = {},
        ["sh"] = { map = "bash" },
        ["sql"] = {},
        ["toml"] = {},
        ["typescript"] = {},
        ["yaml"] = {},
    },
}
