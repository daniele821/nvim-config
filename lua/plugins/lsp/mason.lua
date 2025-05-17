-- create user command
vim.api.nvim_create_user_command("StarterPack", function()
    local to_install_lsps = {
        -- webdev
        "html-lsp",
        "emmet-language-server",
        "css-lsp",
        -- python
        "ruff",
        -- lua
        "lua-language-server",
        "stylua",
        -- bash
        "bash-language-server",
        "shellcheck",
        "shfmt",
        -- rust 
        "rust-analyzer",
        -- json
        "jq",
    }
    local use_local_lsp = {
        ["rust-analyzer"] = "rust-analyzer",
        ["jq"] = "jq",
    }

    local installed_lsps = require("mason-registry").get_installed_package_names()
    local missing_lsps = vim.iter(to_install_lsps):filter(function(elem)
        return not vim.tbl_contains(installed_lsps, elem)
    end):filter(function (elem)
        local local_lsp = use_local_lsp[elem]
        return not local_lsp or vim.fn.executable(local_lsp) == 0
    end):join(" ")
    if missing_lsps ~= "" then
        vim.cmd("MasonInstall " .. missing_lsps)
    end
end, {})

-- make installed binaries ALWAYS available
local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason")
local install_bin = vim.fs.joinpath(install_dir, "bin")
vim.env.PATH = install_bin .. ":" .. vim.env.PATH

return {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
    opts = {
        install_root_dir = install_dir,
        PATH = "skip",
    },
}
