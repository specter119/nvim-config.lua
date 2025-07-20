return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Undotree' },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_TreeNodeShape = '*'
    vim.g.undotree_TreeVertShape = '|'
    vim.g.undotree_TreeSplitShape = '/'
    vim.g.undotree_TreeReturnShape = '\\'
    vim.g.undotree_DiffCommand = 'diff'
    vim.g.undotree_RelativeTimestamp = 1
  end,
}
