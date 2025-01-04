-- exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- hacky way to (almost) clear neovim terminal buffer
vim.keymap.set("t", "<C-l>", function()
	vim.fn.feedkeys("", "n")
	local sb = vim.bo.scrollback
	vim.bo.scrollback = 1
	vim.bo.scrollback = sb
end)

-- navigate quickfix
local function navigate_qflist(step)
	return function()
		local elements = #vim.fn.getqflist()
		if elements == 0 then
			vim.api.nvim_echo({}, false, {})
			return
		end
		local index = vim.fn.getqflist({ idx = 0 }).idx
		local next = index + step
		local cycle = math.max(1, (next + elements - 1) % elements + 1)
		if next ~= cycle then
			next = math.max(1, math.min(next, elements))
		end
		-- uncomment next line to allow cycling through qflist
		-- next = cycle
		vim.api.nvim_command(string.format("cc %d", next))
	end
end

-- toggle qflist
local function open_qflist()
	local function is_quickfix_open()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.api.nvim_set_current_win(win.winid)
				return true
			end
		end
		return false
	end
	if not is_quickfix_open() then
		vim.cmd("copen")
	end
end
local function close_qflist()
	vim.cmd("cclose")
end

vim.keymap.set("n", "<a-left>", navigate_qflist(-1))
vim.keymap.set("n", "<a-right>", navigate_qflist(1))
vim.keymap.set("n", "<a-up>", open_qflist)
vim.keymap.set("n", "<a-down>", close_qflist)
