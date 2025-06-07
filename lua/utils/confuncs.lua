local configs = require("utils.configs")

return {
	all_language_parsers = (function()
		return vim.tbl_keys(configs.parsers)
	end)(),
	to_install_parsers = (function()
		return vim.iter(configs.parsers)
			:filter(function(_, opts)
				return opts.map == nil
			end)
			:map(function(key, _)
				return key
			end)
			:totable()
	end)(),
	to_remap_parsers = (function()
		return vim.iter(configs.parsers)
			:filter(function(_, opts)
				return opts.map ~= nil
			end)
			:fold({}, function(acc, lang, opts)
				acc[lang] = opts.map
				return acc
			end)
	end)(),
	to_enable_lsp = (function()
		return vim.iter(configs.lsps)
			:filter(function(_, opts)
				return opts.lsp ~= nil
			end)
			:map(function(_, opts)
				return opts.lsp
			end)
			:totable()
	end)(),
	to_install_packages = (function()
		return vim.tbl_keys(configs.lsps)
	end)(),
	use_local_packages = (function()
		return vim.iter(configs.lsps)
			:filter(function(_, opts)
				return opts.lcl ~= nil
			end)
			:fold({}, function(acc, lsp, opts)
				acc[lsp] = opts.bin or lsp
				return acc
			end)
	end)(),
	formatters_by_ft = (function()
		return vim.iter(configs.lsps)
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
			end)
	end)(),
}
