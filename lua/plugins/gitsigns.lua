return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			-- Navigation
			vim.keymap.set({ "n", "v" }, "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to next hunk", buffer = bufnr })

			vim.keymap.set({ "n", "v" }, "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Jump to previous hunk", buffer = bufnr })
		end,
	},
}
