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
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	bashls = {
		settings = {
			bashIde = {
				shellcheckPath = "shellcheck",
			},
		},
	},
}
local ensure_installed = {
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
	cmd = { "Mason", "StarterPackLsp" },
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- gaps the bridge between completion engine and lsp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local client_cap = vim.lsp.protocol.make_client_capabilities()
		local server_cap = require("cmp_nvim_lsp").default_capabilities()
		local cap = vim.tbl_deep_extend("force", client_cap, server_cap)

		-- setup mason in this order, otherwise it might break!
		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
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

		-- force install lsp once after plugin is loaded
		vim.cmd(":MasonToolsInstall")

		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)
			end,
		})

		-- create keymap to toggle inlay hints
		vim.keymap.set("n", "<a-h>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			if package.loaded["lualine"] then
				require("lualine").refresh({})
			end
		end, {})
	end,
}
