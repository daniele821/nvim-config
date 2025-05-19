return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			-- dependencies = {
			-- 	"rafamadriz/friendly-snippets",
			-- 	config = function()
			-- 		require("luasnip.loaders.from_vscode").lazy_load()
			-- 	end,
			-- },
		},
	},
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-e>"] = { "cancel" },
			["<C-y>"] = { "select_and_accept" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Property = "󰜢",
				Class = "󰠱",
				Interface = "",
				Struct = "󰙅",
				Module = "",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				EnumMember = "",
				Keyword = "󰌋",
				Constant = "󰏿",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰬛",
			},
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 0,
				window = { border = "single" },
			},
			menu = {
				border = "single",
				auto_show = true,
				max_height = 15,
				draw = {
					columns = { { "kind_icon" }, { "label" }, { "source_name" } },
					components = {
						source_name = {
							text = function(ctx)
								return "[" .. ctx.source_name .. "]"
							end,
						},
					},
				},
			},
			list = { selection = { preselect = false, auto_insert = true } },
			ghost_text = {
				enabled = false,
				show_with_selection = true,
				show_without_selection = false,
				show_with_menu = true,
				show_without_menu = true,
			},
		},
		sources = {
			default = { "lsp", "snippets", "buffer" },
		},
		fuzzy = {
			implementation = "lua",
			sorts = {
				function(a, b)
					-- order by:
					-- 1) source
					-- 2) put _* at the end
					local order = {
						lsp = 1,
						snippets = 3,
						buffer = 5,
					}
					local order_a = order[a.source_id]
					local order_b = order[b.source_id]
					if a.label:sub(1, 1) == "_" then
						order_a = order_a + 1
					end
					if b.label:sub(1, 1) == "_" then
						order_b = order_b + 1
					end
					if order_a and order_b and order_a ~= order_b then
						return order_a < order_b
					end
				end,
				"score",
				"sort_text",
			},
		},
		cmdline = { enabled = false },
		signature = { enabled = false, window = { border = "single" } },
	},
	opts_extend = { "sources.default" },
}
