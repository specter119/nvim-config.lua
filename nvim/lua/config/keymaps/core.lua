-- 核心 Neovim 快捷键
-- 只包含内置功能，不包含插件相关快捷键

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- 核心编辑操作 (不使用 leader 键)
-- ============================================================================

-- 窗口导航
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- 窗口大小调整
keymap('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase Window Height' })
keymap('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease Window Height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease Window Width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- 缓冲区导航
keymap('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
keymap('n', '<S-h>', '<cmd>bprev<CR>', { desc = 'Previous Buffer' })

-- 更好的缩进
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- 移动选中的行
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- 保持光标居中
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- 更好的粘贴 (不丢失寄存器)
keymap('x', '<leader>p', '"_dP', { desc = 'Paste without losing register' })

-- 系统剪贴板操作
keymap('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keymap('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keymap('n', '<leader>Y', '"+Y', { desc = 'Copy line to system clipboard' })

-- 删除但不复制
keymap('n', '<leader>x', '"_d', { desc = 'Delete without copying' })
keymap('v', '<leader>x', '"_d', { desc = 'Delete without copying' })

-- 保存文件
keymap('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save File' })
keymap('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save File' })

-- 清除搜索高亮
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- 终端模式导航
keymap('t', '<Esc>', '<C-\\><C-n>', opts)
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)

-- ============================================================================
-- 使用命名空间的快捷键
-- ============================================================================

-- <leader>b* = Buffer 命名空间
keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete Buffer' })

-- <leader>w* = Window 命名空间
keymap('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Split Vertical' })
keymap('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Split Horizontal' })
keymap('n', '<leader>we', '<C-w>=', { desc = 'Split Equal' })
keymap('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close Split' })

-- <leader>t* = Toggle 命名空间
keymap('n', '<leader>tw', '<cmd>set wrap!<CR>', { desc = 'Toggle Word Wrap' })
keymap('n', '<leader>tn', '<cmd>set number!<CR>', { desc = 'Toggle Line Numbers' })
keymap('n', '<leader>tr', '<cmd>set relativenumber!<CR>', { desc = 'Toggle Relative Numbers' })

-- <leader>d* = Debug/Diagnostics 命名空间
keymap('n', '<leader>dq', '<cmd>copen<CR>', { desc = 'Open Quickfix' })
keymap('n', '<leader>dQ', '<cmd>cclose<CR>', { desc = 'Close Quickfix' })
keymap('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous Quickfix' })
keymap('n', ']q', '<cmd>cnext<CR>', { desc = 'Next Quickfix' })

-- Location list 操作
keymap('n', '<leader>dL', '<cmd>lopen<CR>', { desc = 'Open Location List' })
keymap('n', '<leader>dC', '<cmd>lclose<CR>', { desc = 'Close Location List' })
keymap('n', '[l', '<cmd>lprev<CR>', { desc = 'Previous Location' })
keymap('n', ']l', '<cmd>lnext<CR>', { desc = 'Next Location' })

-- ============================================================================
-- 预留快捷键 (不使用命名空间)
-- ============================================================================

-- 快速保存和退出
keymap('n', '<leader>W', '<cmd>w<CR>', { desc = 'Save File' })
keymap('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
keymap('n', '<leader>Q', '<cmd>qa<CR>', { desc = 'Quit All' })

-- 注意：<leader>e 和 <leader>u 由插件使用
-- <leader>e -> nvim-tree (文件树)
-- <leader>u -> undotree (撤销树)
