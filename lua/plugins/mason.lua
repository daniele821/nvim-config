-- make installed binaries ALWAYS available
vim.env.PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin") .. ":" .. vim.env.PATH

return {
    "mason-org/mason.nvim",
    cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll"},
    opts = {},
}
