return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
		}
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
