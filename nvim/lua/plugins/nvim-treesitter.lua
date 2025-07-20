return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  build = function()
    vim.cmd 'TSUpdate'
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- Check if Arch Linux
    local is_arch = vim.fn.filereadable '/etc/arch-release' == 1

    -- Basic language parser list
    local base_parsers = {
      -- Data science primary language
      'python',

      -- Future learning languages
      'rust',
      'typescript',
      'javascript',
      'go',

      -- Configuration files and data formats
      'json',
      'yaml',
      'toml',
      'markdown_inline',
      'typst',

      -- Web development (optional)
      'html',
      'css',

      -- Scientific/engineering computing
      'fortran', -- ABAQUS user subroutines

      -- Other common
      'bash',
      'regex',
      'comment',
    }

    -- If not Arch Linux, add parsers not provided by system
    if not is_arch then
      vim.list_extend(base_parsers, {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'markdown',
      })
    end

    require('nvim-treesitter.configs').setup {
      -- Install language parsers based on system type
      ensure_installed = base_parsers,

      -- Automatically install missing parsers
      auto_install = true,

      -- Syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<S-CR>',
          node_decremental = '<BS>',
        },
      },

      -- Indentation
      indent = {
        enable = true,
      },

      -- Text objects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    }

    -- Set folding method to treesitter
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false -- Default not folded
  end,
}
