-- easily quit terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- easily clear search
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- disable useless history buffers
vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "q/", "<nop>")
vim.keymap.set("n", "q?", "<nop>")

-- add / remove tabs
vim.keymap.set("n", "<a-t>", ":tabnew<CR>", { silent = true })
vim.keymap.set("n", "<a-s-t>", ":tabclose<CR>", { silent = true })
