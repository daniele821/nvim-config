-- enable lsp servers
vim.lsp.enable({ "lua_ls", "bashls", "ruff", "rust_analyzer", "cssls", "emmet_language_server", "html" })

-- configure diagnostics
vim.diagnostic.config {
    severity_sort = true,
    virtual_text = true,
    float = { border = 'single' },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    },
}

-- configure lsp floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    opts.max_width = opts.max_width or 100
    opts.max_height = opts.max_height or 15
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- create autocmd
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.iter(vim.lsp.get_clients()):each(function (client)
            client:stop()
        end)
    end
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf })
        vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = event.buf })
    end
})

-- create user command
vim.api.nvim_create_user_command("StarterPack", function()
    -- to install treesitter langs and mason lsp servers
    local to_install_parsers = { "cpp", "javascript", "css", "html", "json", "jsonc", "java", "python", "bash", "rust" }
    local to_install_lsps = { "html-lsp", "emmet-language-server", "bash-language-server", "css-lsp", "ruff",
        "lua-language-server", "shellcheck" }

    -- filter out already present elements
    local table_sub = function(want, have)
        return vim.iter(want):filter(function(elem)
            return not vim.tbl_contains(have, elem)
        end)
    end

    -- installed treesitter langs and mason lsp servers
    local installed_parsers = require('nvim-treesitter.info').installed_parsers()
    local installed_lsps = require("mason-registry").get_installed_package_names()

    vim.cmd(table_sub(to_install_parsers, installed_parsers):join(" "))
    vim.cmd(table_sub(to_install_lsps, installed_lsps):join(" "))
end, {})

return {}
