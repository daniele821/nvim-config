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

-- command to download all the goodies
vim.api.nvim_create_user_command("StarterPack", function()
	-- mason installations
	local ok1, mason_registry = pcall(require, "mason-registry")
	if ok1 then
		local to_install_lsps = require("utils.configs").mason_to_install
		local use_local_lsp = require("utils.configs").mason_use_local
		local installed_lsps = mason_registry.get_installed_package_names()
		local missing_lsps = vim.iter(to_install_lsps)
			:filter(function(elem)
				return not vim.tbl_contains(installed_lsps, elem)
			end)
			:filter(function(elem)
				local local_lsp = use_local_lsp[elem]
				return not local_lsp or vim.fn.executable(local_lsp) == 0
			end)
			:join(" ")
		if missing_lsps ~= "" then
			vim.cmd("MasonInstall " .. missing_lsps)
		end
	end

	-- treesitter installations
	local ok2, treesitter_configs = pcall(require, "nvim-treesitter.configs")
	if ok2 then
		local to_install_parsers = require("utils.configs").parsers
		treesitter_configs.setup({ ensure_installed = to_install_parsers, sync_install = false })
		treesitter_configs.setup({ ensure_installed = {}, sync_install = false })
	end
end, {})

-- command to toggle inlay hints
vim.api.nvim_create_user_command("InlayHintsToggle", function()
	local hints = vim.lsp.inlay_hint.is_enabled()
	if hints then
		vim.api.nvim_echo({ { "hints are now DISABLED!", "" } }, false, {})
	else
		vim.api.nvim_echo({ { "hints are now ENABLED!", "" } }, false, {})
	end
	vim.lsp.inlay_hint.enable(not hints)
end, {})
