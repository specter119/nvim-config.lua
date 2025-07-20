return {
  {
    'mason-org/mason.nvim',
    event = 'VimEnter', -- Load after Neovim starts
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate' },
    opts = {},
    build = ':MasonUpdate',
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' }, -- Load when opening files
    opts = {},
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      ensure_installed = {
        -- Python debugging
        'debugpy',

        -- Future language support
        'codelldb', -- Rust/C++
        'delve', -- Go
        'js-debug-adapter', -- JavaScript/TypeScript
      },
      automatic_installation = true,
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = '/usr/bin/python3',
            args = { '-m', 'debugpy.adapter' },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
}
