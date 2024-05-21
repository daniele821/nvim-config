local settings = require("settings")
return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(settings.formatters_by_ft),
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(_)
				if vim.g.disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = true,
				}
			end,
			-- set formatters by filetype
			formatters_by_ft = settings.formatters_by_ft,
		})

		-- add mapping to format file
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, {})

		-- create keymap to toggle autoformat
		vim.g.disable_autoformat = settings.disable_autoformat
		vim.keymap.set("n", "<A-f>", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			require("lualine").refresh({})
		end, {})
	end,
}
