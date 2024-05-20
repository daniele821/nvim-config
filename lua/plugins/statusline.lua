return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					"filename",
					function()
						-- invoke lsp progress here
						local lsp = vim.lsp.get_clients({ bufnr = 0 })
						if #lsp >= 1 then
							local lsp_names = vim.iter(ipairs(lsp))
								:map(function(_, elem)
									return elem.name
								end)
								:join(", ")
							return " " .. lsp_names
						else
							return ""
						end
					end,
				},
			},
		})
	end,
}
