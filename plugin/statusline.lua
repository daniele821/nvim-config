local M = {}

function M.lspList()
	local lsps = vim.lsp.get_clients({ bufnr = 0 })
	if #lsps > 0 then
		local lsp_icon = " "
		local lsp_names = vim.iter(lsps)
			:map(function(elem)
				return elem.name
			end)
			:join(", ")
		return lsp_icon .. lsp_names
	end
	return ""
end

function M.formatterList()
       local formatters = vim.iter(require("utils.confuncs").formatters_by_ft[vim.bo.filetype] or {})
               :filter(function(linter)
                       return vim.fn.executable(linter) == 1
               end)
               :totable()
       if #formatters > 0 then
               local formatter_icon = " "
               local formatter_names = vim.iter(formatters):join(", ")
               return formatter_icon .. formatter_names
       end
       return ""
end

function M.filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:match("^.*://") then
		return bufname:gsub("^.*://", "")
	end
	return "%t"
end

_G.Statusline = M

vim.opt.statusline = vim.iter({
	"%<%{%v:lua._G.Statusline.filename()%}",
	"%m%r%y",
	"%=",
	"%<%{v:lua._G.Statusline.lspList()}",
	"%<%{v:lua._G.Statusline.formatterList()}",
	"%=",
	"%{&ff}",
	"%l:%v",
	"%P",
}):join(" ")

-- autocmd to update statusline when necessary
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})
vim.api.nvim_create_autocmd({ "LspDetach" }, {
	callback = function()
		vim.defer_fn(function()
			vim.cmd("redrawstatus")
		end, 500)
	end,
})
