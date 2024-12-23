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
		local next = index
		local iter = index + step
		local cycle = math.max(1, (iter + elements - 1) % elements + 1)
		if iter == cycle then
			next = iter
		end
		vim.api.nvim_command(string.format("cc %d", next))
	end
end
vim.keymap.set("n", "<a-left>", navigate_qflist(-1))
vim.keymap.set("n", "<a-right>", navigate_qflist(1))
vim.keymap.set("n", "<a-up>", "<cmd>copen<CR>")
vim.keymap.set("n", "<a-down>", "<cmd>cclose<CR>")
