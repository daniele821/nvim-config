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
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist,
					},
					n = {
						["<esc>"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist,
					},
				},
			},
		})
	end,
}
