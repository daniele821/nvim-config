return {
	cmd = { "bash-language-server", "start" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
			-- shellcheckPath = "",
			-- shfmt = { path = "" },
		},
	},
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
}
