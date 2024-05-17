return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
		}
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
