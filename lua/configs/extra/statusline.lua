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
				local msg = vim.g.lsp_progresses or {}
				msg = msg[lsp] or {}
				msg = msg.message or ""
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

-- statusline + autocmd to refresh when necessary
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
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

io.open("/tmp/test", "w"):close()
local function log_to_file(data)
	io.open("/tmp/test", "a"):write(vim.inspect(data) .. "\n"):close()
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local value = result.value
	if not client then
		return
	end
	if not value then
		return
	end

	-- get old status
	local old_progress = vim.g.lsp_progresses or {}
	local old_lsp = old_progress[client.name] or {}
	local old_token = old_progress.token
	local old_percentage = old_progress.percentage
	local old_message = old_progress.message

	-- calculations
	local new_token = ""
	local new_msg = ""
    local is_kind_end = value.kind == "end"
	if old_token then
        if is_kind_end then
            new_token = old_token
        end
		new_token = old_token
        new_msg = "(" .. value.progress .. ")"
    else
        if value.progress then
            new_token = result.token
            new_msg = value.progress
        end
	end

	-- set new status
	vim.g.lsp_progresses = {
		[client.name] = {
			token = new_token,
			message = new_msg,
		},
	}

	vim.cmd("redrawstatus")

	log_to_file(vim.g.lsp_progresses)
end
