vim.g.disable_lspformat = {
	bash = true,
	sh = true,
	lua = true,
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
					return nil
				end
				if vim.g.disable_lspformat[vim.bo[bufnr].filetype] then
					return {
						timeout_ms = 500,
						lsp_format = "never",
					}
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			-- set formatters by filetype
			formatters_by_ft = formatters_by_ft,
		})

		-- add mapping to format file
		vim.keymap.set("n", "gff", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, {})

		-- create keymap to toggle autoformat
		vim.keymap.set("n", "<a-a>", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			require("lualine").refresh({})
		end, {})
	end,
}
