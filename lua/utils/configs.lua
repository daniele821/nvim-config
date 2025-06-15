return {
	-- mason packages to install.
	-- [lsp]: name of lsp provided by package
	-- [fmt]: list of lang for the formatter
	-- [bin]: name of executable (if not present, name of package is assumed)
	-- [lcl]: if set to anything it avoid installing package, if binary already present in path
	--
	-- note: [lcl], [fmt] require [bin] (otherwise it is assumed the package name as bin value)
	lsps = {
		["bash-language-server"] = { lsp = "bashls" },
		["css-lsp"] = { lsp = "cssls" },
		["gopls"] = { lsp = "gopls" },
		["html-lsp"] = { lsp = "html" },
		["json-lsp"] = { lsp = "jsonls" },
		["lua-language-server"] = { lsp = "lua_ls" },
		["ruff"] = { lsp = "ruff" },
		["rust-analyzer"] = { lsp = "rust_analyzer", lcl = true },
		["shfmt"] = { fmt = { "bash", "sh" } },
		["stylua"] = { fmt = { "lua" } },
		["typescript-language-server"] = { lsp = "ts_ls" },
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
		["javascript"] = { map = { "javascriptreact" } },
		["json"] = {},
		["markdown"] = { map = { "pandoc" } },
		["php"] = {},
		["python"] = { map = { "gyp" } },
		["rust"] = {},
		["sql"] = {},
		["toml"] = {},
		["typescript"] = {},
		["yaml"] = {},
	},
}
