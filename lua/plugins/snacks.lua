return {
	"folke/snacks.nvim",
	opts = {
		picker = {},
        notifier = { 
            filter = function(n) 
                return n.title ~= "Snacks" and string.sub(n.msg, 1, 15) == "Command failed:"
            end 
        },
	},
	keys = {
		{ "<A-f>", function() Snacks.picker.files()   end },
		{ "<A-b>", function() Snacks.picker.buffers() end },
		{ "<A-s>", function() Snacks.picker.grep()    end },
		{ "<A-a>", function() Snacks.picker()         end },
	},
}
