return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"linrongbin16/lsp-progress.nvim",
		opts = {
			max_size = 80,
		},
	},
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					"filename",
					function()
						-- invoke lsp progress here
						return require("lsp-progress").progress()
					end,
				},
			},
		})

		-- listen lsp-progress event and refresh lualine immediatly
		vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = "lualine_augroup",
			pattern = "LspProgressStatusUpdated",
			callback = require("lualine").refresh,
		})
	end,
}
