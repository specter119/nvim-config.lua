return {
  'stevearc/conform.nvim',
  dependencies = {
    -- 'mason-org/mason.nvim',
    'zapling/mason-conform.nvim',
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
    },
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
