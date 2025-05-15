-- make installed binaries ALWAYS available
vim.env.PATH = vim.env.PATH .. ":" .. vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")

return {
    "mason-org/mason.nvim",
    cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll"},
    opts = {},
}
