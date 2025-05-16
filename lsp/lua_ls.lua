-- DOCUMENTATION: https://luals.github.io/wiki/settings/
local function is_nvim_project()
  local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
  local cwd = vim.fn.resolve(vim.loop.cwd())
  return cwd:sub(1, #config_dir) == config_dir
end

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        -- black magic to show vim api in ~/.config/nvim and nowhere else!
        library = is_nvim_project() and { vim.env.VIMRUNTIME } or {}
      }
    }
  }
}
