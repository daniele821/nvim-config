return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	main = "nvim-treesitter.configs",
	opts = {
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = false },
	},
}
