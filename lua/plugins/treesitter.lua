return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	cmd = { "TSInstall" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
