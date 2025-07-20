vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.o.clipboard = 'unnamedplus'
vim.loader.enable()
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

require 'config.options'
require 'config.keymaps' -- 唯一的快捷键入口
require 'config.lazy'
