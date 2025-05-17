return {
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		json = { "jq" },
	},
	linters_by_ft = {
		sh = { "shellcheck" },
		bash = { "shellcheck" },
	},
	lsp_to_enable = {
		"lua_ls",
		"bashls",
		"ruff",
		"rust_analyzer",
		"cssls",
		"emmet_language_server",
		"html",
	},
	mason_to_install = {
		"html-lsp",
		"emmet-language-server",
		"css-lsp",
		"ruff",
		"lua-language-server",
		"stylua",
		"bash-language-server",
		"shellcheck",
		"shfmt",
		"rust-analyzer",
		"jq",
	},
	mason_use_local = {
		["rust-analyzer"] = "rust-analyzer",
		["jq"] = "jq",
	},
}
