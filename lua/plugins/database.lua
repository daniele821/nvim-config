return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-completion",
	},
	cmd = {
		"DBUI",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_disable_mappings = 1
		vim.g.db_ui_disable_mappings_dbui = 1
		vim.g.db_ui_disable_mappings_dbout = 1
		vim.g.db_ui_disable_mappings_sql = 1
		vim.g.db_ui_disable_mappings_javascript = 1
	end,
}
