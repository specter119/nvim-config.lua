return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false, -- ensure theme loads immediately
  priority = 1000, -- highest priority
  config = function()
    vim.cmd.colorscheme 'rose-pine'
  end,
}
