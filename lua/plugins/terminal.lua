return {
	"jaimecgomezz/here.term",
	opts = {
		mappings = {
			toggle = "<A-t>",
		},
		extra_mappings = {
			enable = true,
		},
	},
	keys = {
		{
			"<A-t>",
			function()
				require("here-term").toggle_terminal()
			end,
			mode = { "n", "t" },
		},
	},
}
