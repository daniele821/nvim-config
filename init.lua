-- core configurations
require("thebest.configs.options")
require("thebest.configs.autocmd")
require("thebest.configs.keymaps")

-- install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- install plugins using lazy
require("lazy").setup({
    require("thebest.plugins.core.colorscheme"),
    require("thebest.plugins.core.explorer"),
    require("thebest.plugins.core.gitsigns"),
    require("thebest.plugins.core.telescope"),
    require("thebest.plugins.core.treesitter"),
    require("thebest.plugins.lsp.completions"),
    require("thebest.plugins.lsp.formatters"),
    require("thebest.plugins.lsp.linters"),
    require("thebest.plugins.lsp.lspconfig"),
    require("thebest.plugins.lsp.mason"),
    require("thebest.plugins.lsp.statusline"),
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tohtml",
                "tutor",
                "zipPlugin",
                "tarPlugin",
                "osc52",
                "shada",
                "spellfile",
                "man",
                "editorconfig",
                "netrwPlugin",
                "rplugin",
                -- "matchit",
                "matchparen",
            },
        },
    },
})
