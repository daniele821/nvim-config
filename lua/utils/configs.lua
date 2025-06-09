return {
	-- mason packages to install.
	-- [lsp]: name of lsp provided by package
	-- [bin]: name of executable (if not present, name of package is assumed)
	-- [lcl]*: if set to anything it avoid installing package, if binary already present in path
	-- [fmt]*: list of lang for the formatter
	--
	-- *: [bin] is required (is empty, package name is assumed!)
	lsps = {
		["bash-language-server"] = { lsp = "bashls" },
		["css-lsp"] = { lsp = "cssls" },
		["gopls"] = { lsp = "gopls" },
		["html-lsp"] = { lsp = "html" },
		["json-lsp"] = { lsp = "jsonls" },
		["lua-language-server"] = { lsp = "lua_ls" },
		["ruff"] = { lsp = "ruff" },
		["rust-analyzer"] = { lsp = "rust_analyzer", lcl = true },
		["shellcheck"] = {},
		["shfmt"] = { fmt = { "bash", "sh" } },
		["stylua"] = { fmt = { "lua" } },
		["typescript-language-server"] = { lsp = "ts_ls" },
	},
	-- languages for which to start treesitter parsers
	parsers = {
		"bash",
		"c",
		"cpp",
		"css",
		"go",
		"html",
		"javascript",
		"json",
		"markdown",
		"php",
		"python",
		"rust",
		"sql",
		"toml",
		"typescript",
		"yaml",
	},
}
