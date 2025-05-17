-- get string with list of active lsp in current buffer
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

-- get string with list of active linters in current buffer
function LinterList()
    if not package.loaded["lint"] then
        return ""
    end
    local linters = vim.iter(require("lint").linters_by_ft[vim.bo.filetype] or {}):filter(function(linter)
        return vim.fn.executable(linter) == 1
    end):totable()
    if #linters > 0 then
        local lint_icon = "󰕥 "
        local linter_names = vim.iter(linters):join(" " .. lint_icon)
        return lint_icon .. linter_names
    end
    return ""
end

-- get string with list of active formatters in current buffer
function FormatterList()
    if not package.loaded["conform"] then
        return ""
    end
    local formatters = vim.iter(require("conform").list_formatters(0)):map(function(formatter)
        return formatter.name
    end):totable()
    if #formatters > 0 then
        local formatter_icon = " "
        local formatter_names = vim.iter(formatters):join(" " .. formatter_icon)
        return formatter_icon .. formatter_names
    end
    return ""
end

-- get string of last component of filename
function Filename()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^.*://") then
        return "%f"
    end
    return "%t"
end

-- statusline + autocmd to refresh when necessary
vim.opt.statusline = '%<%{%v:lua.Filename()%} %m%r%y %= %{v:lua.LspList()} %{v:lua.LinterList()} %{v:lua.FormatterList()} %= %{&ff} %l:%v %P'
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.cmd("redrawstatus")
    end
})


return {}
