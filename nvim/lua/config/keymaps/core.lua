-- Core Neovim keymaps
-- Only includes built-in functionality, no plugin-related keymaps

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Core editing operations (without leader key)
-- ============================================================================

-- Window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Window resizing
keymap('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase Window Height' })
keymap('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease Window Height' })
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease Window Width' })
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase Window Width' })

-- Buffer navigation
keymap('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
keymap('n', '<S-h>', '<cmd>bprev<CR>', { desc = 'Previous Buffer' })

-- Better indentation
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move selected lines
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Better paste (don't lose register)
keymap('x', '<leader>p', '"_dP', { desc = 'Paste without losing register' })

-- System clipboard operations
keymap('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keymap('v', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keymap('n', '<leader>Y', '"+Y', { desc = 'Copy line to system clipboard' })

-- Delete without copying
keymap('n', '<leader>x', '"_d', { desc = 'Delete without copying' })
keymap('v', '<leader>x', '"_d', { desc = 'Delete without copying' })

-- Save file
keymap('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save File' })
keymap('i', '<C-s>', '<Esc><cmd>w<CR>', { desc = 'Save File' })

-- Clear search highlight
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- Terminal mode navigation
keymap('t', '<Esc>', '<C-\\><C-n>', opts)
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)

-- ============================================================================
-- Keymaps with namespaces
-- ============================================================================

-- <leader>b* = Buffer namespace
keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete Buffer' })

-- <leader>w* = Window namespace
keymap('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Split Vertical' })
keymap('n', '<leader>wh', '<cmd>split<CR>', { desc = 'Split Horizontal' })
keymap('n', '<leader>we', '<C-w>=', { desc = 'Split Equal' })
keymap('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close Split' })

-- <leader>t* = Toggle namespace
keymap('n', '<leader>tw', '<cmd>set wrap!<CR>', { desc = 'Toggle Word Wrap' })
keymap('n', '<leader>tn', '<cmd>set number!<CR>', { desc = 'Toggle Line Numbers' })
keymap('n', '<leader>tr', '<cmd>set relativenumber!<CR>', { desc = 'Toggle Relative Numbers' })

-- <leader>d* = Debug/Diagnostics namespace
keymap('n', '<leader>dq', '<cmd>copen<CR>', { desc = 'Open Quickfix' })
keymap('n', '<leader>dQ', '<cmd>cclose<CR>', { desc = 'Close Quickfix' })
keymap('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous Quickfix' })
keymap('n', ']q', '<cmd>cnext<CR>', { desc = 'Next Quickfix' })

-- Location list operations
keymap('n', '<leader>dL', '<cmd>lopen<CR>', { desc = 'Open Location List' })
keymap('n', '<leader>dC', '<cmd>lclose<CR>', { desc = 'Close Location List' })
keymap('n', '[l', '<cmd>lprev<CR>', { desc = 'Previous Location' })
keymap('n', ']l', '<cmd>lnext<CR>', { desc = 'Next Location' })

-- ============================================================================
-- Reserved keymaps (without namespace)
-- ============================================================================

-- Quick save and quit
keymap('n', '<leader>W', '<cmd>w<CR>', { desc = 'Save File' })
keymap('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
keymap('n', '<leader>Q', '<cmd>qa<CR>', { desc = 'Quit All' })

-- Note: <leader>e and <leader>u are used by plugins
-- <leader>e -> nvim-tree (file tree)
-- <leader>u -> undotree (undo tree)
