local plugin_name = "utils.statusline"

-- autocmd to refresh statusline when necessary
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

-- handle progress messages
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local plugin = require(plugin_name)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local token = result.token
	local value = result.value
	if not client or not token or not value then
		return
	end
	local is_end_kind = value.kind == "end"
	local percentage = value.percentage

	-- calculations
	local old_token = vim.tbl_get(plugin._lspProgress, client.name, "token")
	local old_msg = vim.tbl_get(plugin._lspProgress, client.name, "message")
	local new_token = old_token
	local new_msg = old_msg
	if not old_token then
		if percentage then
			new_token = token
			new_msg = " (" .. percentage .. "%)"
		end
	else
		if old_token == token then
			if is_end_kind then
				new_token = nil
				new_msg = ""
			elseif percentage then
				new_msg = " (" .. percentage .. "%)"
			end
		end
	end

	-- set new status
	plugin._lspProgress[client.name] = {
		token = new_token,
		message = new_msg,
	}

	-- refresh statusline if necessary
	if old_msg ~= new_msg then
		vim.cmd("redrawstatus")
	end
end

local M = {}

M._lspProgress = {}

function M.setup()
	vim.opt.statusline = vim.iter({
		'%<%{%v:lua.require("' .. plugin_name .. '").filename()%}',
		"%m%r%y",
		"%=",
		'%<%{v:lua.require("' .. plugin_name .. '").lspList()}',
		'%<%{v:lua.require("' .. plugin_name .. '").linterList()}',
		'%<%{v:lua.require("' .. plugin_name .. '").formatterList()}',
		"%=",
		"%{&ff}",
		"%l:%v",
		"%P",
	}):join(" ")
end

function M.lspList()
	local lsps = vim.lsp.get_clients({ bufnr = 0 })
	if #lsps > 0 then
		local lsp_icon = " "
		local lsp_names = vim.iter(lsps)
			:map(function(elem)
				return elem.name
			end)
			:map(function(lsp)
				local tmp = M._lspProgress[lsp] or {}
				local msg = tmp.message or ""
				return lsp .. msg
			end)
			:join(", ")
		return lsp_icon .. lsp_names
	end
	return ""
end

function M.linterList()
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

function M.formatterList()
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

function M.filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:match("^.*://") then
		return "%f"
	end
	return "%t"
end

return M
