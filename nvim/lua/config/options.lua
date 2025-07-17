-- 基本设置
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

-- 缩进设置
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 搜索设置
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- 外观设置
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.wrap = false

-- 备份和交换文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- 折叠设置 (由 treesitter 插件管理)
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldenable = false

-- 命令行设置
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.laststatus = 3

-- 补全设置
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.pumheight = 10

-- 文件编码
vim.opt.fileencoding = 'utf-8'
vim.opt.encoding = 'utf-8'

-- 性能设置
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- 窗口设置
vim.opt.winwidth = 30
vim.opt.winminwidth = 10
vim.opt.equalalways = false

-- 其他设置
vim.opt.hidden = true
vim.opt.confirm = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore = '*.o,*.obj,*.pyc,*.so,*.swp,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz'