return {
	"numToStr/FTerm.nvim",
	config = function()
		require("FTerm").setup({
			border = "double",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})
		vim.keymap.set("n", "<A-t>", '<CMD>lua require("FTerm").toggle()<CR>')
		vim.keymap.set("t", "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
	end,
}
