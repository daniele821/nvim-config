-- builtin customization
require("configs.options")
require("configs.autocmd")
require("configs.keymaps")

-- bootstrap lazy-nvim and load plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.statusline"),
	require("plugins.gitsigns"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.lsp.lspconfig"),
	require("plugins.lsp.completions"),
	require("plugins.lsp.formatter"),
}, {
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
				-- "editorconfig",
				"netrwPlugin",
				"rplugin",
				"matchit",
				"matchparen",
			},
		},
	},
})
