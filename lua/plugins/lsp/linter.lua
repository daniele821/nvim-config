local linters_by_ft = {
	sh = { "shellcheck" },
	bash = { "shellcheck" },
}

return {
	"mfussenegger/nvim-lint",
	ft = vim.tbl_keys(linters_by_ft),
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters_by_ft
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
