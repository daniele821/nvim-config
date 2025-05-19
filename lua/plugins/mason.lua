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
