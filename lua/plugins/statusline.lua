return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"linrongbin16/lsp-progress.nvim",
		opts = {
			client_format = function(client_name, spinner, series_messages)
				local len = #series_messages
				return len > 0
						and ("[" .. client_name .. "] " .. spinner .. " " .. table.concat(series_messages, ", ", 1, 1))
					or nil
			end,
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
		local lualine = require("lualine")
		vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = "lualine_augroup",
			pattern = "LspProgressStatusUpdated",
			callback = lualine.refresh,
		})
	end,
}
