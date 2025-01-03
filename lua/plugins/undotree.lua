return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle" },
	keys = { {
		"<A-t>",
		function()
			vim.cmd([[UndotreeToggle]])
			vim.cmd([[UndotreeFocus]])
		end,
	} },
}
