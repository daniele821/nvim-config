return {
	"folke/snacks.nvim",
	opts = {
		picker = {},
	},
	keys = {
		{
			"<A-f>",
			function()
				Snacks.picker.files()
			end,
		},
		{
			"<A-b>",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<A-s>",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<A-a>",
			function()
				Snacks.picker()
			end,
		},
	},
}
