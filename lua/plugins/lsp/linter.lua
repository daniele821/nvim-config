return {
	"mfussenegger/nvim-lint",
	ft = { "sh", "bash" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
		}
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
