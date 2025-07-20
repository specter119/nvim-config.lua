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
    -- 检查是否为 Arch Linux
    local is_arch = vim.fn.filereadable '/etc/arch-release' == 1

    -- basic语言解析器列表
    local base_parsers = {
      -- data science主力语言
      'python',

      -- future learning语言
      'rust',
      'typescript',
      'javascript',
      'go',

      -- configuration文件和数据格式
      'json',
      'yaml',
      'toml',
      'markdown_inline',
      'typst',

      -- Web 开发 (可选)
      'html',
      'css',

      -- 其他常用
      'bash',
      'regex',
      'comment',
    }

    -- 如果不是 Arch Linux，添加系统不提供的解析器
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
      -- 根据系统类型安装语言解析器
      ensure_installed = base_parsers,

      -- automatic安装缺失的解析器
      auto_install = true,

      -- 语法高亮
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- 增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<S-CR>',
          node_decremental = '<BS>',
        },
      },

      -- 缩进
      indent = {
        enable = true,
      },

      -- 文本对象
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

    -- 设置折叠方式为 treesitter
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false -- default不折叠
  end,
}
