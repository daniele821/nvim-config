local formatters_by_ft = require("utils.configs").formatters_by_ft
return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	ft = vim.tbl_keys(formatters_by_ft),
	config = function()
		require("conform").setup({
			notify_on_error = false,
			notify_no_formatters = false,
			format_on_save = false,
			formatters_by_ft = formatters_by_ft,
		})
	end,
}
