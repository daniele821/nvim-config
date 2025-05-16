-- enable lsp servers
vim.lsp.enable({
    "lua_ls",
    "bashls",
    "ruff",
    "rust_analyzer",
    "cssls",
    "emmet_language_server",
    "html",
})

-- close lsp servers on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        for _, client in ipairs(vim.lsp.get_clients()) do
            client:stop()
        end
    end
})

-- configure lsp and diagnostics
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
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    opts.max_width = opts.max_width or 100
    opts.max_height = opts.max_height or 15
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

return {}
