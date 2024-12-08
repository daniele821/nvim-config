return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	cmd = { "TSInstall", "TSUninstall" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"query",
				"c",
				"bash",
				"go",
				"python",
				"html",
				"css",
				"javascript",
				"php",
				"json",
				"desktop",
				"sql",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
