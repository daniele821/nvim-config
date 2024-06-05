-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable auto-comment (hacky fix)
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
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

-- do not allow for editing an already open file
pcall(vim.api.nvim_del_augroup_by_name, "nvim_swapfile")
