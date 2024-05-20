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
						local _map = function(elem)
							return elem.name
						end
						if #lsp >= 1 then
							return " " .. vim.iter(lsp):map(_map):join(", ")
						end
						return ""
					end,
				},
			},
		})
	end,
}
