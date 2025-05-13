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
            accept = { auto_brackets = { enabled = true }, },
            documentation = { 
                auto_show = false, 
                auto_show_delay_ms = 0 , 
                window = { border = 'single' }},
            menu = {
                border = 'single',
                auto_show = true ,
                max_height = 15,
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, {'source_name'} },
                    components = {
                        source_name = {
                            text = function(ctx) return "[" .. ctx.source_name .. "]" end,
                        }
                    }
                },
            },
            list = { selection = { preselect = false, auto_insert = false } },
            ghost_text = { enabled = true },
        },
        sources = {
            default = { 'lsp', 'snippets', 'buffer', 'path' },
        },
        fuzzy = {
            implementation = "lua",
            sorts = { 'exact', 'score', 'sort_text', },
        },
        cmdline = { enabled = false },
        signature = { enabled = true, window = { border = 'single' }},
    },
    opts_extend = { "sources.default" }
}
