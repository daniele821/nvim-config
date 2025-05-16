-- DOCUMENTATION: https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
return {
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
  filetypes = { 'bash', 'sh' },
  root_markers = { '.git' },
}
