return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					-- `friendly-snippets` contains a variety of premade snippets.
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		-- Adds other completion capabilities.
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",

		-- completion icons
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- fix cmp highlight groups and borders
		local highlight = {
			border = "single",
			winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
		}

		luasnip.config.setup({
			exit_roots = false,
			link_children = true,
		})

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(highlight),
				documentation = cmp.config.window.bordered(highlight),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				expandable_indicator = true,
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol",
					preset = "codicons",
					menu = {
						nvim_lsp = "[LSP]",
						luasnip = "[SNIP]",
					},
				}),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
			preselect = "none",
			completion = { completeopt = "menu,menuone,noselect" },
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
				["<Down>"] = cmp.mapping(function(fallback)
					cmp.close()
					fallback()
				end, { "i" }),
				["<Up>"] = cmp.mapping(function(fallback)
					cmp.close()
					fallback()
				end, { "i" }),
			}),
		})
	end,
}
