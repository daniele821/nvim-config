-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.statusline = "%<%f %m%r%y %= %{&ff} %l:%v %P"
vim.o.laststatus = 3
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.mousemodel = "extend"
vim.o.pumheight = 15
vim.o.swapfile = false

-- keymaps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "grf", "<CMD>echo 'Formatting is disabled in minimal nvim version!'<CR>")
vim.keymap.set("n", "<a-z>", "<CMD>Zen<CR>")

-- autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.hl.on_yank()
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable autocommenting",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- user command
vim.api.nvim_create_user_command("Zen", function()
	if vim.g.zen_mode_enabled then
		vim.o.number = true
		vim.o.relativenumber = true
		vim.o.signcolumn = "yes"
		vim.diagnostic.enable()
		vim.g.zen_mode_enabled = false
	else
		vim.o.number = false
		vim.o.relativenumber = false
		vim.o.signcolumn = "no"
		vim.diagnostic.enable(false)
		vim.g.zen_mode_enabled = true
	end
end, {})

-- install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- install plugins using lazy
require("lazy").setup({
	{ import = "plugins" },
}, {
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tohtml",
				"tutor",
				"zipPlugin",
				"tarPlugin",
				"osc52",
				"shada",
				"spellfile",
				"man",
				"editorconfig",
				"netrwPlugin",
				"rplugin",
				-- "matchit",
				"matchparen",
			},
		},
	},
})
