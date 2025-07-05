return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		local function parse()
			vim.schedule(function()
				pcall(vim.treesitter.start)
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo.indentexpr = ""
			end)
		end
		vim.api.nvim_create_autocmd("Filetype", {
			callback = parse,
		})
		parse()
	end,
}
