-- statusline util functions
function LspList()
    local lsps = vim.lsp.get_clients({ bufnr = 0 })
    if #lsps > 0 then
        local lsp_icon = " "
        local lsp_names = vim.iter(lsps):map(function(elem)
            return elem.name
        end):join(" " .. lsp_icon)
        return lsp_icon .. lsp_names
    end
    return ""
end

function LinterList()
    local ok, lint = pcall(require, "lint")
    if not ok then
        return ""
    end
    local linters = vim.iter(lint.linters_by_ft[vim.bo.filetype] or {}):filter(function (linter)
            return vim.fn.executable(linter) == 1
        end):totable()
    if #linters > 0 then
        local lint_icon = "󰕥 "
        local linter_names = vim.iter(linters):join(" " .. lint_icon)
        return lint_icon .. linter_names
    end
    return ""
end

-- statusline + autocmd to refresh when necessary
vim.opt.statusline = '%<%t %m%r%y %= %{v:lua.LspList()} %{v:lua.LinterList()} %= %{&ff} %l:%v %P'
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.cmd("redrawstatus")
    end
})


return {}
