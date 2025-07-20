return {
  {
    name = 'filetype-settings',
    dir = vim.fn.stdpath 'config',
    config = function()
      -- Fortran FileType configuration for fixed-form support
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fortran',
        callback = function()
          local filename = vim.api.nvim_buf_get_name(0)

          -- Fixed-form Fortran settings for ABAQUS (.f, .for, .F, .FOR extensions)
          if filename:match '%.f$' or filename:match '%.for$' or filename:match '%.F$' or filename:match '%.FOR$' then
            vim.bo.expandtab = false
            vim.bo.tabstop = 8
            vim.bo.shiftwidth = 8
            vim.bo.softtabstop = 8
            vim.opt_local.textwidth = 72
            vim.opt_local.colorcolumn = '72'
            vim.bo.commentstring = 'C %s'
          end
          -- Free-form Fortran (.f90, .f95, etc.) uses Neovim defaults
        end,
      })
    end,
  },
}
