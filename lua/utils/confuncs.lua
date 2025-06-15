local configs = require("utils.configs")

return {
	to_install_packages = vim.tbl_keys(configs.lsps),
	to_enable_lsp = vim.iter(configs.lsps)
		:filter(function(_, opts)
			return opts.lsp ~= nil
		end)
		:map(function(_, opts)
			return opts.lsp
		end)
		:totable(),
	use_local_packages = vim.iter(configs.lsps)
		:filter(function(_, opts)
			return opts.lcl ~= nil
		end)
		:fold({}, function(acc, lsp, opts)
			acc[lsp] = opts.bin or lsp
			return acc
		end),
	formatters_by_ft = vim.iter(configs.lsps)
		:filter(function(_, opts)
			return opts.fmt ~= nil
		end)
		:fold({}, function(acc, lsp, opts)
			for _, lang in ipairs(opts.fmt) do
				if acc[lang] == nil then
					acc[lang] = {}
				end
				table.insert(acc[lang], opts.bin or lsp)
			end
			return acc
		end),
	linters_by_ft = vim.iter(configs.lsps)
		:filter(function(_, opts)
			return opts.lnt ~= nil
		end)
		:fold({}, function(acc, lsp, opts)
			for _, lang in ipairs(opts.lnt) do
				if acc[lang] == nil then
					acc[lang] = {}
				end
				table.insert(acc[lang], opts.bin or lsp)
			end
			return acc
		end),
	all_language_parsers = vim.tbl_keys(configs.parsers),
	remap_parsers = vim.iter(configs.parsers)
		:filter(function(_, opts)
			return opts.map ~= nil
		end)
		:fold({}, function(acc, lang, opts)
			acc[lang] = opts.map
			return acc
		end),
}
