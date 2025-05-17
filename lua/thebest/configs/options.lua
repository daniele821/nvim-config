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
vim.opt.statusline = '%<%f %m%r%y%=%{&ff} %l:%v %P'

-- whitespace symbols
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- various
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.mousemodel = "extend"
vim.opt.pumheight = 15
vim.opt.swapfile = false
