return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<A-f>",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<A-t>",
			function()
				require("telescope.builtin").find_files({
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob=!**/.git/*",
					},
				})
			end,
		},
		{
			"<A-b>",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<A-g>",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
					},
					n = {
						["<C-c>"] = require("telescope.actions").close,
						["<C-w><C-q>"] = require("telescope.actions").close,
					},
				},
			},
		})
	end,
}
