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
	go = { "goimports" },
	json = { "jq" },
	php = { "pretty-php" },
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
				local lspformat = "fallback"
				if vim.g.disable_lspformat[vim.bo[bufnr].filetype] then
					lspformat = "never"
				end
				return {
					timeout_ms = 500,
					lsp_format = lspformat,
				}
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
