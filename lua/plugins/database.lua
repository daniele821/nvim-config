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

        -- fixes for buffers in the same tab scope as database explorer
		vim.api.nvim_create_autocmd({ "BufEnter", "WinClosed" }, {
			callback = function()
				local tabpage = vim.api.nvim_get_current_tabpage()
				local wins = vim.api.nvim_tabpage_list_wins(tabpage)
				local dbui_present = false
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					if ft == "dbui" then
						dbui_present = true
						break
					end
				end
				for _, win in ipairs(wins) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					if ft == "json" then
						vim.diagnostic.enable(not dbui_present, { bufnr = buf })
					end
				end
			end,
		})
	end,
}
