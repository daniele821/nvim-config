-- configurable variables
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				hint = {
					enable = true,
				},
			},
		},
	},
}
local starterpack_lsp = {
	"stylua",
	"lua-language-server",
	"shellcheck",
	"bash-language-server",
	"shfmt",
	"clangd",
	"python-lsp-server",
}

return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufWritePost", "BufNewFile" },
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- gaps the bridge between completion engine and lsp
		"hrsh7th/cmp-nvim-lsp",

		-- Useful status updates for LSP.
		-- { "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local client_cap = vim.lsp.protocol.make_client_capabilities()
		local status, server_cap = pcall(require, "cmp_nvim_lsp")
		local cap = {}
		if status then
			server_cap = server_cap.default_capabilities()
			cap = vim.tbl_deep_extend("force", client_cap, server_cap)
		end

		-- setup mason in this order, otherwise it might break!
		require("mason").setup()
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, cap, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gt", vim.lsp.buf.type_definition, "Type [D]efinition")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			end,
		})

		-- create user command to try to install all nice lsp
		vim.api.nvim_create_user_command("StarterPackLsp", function()
			local installed_lsp = require("mason-registry").get_installed_package_names()
			local toinstall_lsp = vim.iter(starterpack_lsp)
				:filter(function(lsp)
					return not vim.tbl_contains(installed_lsp, lsp, {})
				end)
				:totable()
			if #toinstall_lsp == 0 then
				return
			end
			vim.cmd(":MasonInstall " .. table.concat(toinstall_lsp, " "))
		end, {})

		-- create keymap to toggle inlay hints
		vim.keymap.set("n", "<A-h>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			if vim.lsp.inlay_hint.is_enabled({}) then
				print("inlay hints are enabled")
			else
				print("inlay hints are disabled")
			end
		end, {})
	end,
}
