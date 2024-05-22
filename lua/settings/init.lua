return {
	servers = {
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
		bashls = {
			settings = {
				bashIde = {
					shellcheckPath = "",
				},
			},
		},
	},
	starterpack_lsp = {
		"stylua",
		"lua-language-server",
		"shellcheck",
		"bash-language-server",
		"shfmt",
		"clangd",
		"python-lsp-server",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
	},
	disable_autoformat = true,
}
