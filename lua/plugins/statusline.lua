return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					"filename",
					function()
						-- invoke lsp progress here
						if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
							return " LSP"
						else
							return ""
						end
					end,
				},
			},
		})
	end,
}
