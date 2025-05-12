return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
        keymap = {
            preset = "none",
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-e>'] = { 'cancel' },
            ['<C-y>'] = { 'select_and_accept' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = { 
            documentation = { auto_show = false, auto_show_delay_ms = 0 , window = { border = 'single' }},
            menu = { border = 'single' },
            list = { selection = { preselect = false, auto_insert = true } },
            ghost_text = { enabled = false },
        },
        sources = {
            default = { 'lsp', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "lua" },
        cmdline = { enabled = false },
        signature = { enabled = true, window = { border = 'single' }},
    },
    opts_extend = { "sources.default" }
}
