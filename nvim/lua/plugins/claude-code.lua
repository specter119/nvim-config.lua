return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  -- 使用 <leader>a (agentic features) 命名空间
  keys = {
    { '<leader>aa', '<cmd>ClaudeCode<CR>', desc = 'Claude Code' },
    { '<leader>ac', '<cmd>ClaudeCodeContinue<CR>', desc = 'Continue' },
    { '<leader>av', '<cmd>ClaudeCodeVerbose<CR>', desc = 'Verbose' },
    { '<leader>ar', '<cmd>ClaudeCodeResume<CR>', desc = 'Resume' },
    -- 快速切换
    { '<C-,>', '<cmd>ClaudeCode<CR>', desc = 'Claude Code Toggle' },
  },

  config = function()
    require('claude-code').setup {
      window = {
        split_ratio = 0.3,
        position = 'botright',
        enter_insert = true,
        hide_numbers = true,
        hide_signcolumn = true,
        float = {
          width = '85%',
          height = '85%',
          row = 'center',
          col = 'center',
          relative = 'editor',
          border = 'rounded',
        },
      },
      refresh = {
        enable = true,
        updatetime = 100,
        timer_interval = 1000,
        show_notifications = true,
      },
      git = {
        use_git_root = true,
      },
      shell = {
        separator = '&&',
        pushd_cmd = 'pushd',
        popd_cmd = 'popd',
      },
      command = 'claude',
      command_variants = {
        continue = '--continue',
        resume = '--resume',
        verbose = '--verbose',
      },
      -- 禁用内置快捷键，使用我们的命名空间
      keymaps = {
        toggle = {
          normal = false, -- 禁用默认快捷键
          terminal = '<C-,>', -- 保留终端模式快捷键
          variants = {}, -- 清空，使用我们的 keys 定义
        },
        window_navigation = true,
        scrolling = true,
      },
    }
  end,
}
