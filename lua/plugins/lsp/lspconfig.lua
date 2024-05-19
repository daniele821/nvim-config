return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
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

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		--  Add any additional override configuration in the following tables
		local servers = {
			-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
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

		-- Ensure the servers specified are installed
		require("mason").setup()
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- create user command and keymap to toggle inlay hints
		vim.api.nvim_create_user_command("ToggleInlayHints", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			if vim.lsp.inlay_hint.is_enabled({}) then
				print("inlay hints are enabled")
			else
				print("inlay hints are disabled")
			end
		end, {})
		vim.keymap.set("n", "<A-h>", ":ToggleInlayHints<CR>", {})

		-- create user command to try to install all nice lsp
		vim.api.nvim_create_user_command("StarterPackLsp", function()
			require("mason")
			vim.cmd(":MasonInstall stylua lua-language-server shellcheck clangd python-lsp-server")
		end, {})
	end,
}
