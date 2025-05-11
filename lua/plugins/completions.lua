return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
        keymap = {
            preset = "none",
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide' },
            ['<C-y>'] = { 'select_and_accept' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
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
