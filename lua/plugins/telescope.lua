return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<A-f>", ":Telescope find_files<CR>" },
		{ "<A-b>", ":Telescope buffers<CR>" },
	},
}
