return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "mason-org/mason.nvim", opts = {} },
		},
		config = function()
			-- user commands
			vim.api.nvim_create_user_command("StarterPackLsp", function()
				-- mason installations
				local mason_registry = require("mason-registry")
				local configs = require("utils.configs")
				local to_install_lsps = configs.lsps
				local installed_lsps = mason_registry.get_installed_package_names()
				local missing_lsps = vim.iter(to_install_lsps)
					:filter(function(elem)
						return not vim.tbl_contains(installed_lsps, elem)
					end)
					:join(" ")
				if missing_lsps ~= "" then
					vim.cmd("MasonInstall " .. missing_lsps)
				end
			end, {})
		end,
	},
}
