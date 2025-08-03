local original_vim_notify = vim.notify
vim.notify = function(msg, level, opts)
	if opts ~= nil and opts.title == "Snacks" then
		return
	end
	original_vim_notify(msg, level, opts)
end
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
