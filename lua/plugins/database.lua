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

		-- change mappings
		vim.g.db_ui_disable_mappings = 1
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dbui",
			callback = function()
				vim.keymap.set("n", "<CR>", "<Plug>(DBUI_SelectLine)", { buffer = true })
				vim.keymap.set("n", "o", "<Plug>(DBUI_SelectLine)", { buffer = true })
				vim.keymap.set("n", "d", "<Plug>(DBUI_DeleteLine)", { buffer = true })
				vim.keymap.set("n", "a", "<Plug>(DBUI_AddConnection)", { buffer = true })
				vim.keymap.set("n", "h", "<Plug>(DBUI_ToggleDetails)", { buffer = true })
			end,
		})
        -- for query file operations, run the following, whilst in the query buffer:
        -- :execute "normal \<Plug>(DBUI_SaveQuery)"
        -- :execute "normal \<Plug>(DBUI_EditBindParameters)"
	end,
}
