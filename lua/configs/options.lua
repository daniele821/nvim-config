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

-- global statusline
vim.opt.laststatus = 3
vim.opt.statusline='%<%f %m%r%h%w%y%=%{&ff} %l:%v %P'

-- space on the left
vim.opt.signcolumn = "yes"

