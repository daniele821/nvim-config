-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- when moving with arrows in sql files, it prints some garbage idk why
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "sql",
	callback = function()
		vim.keymap.del("i", "<left>", { buffer = true })
		vim.keymap.del("i", "<right>", { buffer = true })
	end,
})
