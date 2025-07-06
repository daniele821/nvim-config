local M = {}

_G.Statusline = M

function M.setup()
	-- set statusline
	vim.opt.statusline = vim.iter({
		"%<%{%v:lua._G.Statusline.filename()%}",
		"%m%r%y",
		"%=",
		"%{&ff}",
		"%l:%v",
		"%P",
	}):join(" ")
end

function M.filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:match("^.*://") then
		return bufname:gsub("^oil://", "")
	end
	return "%t"
end

M.setup()
