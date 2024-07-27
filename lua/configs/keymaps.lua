-- exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- hacky way to (almost) clear neovim terminal buffer
vim.keymap.set("t", "<C-l>", function()
	vim.fn.feedkeys("", "n")
	local sb = vim.bo.scrollback
	vim.bo.scrollback = 1
	vim.bo.scrollback = sb
end)
