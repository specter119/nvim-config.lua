return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- 根据你的开发需求自动安装语言解析器
      ensure_installed = {
        -- 核心和配置语言
        'lua',
        'vim',
        'vimdoc',
        'query',
        
        -- 数据科学主力语言
        'python',
        
        -- 未来学习的语言
        'rust',
        'typescript',
        'javascript',
        'go',
        
        -- 配置文件和数据格式
        'json',
        'yaml',
        'toml',
        'markdown',
        'markdown_inline',
        'typst',
        
        -- Web 开发 (可选)
        'html',
        'css',
        
        -- 其他常用
        'bash',
        'regex',
        'comment',
      },
      
      -- 自动安装缺失的解析器
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
    })
    
    -- 设置折叠方式为 treesitter
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false -- 默认不折叠
  end,
}
