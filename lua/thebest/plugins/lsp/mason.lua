-- create user command
vim.api.nvim_create_user_command("StarterPack", function()
    local to_install_lsps = {
        "html-lsp",
        "emmet-language-server",
        "bash-language-server",
        "css-lsp",
        "ruff",
        "lua-language-server",
        "shellcheck"
    }

    local installed_lsps = require("mason-registry").get_installed_package_names()
    local missing_lsps = vim.iter(to_install_lsps):filter(function(elem)
        return not vim.tbl_contains(installed_lsps, elem)
    end)
    if #missing_lsps > 0 then
        vim.cmd("MasonInstall " .. missing_lsps:join(" "))
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
