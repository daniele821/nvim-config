return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
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
			"<A-c>",
			function()
				require("telescope.builtin").git_status()
			end,
		},
	},
}
