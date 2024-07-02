return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<A-t>", ":Telescope find_files<CR>" },
		{ "<A-b>", ":Telescope buffers<CR>" },
	},
}
