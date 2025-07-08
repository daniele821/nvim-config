-- show row numbers
vim.o.number = true
vim.o.relativenumber = true

-- space vs tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- set where to open split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- various
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
vim.api.nvim_set_keymap("n", "grf", "<Nop>", {})

-- autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- user command
vim.api.nvim_create_user_command("Zen", function()
	if not vim.o.number and not vim.o.relativenumber and vim.o.signcolumn == "no" then
		vim.o.number = true
		vim.o.relativenumber = true
		vim.o.signcolumn = "yes"
    else
		vim.o.number = false
		vim.o.relativenumber = false
		vim.o.signcolumn = "no"
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
