local configs = require("utils.configs")
return {
    -- array of all filetypes for which to enable treesitter
    all_language_parsers = (function()
        return vim.tbl_keys(configs.parsers)
    end)(),
    -- array of all treesitter parsers to download
    to_install_parsers = (function()
        local res = {}
        for lang, opts in pairs(configs.parsers) do
            if opts.map == nil then
                table.insert(res, lang)
            end
        end
        return res
    end)(),
    -- table of languages to remap to other languages
    to_remap_parsers = (function()
        local res = {}
        for lang, opts in pairs(configs.parsers) do
            if opts.map ~= nil then
                res[lang] = opts.map
            end
        end
        return res
    end)(),
    -- array of all lsp to enable
    lsp_to_enable = (function()
        local res = {}
        for _, opts in pairs(configs.lsps) do
            if opts.lsp ~= nil then
                table.insert(res, opts.lsp)
            end
        end
        return res
    end)(),
}
