return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim', -- ensure mason loads first
    {
      'zapling/mason-conform.nvim',
      config = function()
        require('mason-conform').setup()
      end,
    },
  },
  opts = {
    formatters_by_ft = {
      -- data science primary language
      python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },

      -- configuration and development languages
      lua = { 'stylua' },

      -- future learning languages
      rust = { 'rustfmt' },
      typescript = { 'prettierd', 'prettier' },
      javascript = { 'prettierd', 'prettier' },
      go = { 'gofmt', 'goimports' },

      -- data science related formats
      json = { 'jq' },
      yaml = { 'yamlfmt' },
      toml = { 'taplo' },
      markdown = { 'markdownlint' },
      typst = { 'typstfmt' },

      -- web development (optional)
      html = { 'prettierd', 'prettier' },
      css = { 'prettierd', 'prettier' },
    },
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
