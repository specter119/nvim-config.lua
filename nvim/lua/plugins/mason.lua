return {
  {
    'mason-org/mason.nvim',
    opts = {},
    build = ':MasonUpdate',
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
  },
}
