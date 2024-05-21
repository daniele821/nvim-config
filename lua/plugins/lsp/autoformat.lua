local custom = require('custom')
return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(custom.formatters_by_ft),
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
			formatters_by_ft = custom.formatters_by_ft,
		})

		-- add mapping to format file
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, {})

		-- create keymap to toggle autoformat
		vim.g.disable_autoformat = require('custom').disable_autoformat
		vim.keymap.set("n", "<A-f>", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
		end, {})
	end,
}
