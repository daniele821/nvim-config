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
		},
		{
			"<A-b>",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<A-s-g>",
			function()
				require("telescope.builtin").grep_string()
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
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<A-f>"] = function()
							require("telescope.builtin").find_files()
						end,
						["<A-s-f>"] = function()
							require("telescope.builtin").find_files({
								file_ignore_patterns = { "%.git/" },
								hidden = true,
								no_ignore = true,
								no_ignore_parent = true,
							})
						end,
						["<A-b>"] = function()
							require("telescope.builtin").find_files()
						end,
						["<A-s-g>"] = function()
							require("telescope.builtin").grep_string()
						end,
						["<A-g>"] = function()
							require("telescope.builtin").live_grep()
						end,
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
