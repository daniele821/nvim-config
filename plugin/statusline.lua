local M = {}

M._lspProgress = {}

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

	-- intercept progress messages
	vim.lsp.handlers["$/progress"] = M.progressHandler

	-- autocmd to refresh statusline when necessary
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function()
			vim.cmd("redrawstatus")
		end,
	})
	vim.api.nvim_create_autocmd("LspDetach", {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("redrawstatus")
			end, 500)
		end,
	})
end

function M.progressHandler(_, result, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	local token = result.token
	local value = result.value
	if not client or not token or not value then
		return
	end
	local is_end_kind = value.kind == "end"
	local percentage = value.percentage

	local old_token = vim.tbl_get(M._lspProgress, client.name, "token")
	local old_msg = vim.tbl_get(M._lspProgress, client.name, "message")
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

	M._lspProgress[client.name] = {
		token = new_token,
		message = new_msg,
	}

	if old_msg ~= new_msg then
		vim.cmd("redrawstatus")
	end
end

function M.filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:match("^.*://") then
		return bufname:gsub("^oil://", "")
	end
	return "%t"
end

M.setup()
