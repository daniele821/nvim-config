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
vim.keymap.set("n", "<a-up>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<a-down>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<a-left>", "<cmd>copen<CR>")
vim.keymap.set("n", "<a-right>", "<cmd>cclose<CR>")
