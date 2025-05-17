local formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    json = { "jq" },
}
return {
    "stevearc/conform.nvim",
    event = "LspAttach",
    ft = vim.tbl_keys(formatters_by_ft),
    config = function()
        require("conform").setup({
            notify_on_error = false,
            notify_no_formatters = false,
            format_on_save = false,
            formatters_by_ft = formatters_by_ft,
        })

        -- add mapping to format file
        vim.keymap.set("n", "grf", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end, {})
    end,
}

