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

-- add mapping to format file
vim.keymap.set("n", "grf", function()
	if package.loaded["conform"] then
		require("conform").format({ async = true, lsp_format = "fallback" })
	else
		vim.lsp.buf.format()
	end
end, {})
