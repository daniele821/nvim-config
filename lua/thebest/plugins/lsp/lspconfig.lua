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

-- stop lsp on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.iter(vim.lsp.get_clients()):each(function(client)
            client:stop()
        end)
    end
})

-- additional keymaps for buffers with lsp attached
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf })
    end
})

return {
    { "j-hui/fidget.nvim", opts = {}, event = "LspAttach" },
}
