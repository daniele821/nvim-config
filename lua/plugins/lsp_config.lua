return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		-- enable lsp servers
		vim.lsp.enable(require("utils.confuncs").to_enable_lsp)
	end,
}
