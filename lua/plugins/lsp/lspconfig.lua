-- enable lsp servers
vim.lsp.enable(require("utils.configs").lsp_to_enable)

-- stop lsp on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.iter(vim.lsp.get_clients()):each(function(client)
			client:stop()
		end)
	end,
})

-- additional keymaps for buffers with lsp attached
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
	end,
})

return {
	{ "j-hui/fidget.nvim", opts = {}, event = "LspAttach" },
}
