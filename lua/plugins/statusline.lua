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
						if #lsp == 1 then
							return " " .. lsp[1].name
						elseif #lsp > 1 then
							return " LSP [" .. #lsp .. "]"
						else
							return ""
						end
					end,
				},
			},
		})
	end,
}
