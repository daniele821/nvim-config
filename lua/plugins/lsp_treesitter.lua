-- automagically launch treesitter in buffers
for lang, parser in pairs(require("utils.configs").remap_parsers) do
	vim.treesitter.language.register(parser, lang)
end
vim.api.nvim_create_autocmd("Filetype", {
	callback = function()
		vim.schedule(function()
			if
				vim.tbl_contains(require("utils.configs").parsers, vim.bo.filetype)
				or require("utils.configs").remap_parsers[vim.bo.filetype]
			then
				pcall(vim.treesitter.start)
			end
		end)
	end,
})

-- command to install missing parsers
vim.api.nvim_create_user_command("StarterPackParsers", function()
	local res = require("nvim-treesitter").install(require("utils.configs").parsers)
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
