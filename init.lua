vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

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
	{
		"NvChad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	-- if u want nvchad's ui plugin :)
	{
		"NvChad/ui",
		config = function()
			require("nvchad")
		end,
	},

	-- dependency for ui
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = function()
			return { override = require("nvchad.icons.devicons") }
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "devicons")
			require("nvim-web-devicons").setup(opts)
		end,
	},
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
			},
		},
	},
})

dofile(vim.g.base46_cache .. "statusline")
