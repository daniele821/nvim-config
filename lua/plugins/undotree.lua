return {
	"mbbill/undotree",
	config = function()
		local function toggleUndo()
			vim.cmd(":UndotreeToggle")
		end
		vim.keymap.set("n", "<A-t>", toggleUndo)
		vim.g.undotree_WindowLayout = 3
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_SplitWidth = 40
	end,
}
