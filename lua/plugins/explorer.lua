return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = false,
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["<CR>"] = "actions.select",
			["<C-s>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-w><C-q>"] = "actions.close",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["g\\"] = "actions.toggle_trash",
			["<C-l>"] = "actions.refresh",
		},
	},
}
