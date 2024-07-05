return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_c = {
				"filename",
				function()
					-- invoke lsp progress here
					local lsp = vim.lsp.get_clients({ bufnr = 0 })
					local lsp_msg = ""
					local fmt_msg = ""
					if #lsp >= 1 then
						local icon = " "
						if vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
							icon = " "
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
						if #fmt >= 1 or #lsp >= 1 then
							local icon = "󰉿 "
							if not vim.g.disable_autoformat then
								icon = " "
							end
							if #fmt >= 1 then
								fmt_msg = icon
									.. vim.iter(fmt)
										:map(function(elem)
											return elem.name
										end)
										:join(", ")
									.. " "
							elseif not vim.g.disable_lspformat[vim.bo[0].filetype] then
								fmt_msg = icon .. "[LSP] "
							end
						end
					end
					return lsp_msg .. fmt_msg
				end,
			},
		},
	},
}
