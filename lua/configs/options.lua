-- show row numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- space vs tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- set where to open split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- various
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.mousemodel = "extend"
vim.opt.pumheight = 15
vim.opt.swapfile = false

-- configure diagnostics
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = true,
	float = { border = "single" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

-- configure lsp floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 100
	opts.max_height = opts.max_height or 15
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
