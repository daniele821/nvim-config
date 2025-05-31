return {
	"neovim/nvim-lspconfig",
	lazy = true,
	init = function()
		local lspconfigPath = vim.fs.joinpath(require("lazy.core.config").options.root, "nvim-lspconfig")
		vim.opt.runtimepath:prepend(lspconfigPath)
	end,
}
