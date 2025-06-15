-- automagically launch treesitter in buffers
vim.api.nvim_create_autocmd("Filetype", {
	callback = function()
		vim.schedule(function()
			pcall(vim.treesitter.start)
		end)
	end,
})

-- remap languages
for lang, ft in pairs(require("utils.configs").remap_parsers) do
	vim.treesitter.language.register(lang, ft)
end

-- command to install missing parsers
vim.api.nvim_create_user_command("StarterPackParsers", function()
	local res = require("nvim-treesitter").install(require("utils.configs").parsers)
	if #vim.api.nvim_list_uis() == 0 then
		res:wait(300000)
	end
end, {})

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = true,
}
