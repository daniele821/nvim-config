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
	python = { "black" },
}
local formatters = {
	black = {
		command = "black",
		inherit = true,
		append_args = { "--line-length", "150" },
	},
}
return {
	-- Autoformat
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(formatters_by_ft),
	config = function()
		require("conform").setup({
			notify_on_error = false,
			notify_no_formatters = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat then
					return nil
				end
				local lspformat = "fallback"
				if vim.g.disable_lspformat[vim.bo[bufnr].filetype] then
					lspformat = "never"
				end
				return {
					timeout_ms = 100,
					lsp_format = lspformat,
					quiet = true,
				}
			end,
			-- set formatters by filetype
			formatters_by_ft = formatters_by_ft,
			formatters = formatters,
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
