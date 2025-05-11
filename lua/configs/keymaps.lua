-- easily quit terminal 
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- easily use netrw 
vim.keymap.set('n', '-', ':Ex<CR>', { noremap = true, silent = true })

