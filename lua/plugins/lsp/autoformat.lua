return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "BufReadPre",
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat then
					return
				end
				-- set disabled filetypes
				local disable_filetypes = {
					c = true,
					cpp = true,
				}
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			-- set formatters by filetype
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		-- add mapping to format file
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, {})

		-- set autoformats by default
		vim.g.disable_autoformat = false
		vim.api.nvim_create_user_command("AutoFormatToggle", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			if vim.g.disable_autoformat then
				print("autoformat on save is disabled")
			else
				print("autoformat on save is enabled")
			end
		end, {})
		vim.keymap.set("n", "<A-f>", ":AutoFormatToggle<CR>", {})
	end,
}
