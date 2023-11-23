require('nvim-treesitter.install').compilers = { 'x86_64-w64-mingw32-gcc' }
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vim', 'lua', 'python', 'toml', 'yaml', 'latex' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    },
  },
  indent = {
    enable = false,
  },
}
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99
