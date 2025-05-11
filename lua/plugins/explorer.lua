return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	keys = {
		{ "-", function() require("oil").open() end, },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = false,
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["<CR>"] = "actions.select",
			["<C-v>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-c>"] = "actions.close",
			["<C-w><C-q>"] = "actions.close",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["<C-l>"] = "actions.refresh",
		},
	},
}

