return {
	"nvim-lualine/lualine.nvim",
	priority = 999,
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { { "mode", draw_empty = true } },
			lualine_b = { { "filename", draw_empty = true } },
			lualine_c = { { "branch" } },
			lualine_x = { { "diagnostics" } },
			lualine_y = { { "filetype", draw_empty = true } },
			lualine_z = { { "progress", draw_empty = true } },
		},
		inactive_sections = {},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
