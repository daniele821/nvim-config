return {
	-- mason packages to install.
	-- [fmt]: list of lang for the formatter
	-- [lnt]: list of lang for the linter
	-- [bin]: name of executable (if not present, name of package is assumed)
	-- [lcl]: if set to anything it avoid installing package, if binary already present in path
	--
	-- note: [lcl], [fmt], [lnt] require [bin] (otherwise it is assumed the package name as bin value)
	lsps = {
		["bash-language-server"] = {},
		["css-lsp"] = {},
		["gopls"] = {},
		["html-lsp"] = {},
		["jq"] = { fmt = { "json" }, lnt = { "json" }, lcl = true },
		["lua-language-server"] = {},
		["ruff"] = {},
		["rust-analyzer"] = { lcl = true },
		["shellcheck"] = { lnt = { "bash", "sh" } },
		["shfmt"] = { fmt = { "bash", "sh" } },
		["stylua"] = { fmt = { "lua" } },
		["typescript-language-server"] = {},
	},
	-- languages for which to install treesitter parsers
	-- [map]: array of all filetypes to be remapped to use the parser specified
	parsers = {
		["bash"] = { map = { "sh" } },
		["c"] = {},
		["cpp"] = {},
		["css"] = {},
		["go"] = {},
		["html"] = {},
		["javascript"] = {},
		["json"] = {},
		["markdown"] = {},
		["php"] = {},
		["python"] = {},
		["rust"] = {},
		["sql"] = {},
		["toml"] = {},
		["typescript"] = {},
		["yaml"] = {},
	},
}
