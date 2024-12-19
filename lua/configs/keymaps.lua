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
local function navigate_qflist(next)
	local function fmt_elem(index, elements)
		print(string.format("(%d of %d): %s", index, elements, vim.fn.getqflist()[index].text))
	end
	return function()
		local elements = #vim.fn.getqflist()
		if elements == 0 then
			return
		end
		local index = vim.fn.getqflist({ idx = 0 }).idx
		if next then
			if index < elements then
				vim.api.nvim_command("cnext")
			else
				fmt_elem(index, elements)
			end
		else
			if index > 1 then
				vim.api.nvim_command("cprev")
			else
				fmt_elem(index, elements)
			end
		end
	end
end
vim.keymap.set("n", "<a-left>", navigate_qflist(false))
vim.keymap.set("n", "<a-right>", navigate_qflist(true))
vim.keymap.set("n", "<a-up>", "<cmd>copen<CR>")
vim.keymap.set("n", "<a-down>", "<cmd>cclose<CR>")
