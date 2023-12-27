return {
  -- ui: color theme
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000, opts = {} },
  -- buffer & tab
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'akinsho/bufferline.nvim', version = '3.x', dependencies = 'nvim-tree/nvim-web-devicons' },
  -- frame
  { 'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons' },
  -- content
  -- { 'glepnir/dashboard-nvim', event = 'VimEnter', opts = {}, dependencies = 'nvim-tree/nvim-web-devicons' },
  -- { 'goolord/alpha-nvim', event = 'VimEnter', init = function()
  --   require('alpha').setup(require('alpha.themes.startify').config)
  -- end , dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    'echasnovski/mini.starter',
    version = false,
    init = function()
      require('mini.starter').setup()
    end,
    event = 'VimEnter',
  },
  { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  -- lsp,
  'neovim/nvim-lspconfig',
  -- autocomplete,
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require 'cmp'
      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },
  -- formatter
  {
    'nvimdev/guard.nvim',
    -- Builtin configuration, optional
    dependencies = {
      'nvimdev/guard-collection',
    },
  },
  -- keybinding
  'folke/which-key.nvim',
  -- copilot
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
    dependencies = 'zbirenbaum/copilot.lua',
  },
}
