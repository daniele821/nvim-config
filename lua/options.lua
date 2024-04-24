-- set leader key (useful for plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- show row numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- space vs tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- do not show current mode in status line
vim.opt.showmode = false

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore case in searches
vim.opt.ignorecase = true

-- do not highlight search results
vim.opt.hlsearch = false

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- set where to open split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- highlight cursor current line
vim.opt.cursorline = false

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
