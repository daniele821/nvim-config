return {
	formatters_by_ft = {
		bash = { "shfmt" },
		json = { "jq" },
		lua = { "stylua" },
		sh = { "shfmt" },
	},
	linters_by_ft = {
		bash = { "shellcheck" },
		sh = { "shellcheck" },
	},
	lsp_to_enable = {
		"bashls",
		"cssls",
		"emmet_language_server",
		"html",
		"lua_ls",
		"ruff",
		"rust_analyzer",
	},
	mason_to_install = {
		"bash-language-server",
		"css-lsp",
		"emmet-language-server",
		"html-lsp",
		"jq",
		"lua-language-server",
		"ruff",
		"rust-analyzer",
		"shellcheck",
		"shfmt",
		"stylua",
	},
	mason_use_local = {
		["jq"] = "jq",
		["rust-analyzer"] = "rust-analyzer",
	},
}
