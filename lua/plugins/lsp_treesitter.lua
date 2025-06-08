-- automagically launch treesitter in buffers
local confuncs = require("utils.confuncs")
for lang, parser in pairs(confuncs.to_remap_parsers) do
	vim.treesitter.language.register(parser, lang)
end
vim.api.nvim_create_autocmd("Filetype", {
	callback = function()
		if vim.tbl_contains(confuncs.all_language_parsers, vim.bo.filetype) then
			vim.schedule(function()
				pcall(vim.treesitter.start)
			end)
		end
	end,
})

-- command to install missing parsers
vim.api.nvim_create_user_command("StarterPackParsers", function()
	local res = require("nvim-treesitter").install(confuncs.to_install_parsers)
	if #vim.api.nvim_list_uis() == 0 then
		res:wait(300000)
	end
end, {})

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	branch = "main",
	build = ":TSUpdate",
}
