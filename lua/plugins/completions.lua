return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = { documentation = { auto_show = false } },
        sources = {
            default = { 'lsp', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" }
}
