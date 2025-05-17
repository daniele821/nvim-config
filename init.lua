-- core configurations
require("configs.options")
require("configs.autocmd")
require("configs.keymaps")

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
    require("plugins.core.colorscheme"),
    require("plugins.core.explorer"),
    require("plugins.core.gitsigns"),
    require("plugins.core.telescope"),
    require("plugins.core.treesitter"),
    require("plugins.lsp.completions"),
    require("plugins.lsp.formatters"),
    require("plugins.lsp.linters"),
    require("plugins.lsp.lspconfig"),
    require("plugins.lsp.mason"),
    require("plugins.lsp.statusline"),
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
