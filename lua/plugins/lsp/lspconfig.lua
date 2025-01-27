local servers = {

	-- LUA_LS documentation:
	-- https://luals.github.io/wiki/settings/
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

	-- GOPLS documentations:
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
	gopls = {
		settings = {
			gopls = {
				["ui.completion.usePlaceholders"] = false,
				["ui.inlayhint.hints"] = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					rangeVariableTypes = true,
					parameterNames = true,
				},
			},
		},
	},

	-- INTELEPHENSE documentation:
	-- https://github.com/bmewburn/intelephense-docs/blob/master/gettingStarted.md
	intelephense = {
		init_options = {
			globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
		},
	},
}

local starterpack_lsp = {
	-- lua
	"stylua",
	"lua-language-server",
	-- bash
	"shellcheck",
	"bash-language-server",
	"shfmt",
	-- python
	"jedi-language-server",
	"black",
	-- go
	"gopls",
	"goimports",
	-- html, css, javascript, json, php
	"html-lsp",
	"css-lsp",
	"typescript-language-server",
	"jq",
	"json-lsp",
	"intelephense",
}

return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- gaps the bridge between completion engine and lsp
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- add borders
		local border = { border = "double" }
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border)
		vim.diagnostic.config({ float = border })

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local client_cap = vim.lsp.protocol.make_client_capabilities()
		local server_cap = require("cmp_nvim_lsp").default_capabilities()
		local cap = vim.tbl_deep_extend("force", client_cap, server_cap)

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
		require("mason-tool-installer").setup({ ensure_installed = starterpack_lsp })

		-- keymap to toggle inlay hints
		vim.keymap.set("n", "<a-h>", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			require("lualine").refresh({})
		end, {})

		-- signcolumn diagnostic signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
				linehl = {},
				numhl = {},
			},
		})

		--  This function gets run when an LSP attaches to a particular buffer.
		-- NEEDED, OTHERWISE GD WON'T ALWAYS WORK (maybe in a stable release)
		-- GOLANG: gd in fmt.Println() doesn't work
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)
			end,
		})
	end,
}
