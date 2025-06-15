return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("Filetype", {
			callback = function()
				vim.schedule(function()
					pcall(vim.treesitter.start)
				end)
			end,
		})
	end,
}
