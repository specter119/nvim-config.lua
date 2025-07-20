return {
  'lewis6991/gitsigns.nvim',

  -- 使用 <leader>g* = Git 命名空间 和 <leader>t* = Toggle 命名空间
  keys = {
    -- Git hunk 操作
    {
      '<leader>gs',
      function()
        require('gitsigns').stage_hunk()
      end,
      desc = 'Stage Hunk',
    },
    {
      '<leader>gr',
      function()
        require('gitsigns').reset_hunk()
      end,
      desc = 'Reset Hunk',
    },
    {
      '<leader>gS',
      function()
        require('gitsigns').stage_buffer()
      end,
      desc = 'Stage Buffer',
    },
    {
      '<leader>gu',
      function()
        require('gitsigns').undo_stage_hunk()
      end,
      desc = 'Undo Stage Hunk',
    },
    {
      '<leader>gR',
      function()
        require('gitsigns').reset_buffer()
      end,
      desc = 'Reset Buffer',
    },
    {
      '<leader>gp',
      function()
        require('gitsigns').preview_hunk()
      end,
      desc = 'Preview Hunk',
    },
    {
      '<leader>gb',
      function()
        require('gitsigns').blame_line { full = true }
      end,
      desc = 'Blame Line',
    },
    {
      '<leader>gd',
      function()
        require('gitsigns').diffthis()
      end,
      desc = 'Diff This',
    },
    {
      '<leader>gD',
      function()
        require('gitsigns').diffthis '~'
      end,
      desc = 'Diff This ~',
    },

    -- Git hunk 操作 (visual mode)
    {
      '<leader>gs',
      function()
        require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end,
      desc = 'Stage Hunk',
      mode = 'v',
    },
    {
      '<leader>gr',
      function()
        require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end,
      desc = 'Reset Hunk',
      mode = 'v',
    },

    -- Toggle 功能
    {
      '<leader>tb',
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      desc = 'Toggle Line Blame',
    },
    {
      '<leader>td',
      function()
        require('gitsigns').toggle_deleted()
      end,
      desc = 'Toggle Deleted',
    },

    -- 导航
    {
      ']c',
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'Next Hunk',
    },
    {
      '[c',
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'Previous Hunk',
    },

    -- 文本对象
    { 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc = 'Select Hunk', mode = { 'o', 'x' } },
  },

  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      -- 移除 on_attach 中的快捷键设置，由 lazy.nvim 管理
    }
  end,
}
