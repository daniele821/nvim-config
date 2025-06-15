-- make installed binaries ALWAYS available
local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason")
local install_bin = vim.fs.joinpath(install_dir, "bin")
vim.env.PATH = install_bin .. ":" .. vim.env.PATH

-- user commands
vim.api.nvim_create_user_command("StarterPackLsp", function()
	-- mason installations
	local mason_registry = require("mason-registry")
	local configs = require("utils.configs")
	local to_install_lsps = configs.lsps
	local use_local_lsp = configs.local_lsp
	local installed_lsps = mason_registry.get_installed_package_names()
	local missing_lsps = vim.iter(to_install_lsps)
		:filter(function(elem)
			return not vim.tbl_contains(installed_lsps, elem)
		end)
		:filter(function(elem)
			local local_lsp = use_local_lsp[elem]
			return not local_lsp or vim.fn.executable(local_lsp) == 0
		end)
		:join(" ")
	if missing_lsps ~= "" then
		vim.cmd("MasonInstall " .. missing_lsps)
	end
end, {})

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
        event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{
				"mason-org/mason.nvim",
				opts = {
					install_root_dir = install_dir,
					PATH = "skip",
					max_concurrent_installers = 8,
				},
			},
		},
	},
}
