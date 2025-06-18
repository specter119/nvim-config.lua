return {
  'stevearc/conform.nvim',
  opt = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
    },
  },
}
