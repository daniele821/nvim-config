return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
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
			mode = { "n", "i" },
		},
		{
			"<A-s-f>",
			function()
				require("telescope.builtin").find_files({
					file_ignore_patterns = { "%.git/" },
					hidden = true,
					no_ignore = true,
					no_ignore_parent = true,
				})
			end,
			mode = { "n", "i" },
		},
		{
			"<A-b>",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = { "n", "i" },
		},
		{
			"<A-s-g>",
			function()
				require("telescope.builtin").grep_string()
			end,
			mode = { "n", "i" },
		},
		{
			"<A-g>",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = { "n", "i" },
		},
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
					},
					n = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
					},
				},
			},
		})
	end,
}
