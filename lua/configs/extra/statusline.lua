-- get string with list of active lsp in current buffer
function LspList()
	local lsps = vim.lsp.get_clients({ bufnr = 0 })
	if #lsps > 0 then
		local lsp_icon = " "
		local lsp_names = vim.iter(lsps)
			:map(function(elem)
				return elem.name
			end)
			:map(function(lsp)
				local tmp = LspProgress or {}
				tmp = tmp[lsp] or {}
				local msg = tmp.message or ""
				return lsp .. msg
			end)
			:join(", ")
		return lsp_icon .. lsp_names
	end
	return ""
end

-- get string with list of active linters in current buffer
function LinterList()
	local linters = vim.iter(require("utils.configs").linters_by_ft[vim.bo.filetype] or {})
		:filter(function(linter)
			return vim.fn.executable(linter) == 1
		end)
		:totable()
	if #linters > 0 then
		local lint_icon = " "
		local linter_names = vim.iter(linters):join(", ")
		return lint_icon .. linter_names
	end
	return ""
end

-- get string with list of active formatters in current buffer
function FormatterList()
	local formatters = vim.iter(require("utils.configs").formatters_by_ft[vim.bo.filetype] or {})
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

-- get string of last component of filename
function Filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:match("^.*://") then
		return "%f"
	end
	return "%t"
end

-- statusline
vim.opt.statusline = vim.iter({
	"%<%{%v:lua.Filename()%}",
	"%m%r%y",
	"%=",
	"%{v:lua.LspList()}",
	"%{v:lua.LinterList()}",
	"%{v:lua.FormatterList()}",
	"%=",
	"%{&ff}",
	"%l:%v",
	"%P",
}):join(" ")

-- autocmd to refresh statusline when necessary
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

----------------- TO DELETE -----------------
io.open("/tmp/test", "w"):close()
local function log_to_file(data)
	io.open("/tmp/test", "a"):write(vim.inspect(data) .. "\n"):close()
end
----------------- TO DELETE -----------------

-- handle progress messages
LspProgress = {}
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local token = result.token
	local value = result.value
	if not client or not token or not value then
		return
	end

	local is_end_kind = value.kind == "end"
	local percentage = value.percentage

	-- calculations
	local new_token = vim.tbl_get(LspProgress, client.name, token)
	local new_msg = ""
	if percentage then
		new_msg = " (" .. percentage .. "%)"
	end

	-- set new status
	LspProgress = {
		[client.name] = {
			token = new_token,
			message = new_msg,
		},
	}

	vim.cmd("redrawstatus")

	log_to_file(LspProgress)
end
