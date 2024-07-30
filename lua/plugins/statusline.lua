return {
	"nvim-lualine/lualine.nvim",
	priority = 999,
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filename" },
			lualine_c = {
				function()
					local lsp = vim.lsp.get_clients({ bufnr = 0 })
					local lsp_msg = ""
					local fmt_msg = ""
					local lsp_icon = " "
					local hint_icon = " "
					local fmt_icon = "󰉿 "
					local auto_icon = " "
					if #lsp >= 1 then
						local icon = lsp_icon
						if vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
							icon = hint_icon
						end
						lsp_msg = icon
							.. vim.iter(lsp)
								:map(function(elem)
									return elem.name
								end)
								:join(", ")
							.. " "
					end
					if package.loaded["conform"] then
						local fmt = require("conform").list_formatters(0)
						local icon = fmt_icon
						if #fmt >= 1 or #lsp >= 1 then
							if not vim.g.disable_autoformat then
								icon = auto_icon
							end
							if #fmt >= 1 then
								fmt_msg = icon
									.. vim.iter(fmt)
										:map(function(elem)
											return elem.name
										end)
										:join(", ")
									.. " "
							end
						end
					end
					return lsp_msg .. fmt_msg
				end,
			},
			lualine_x = {
				"diff",
				"diagnostics",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
