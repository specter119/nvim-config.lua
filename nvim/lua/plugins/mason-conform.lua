return {
  'stevearc/conform.nvim',
  dependencies = {
    'zapling/mason-conform.nvim',
  },
  opts = {
    formatters_by_ft = {
      -- 数据科学主力语言
      python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
      
      -- 配置和开发语言
      lua = { 'stylua' },
      
      -- 未来学习的语言
      rust = { 'rustfmt' },
      typescript = { 'prettierd', 'prettier' },
      javascript = { 'prettierd', 'prettier' },
      go = { 'gofmt', 'goimports' },
      
      -- 数据科学相关格式
      json = { 'jq' },
      yaml = { 'yamlfmt' },
      toml = { 'taplo' },
      markdown = { 'markdownlint' },
      typst = { 'typstfmt' },
      
      -- Web 开发 (可选)
      html = { 'prettierd', 'prettier' },
      css = { 'prettierd', 'prettier' },
    },
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
  },
}
