local ft = require 'guard.filetype'

-- Assuming you have guard-collection
ft('python'):fmt 'ruff'

ft('lua'):fmt 'stylua'

require('guard').setup {
  fmt_on_save = true,
  lsp_as_default_formatter = false,
}
