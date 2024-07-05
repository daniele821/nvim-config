return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile", "BufWritePost" },
	cmd = { "TSInstall" },
	opts = {
		ensure_installed = {},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
