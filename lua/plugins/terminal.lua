return {
	"numToStr/FTerm.nvim",
	opts = {
		border = "double",
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	},
	keys = {
		{
			"<A-t>",
			function()
				require("FTerm").toggle()
			end,
			mode = { "n", "t" },
		},
	},
}
