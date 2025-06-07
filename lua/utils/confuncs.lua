local configs = require("utils.configs")

-- fix configs data
for lsp, opts in pairs(configs.lsps) do
	if opts.bin == nil then
		if opts.lcl ~= nil or opts.fmt ~= nil then
			opts.bin = lsp
		end
	end
end

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
		return vim.iter(configs.parsers)
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
		local res = {}
		for lsp, opts in pairs(configs.lsps) do
			if opts.lcl ~= nil then
				res[lsp] = opts.bin
			end
		end
		return res
	end)(),
	formatters_by_ft = (function()
		local res = {}
		for _, opts in pairs(configs.lsps) do
			if opts.fmt ~= nil then
				for _, lang in ipairs(opts.fmt) do
					if res[lang] == nil then
						res[lang] = {}
					end
					table.insert(res[lang], opts.bin)
				end
			end
		end
		return res
	end)(),
}
