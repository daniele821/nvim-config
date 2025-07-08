-- show row numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- space vs tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- set where to open split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- various
vim.opt.statusline = "%<%f %m%r%y %= %{&ff} %l:%v %P"
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.mousemodel = "extend"
vim.opt.pumheight = 15
vim.opt.swapfile = false

-- keymaps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.api.nvim_set_keymap('n', 'grf', '<Nop>', {})

-- autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank()
	end,
})

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
