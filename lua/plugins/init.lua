-- bootstrap lazy-nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({
	{
		require("plugins/colorscheme"),
		require("plugins/statusline"),
		require("plugins/treesitter"),
		require("plugins/comment"),
		require("plugins/gitsigns"),
		require("plugins/undotree"),
		require("plugins/lsp"),
	},
})