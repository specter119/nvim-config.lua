return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'
    local keymap_rules = require 'config.keymaps.rules' -- Updated path

    wk.setup {
      preset = 'modern',
      delay = 400,
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ''
      end,
      -- Enable conflict detection
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

    -- Only define namespace group names, specific keymaps are auto-registered by plugins
    wk.add {
      -- Based on namespace rules define groups
      { '<leader>a', group = 'Agentic/AI' },
      { '<leader>f', group = 'Find/Files' },
      { '<leader>g', group = 'Git' },
      { '<leader>c', group = 'Code/LSP' },
      { '<leader>cw', group = 'Workspace' }, -- LSP workspace sub-namespace
      { '<leader>d', group = 'Debug/Diagnostics' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', group = 'Window' },
      { '<leader>b', group = 'Buffer' },
      { '<leader>h', group = 'Help' },
      { '<leader>T', group = 'Terminal' },
      { '<leader>S', group = 'Session' },
    }

    -- Validate keymaps function
    local function validate_keymap(key, desc)
      local valid, reason = keymap_rules.validate_key(key)
      if not valid then
        vim.notify(string.format('Invalid keymap: %s (%s)', key, reason), vim.log.levels.WARN)
      end
    end

    -- Create validation command
    vim.api.nvim_create_user_command('ValidateKeymaps', function()
      -- Get all keymaps and validate
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
