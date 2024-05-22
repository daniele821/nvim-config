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
						local lsp_msg = ""
						local fmt_msg = ""
						local lint_msg = ""
						if #lsp >= 1 then
							lsp_msg = " " .. vim.iter(lsp):map(get_param("name")):join(", ") .. " "
						end
						if package.loaded["conform"] then
							local fmt = require("conform").list_formatters(0)
							if #fmt >= 1 then
								fmt_msg = " " .. vim.iter(fmt):map(get_param("name")):join(", ") .. " "
							end
						end
						if package.loaded["lint"] then
							local fmt = require("lint").linters_by_ft[vim.bo[0].filetype]
							if #fmt >= 1 then
								-- todo: filter out not existing linters
								lint_msg = " " .. vim.iter(fmt):join(", ") .. " "
							end
						end
						return lsp_msg .. fmt_msg .. lint_msg
					end,
				},
			},
		})
	end,
}
