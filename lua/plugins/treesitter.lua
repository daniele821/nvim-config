return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs', 
    event = { "BufReadPre", "BufNewFile", "BufWritePost" },    
	opts = {
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = false },
	}
}
