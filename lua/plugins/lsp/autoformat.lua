vim.g.disable_lspformat = {
	bash = true,
	sh = true,
}
vim.g.disable_autoformat = false
local formatters_by_ft = {
	lua = { "stylua" },
	sh = { "shfmt" },
	bash = { "shfmt" },
}
return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(formatters_by_ft),
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_fallback = not vim.g.disable_lspformat[vim.bo[bufnr].filetype],
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
		vim.keymap.set("n", "<a-a>", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			if package.loaded["lualine"] then
				require("lualine").refresh({})
			end
		end, {})
	end,
}
