local linters_by_ft = require("utils.configs").linters_by_ft
return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters_by_ft

		-- autocmd to lint on changes
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
			callback = function()
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})
		lint.try_lint(nil, { ignore_errors = true })
	end,
}
