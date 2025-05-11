-- disable autocommenting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
      vim.highlight.on_yank()
  end,
})

-- ctrl+c to close netrw buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.keymap.set('n', '<C-c>', ':bd<CR>', { buffer = true,  silent = true, nowait = true })
  end
})
