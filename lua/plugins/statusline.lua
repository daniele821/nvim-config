-- second order function (spooky)
local get_param = function(arg)
	return function(elem)
		return elem[arg]
	end
end

return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					"filename",
					function()
						-- invoke lsp progress here
						local lsp = vim.lsp.get_clients({ bufnr = 0 })
						if #lsp >= 1 then
							local icon = " "
							if vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
								icon = " "
							end
							return icon .. vim.iter(lsp):map(get_param("name")):join(", ")
						end
						return ""
					end,
					function()
						-- show active formatters in current buffer
						if not package.loaded["conform"] then
							return ""
						end
						local fmt = require("conform").list_formatters(0)
						if #fmt >= 1 then
							local symbol = "󰉿 "
							if not vim.g.disable_autoformat then
								symbol = " "
							end
							return symbol .. vim.iter(fmt):map(get_param("name")):join(", ")
						end
						return ""
					end,
				},
			},
		})
	end,
}
