vim.g.maplocalleader = ' '
local opt = { noremap = true, silent = true }
-- window control
vim.keymap.set('n', 'sv', ':vsp<CR>', opt)
vim.keymap.set('n', 'sh', ':sp<CR>', opt)
vim.keymap.set('n', 'sc', '<C-w>c', opt)
vim.keymap.set('n', 'so', '<C-w>o', opt) -- close others
vim.keymap.set('n', '<A-h>', '<C-w>h', opt)
vim.keymap.set('n', '<A-j>', '<C-w>j', opt)
vim.keymap.set('n', '<A-k>', '<C-w>k', opt)
vim.keymap.set('n', '<A-l>', '<C-w>l', opt)
-- nvimTree
vim.keymap.set('n', '<A-m>', ':NvimTreeToggle<CR>', opt)
-- nvim-treesitter
vim.keymap.set('n', '<leader>i', 'gg=G', opt)
-- telescope
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', opt)
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', opt)
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', opt)
-- vim-lspconfig
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
