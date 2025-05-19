-- core configurations
require("configs.options")
require("configs.autocmd")
require("configs.keymaps")
require("configs.various")

-- install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
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

-- autoinit
local lazy_buf = require("lazy.view").view
if lazy_buf then
	vim.api.nvim_buf_delete(lazy_buf.buf, {})
end
local first_run_marker = vim.fs.joinpath(vim.fn.stdpath("data"), ".first_run_done")
local first_run = false
if not vim.uv.fs_stat(first_run_marker) then
	first_run = true
    io.open(first_run_marker, "w"):write("Hi!"):close()
end
if first_run then
	vim.cmd("StarterPack")
end
