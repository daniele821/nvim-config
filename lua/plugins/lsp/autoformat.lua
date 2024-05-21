-- configurable variables
local formatters_by_ft = {
	lua = { "stylua" },
	sh = { "shfmt" },
	bash = { "shfmt" },
}
local disable_autoformat = true

return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(formatters_by_ft),
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
			formatters_by_ft = formatters_by_ft,
		})

		-- add mapping to format file
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, {})

		-- create keymap to toggle autoformat
		vim.g.disable_autoformat = disable_autoformat
		vim.keymap.set("n", "<A-f>", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			if vim.g.disable_autoformat then
				print("autoformat on save is disabled")
			else
				print("autoformat on save is enabled")
			end
		end, {})
	end,
}
