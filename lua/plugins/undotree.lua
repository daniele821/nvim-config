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
	config = function()
		vim.g.undotree_SplitWidth = 40
	end,
}
