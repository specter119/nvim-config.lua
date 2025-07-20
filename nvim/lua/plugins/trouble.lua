return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',

  -- use <leader>d* = Debug/Diagnostics 命名空间
  keys = {
    -- diagnostic面板
    { '<leader>dt', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics Toggle' },
    { '<leader>db', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics' },
    { '<leader>ds', '<cmd>Trouble symbols toggle focus=false<CR>', desc = 'Symbols' },
    { '<leader>dr', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', desc = 'LSP References' },
    { '<leader>dL', '<cmd>Trouble loclist toggle<CR>', desc = 'Location List' },
    { '<leader>dQ', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix List' },
  },
}
