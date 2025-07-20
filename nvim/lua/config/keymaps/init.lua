-- Keymaps 统一入口
-- 这里只管理 Neovim 内置功能的快捷键
-- 插件快捷键由各插件的 keys 字段管理

-- 加载规则
require 'config.keymaps.rules'

-- 加载核心快捷键
require 'config.keymaps.core'
