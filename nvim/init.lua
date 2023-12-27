-- lazy installation
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- lightweight system wide settings
vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'
--
local machineconf = vim.fn.stdpath 'config' .. '/lua/machine/' .. vim.fn.hostname() .. '.lua'
if vim.loop.fs_stat(machineconf) then
  require('machine/' .. vim.fn.hostname())
end

require('lazy').setup 'config/plugins'
-- require('plugins')
require 'config/keybindings'
require 'config/ui'
require 'config/autocmds'
require 'plugins-config/nvim-tree'
require 'plugins-config/bufferline'
require 'plugins-config/nvim-treesitter'
require 'plugins-config/nvim-lspconfig'
require 'plugins-config/guard'
