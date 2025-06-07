local configs = require("utils.configs")
return {
    all_language_parsers = (function()
        return vim.tbl_keys(configs.parsers)
    end)(),
    to_install_parsers = (function()
        local res = {}
        for lang, opts in pairs(configs.parsers) do
            if opts.map == nil then
                table.insert(res, lang)
            end
        end
        return res
    end)(),
    to_remap_parsers = (function()
        local res = {}
        for lang, opts in pairs(configs.parsers) do
            if opts.map ~= nil then
                table.insert(res, { [lang] = opts.map })
            end
        end
        return res
    end)(),
}
