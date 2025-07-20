return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  -- use <leader>a (agentic features) namespace
  keys = {
    { '<leader>aa', '<cmd>ClaudeCode<CR>', desc = 'Claude Code' },
    { '<leader>ac', '<cmd>ClaudeCodeContinue<CR>', desc = 'Continue' },
    { '<leader>av', '<cmd>ClaudeCodeVerbose<CR>', desc = 'Verbose' },
    { '<leader>ar', '<cmd>ClaudeCodeResume<CR>', desc = 'Resume' },
    -- Quick toggle
    { '<C-,>', '<cmd>ClaudeCode<CR>', desc = 'Claude Code Toggle' },
  },

  config = function()
    require('claude-code').setup {
      window = {
        split_ratio = 0.3,
        position = 'vertical',
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
      -- Disable built-in keymaps, use our namespace
      keymaps = {
        toggle = {
          normal = false, -- Disable default keymaps
          terminal = '<C-,>', -- Keep terminal mode keymap
          variants = {}, -- Clear, use our keys definition
        },
        window_navigation = true,
        scrolling = true,
      },
    }
  end,
}
