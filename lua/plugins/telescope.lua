return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
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
		{
			"<A-d>",
			function()
				require("telescope.builtin").diagnostics()
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-q>"] = require("telescope.actions").close,
					},
					n = {
						["<C-c>"] = require("telescope.actions").close,
						["<C-q>"] = require("telescope.actions").close,
						["<C-w><C-q>"] = require("telescope.actions").close,
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
}