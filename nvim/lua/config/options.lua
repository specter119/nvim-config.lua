-- basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

-- indent settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search settings
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- appearance settings
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.wrap = false

-- backup and swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- folding settings (managed by treesitter plugin)
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldenable = false

-- command line settings
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.laststatus = 3

-- completion settings
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.pumheight = 10

-- file encoding
vim.opt.fileencoding = 'utf-8'
vim.opt.encoding = 'utf-8'

-- performance settings
vim.opt.lazyredraw = false -- disable lazyredraw for better user experience
vim.opt.synmaxcol = 300
vim.opt.updatetime = 250
vim.opt.redrawtime = 1500

-- window settings
vim.opt.winwidth = 30
vim.opt.winminwidth = 10
vim.opt.equalalways = false

-- other settings
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore = '*.o,*.obj,*.pyc,*.so,*.swp,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz'
