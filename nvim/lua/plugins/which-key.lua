return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'
    local keymap_rules = require 'config.keymaps.rules' -- 更新路径

    wk.setup {
      preset = 'modern',
      delay = 400,
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ''
      end,
      -- 启用冲突检测
      notify = true,
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    }

    -- 只定义命名空间组名，具体快捷键由插件自动注册
    wk.add {
      -- 基于命名空间规则定义组
      { '<leader>a', group = 'Agentic/AI' },
      { '<leader>f', group = 'Find/Files' },
      { '<leader>g', group = 'Git' },
      { '<leader>c', group = 'Code/LSP' },
      { '<leader>cw', group = 'Workspace' }, -- LSP 工作区子命名空间
      { '<leader>d', group = 'Debug/Diagnostics' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', group = 'Window' },
      { '<leader>b', group = 'Buffer' },
      { '<leader>h', group = 'Help' },
      { '<leader>T', group = 'Terminal' },
      { '<leader>S', group = 'Session' },
    }

    -- 验证快捷键函数
    local function validate_keymap(key, desc)
      local valid, reason = keymap_rules.validate_key(key)
      if not valid then
        vim.notify(string.format('Invalid keymap: %s (%s)', key, reason), vim.log.levels.WARN)
      end
    end

    -- 创建验证命令
    vim.api.nvim_create_user_command('ValidateKeymaps', function()
      -- 获取所有快捷键并验证
      local keymaps = vim.api.nvim_get_keymap 'n'
      local invalid_keys = {}

      for _, keymap in ipairs(keymaps) do
        local key = keymap.lhs
        if key:match '^<leader>' then
          local valid, reason = keymap_rules.validate_key(key)
          if not valid then
            table.insert(invalid_keys, { key = key, reason = reason })
          end
        end
      end

      if #invalid_keys > 0 then
        vim.notify('Invalid keymaps found:', vim.log.levels.WARN)
        for _, item in ipairs(invalid_keys) do
          vim.notify(string.format('  %s: %s', item.key, item.reason), vim.log.levels.WARN)
        end
      else
        vim.notify('All keymaps are valid!', vim.log.levels.INFO)
      end
    end, { desc = 'Validate all keymaps against namespace rules' })
  end,

  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
