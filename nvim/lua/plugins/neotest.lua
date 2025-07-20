return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- 测试适配器
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-plenary',
    },

    -- 使用 <leader>T* Terminal 命名空间（测试相关）
    keys = {
      { '<leader>Tt', '<cmd>lua require("neotest").run.run()<CR>', desc = 'Test Nearest' },
      { '<leader>Tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Test File' },
      { '<leader>Ta', '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>', desc = 'Test All' },
      { '<leader>Ts', '<cmd>lua require("neotest").summary.toggle()<CR>', desc = 'Test Summary' },
      { '<leader>To', '<cmd>lua require("neotest").output.open({ enter = true })<CR>', desc = 'Test Output' },
      { '<leader>TP', '<cmd>lua require("neotest").output_panel.toggle()<CR>', desc = 'Test Panel' },
      { '<leader>TN', '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>', desc = 'Next Failed Test' },
      { '<leader>TB', '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>', desc = 'Prev Failed Test' },
      { '<leader>Td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<CR>', desc = 'Debug Test' },
      { '<leader>TW', '<cmd>lua require("neotest").watch.toggle()<CR>', desc = 'Watch Tests' },
      { '<leader>TC', '<cmd>lua require("neotest").run.stop()<CR>', desc = 'Cancel Test' },
      { '<leader>TR', '<cmd>lua require("neotest").run.run_last()<CR>', desc = 'Run Last Test' },
    },

    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            -- 使用 pytest 作为测试运行器
            runner = 'pytest',

            -- Python 路径配置
            python = function()
              local venv_path = os.getenv 'VIRTUAL_ENV'
              if venv_path then
                return venv_path .. '/bin/python'
              end
              return vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python'
            end,

            -- Pytest 参数
            args = { '-v', '--tb=short' },

            -- 测试发现
            is_test_file = function(file_path)
              return string.match(file_path, 'test_.*%.py$')
                or string.match(file_path, '.*_test%.py$')
                or string.match(file_path, 'tests/.*%.py$')
            end,
          },

          require 'neotest-plenary',
        },

        discovery = {
          enabled = true,
          concurrent = 1,
        },

        running = {
          concurrent = true,
        },

        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          open = 'botright vsplit | vertical resize 50',
        },

        output = {
          enabled = true,
          open_on_run = 'short',
        },

        output_panel = {
          enabled = true,
          open = 'botright split | resize 15',
        },

        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },

        strategies = {
          integrated = {
            height = 40,
            width = 120,
          },
        },

        icons = {
          child_indent = '│',
          child_prefix = '├',
          collapsed = '─',
          expanded = '╮',
          failed = '✖',
          final_child_indent = ' ',
          final_child_prefix = '╰',
          non_collapsible = '─',
          passed = '✓',
          running = '⟳',
          running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
          skipped = '○',
          unknown = '?',
        },

        highlights = {
          adapter_name = 'NeotestAdapterName',
          border = 'NeotestBorder',
          dir = 'NeotestDir',
          expand_marker = 'NeotestExpandMarker',
          failed = 'NeotestFailed',
          file = 'NeotestFile',
          focused = 'NeotestFocused',
          indent = 'NeotestIndent',
          marked = 'NeotestMarked',
          namespace = 'NeotestNamespace',
          passed = 'NeotestPassed',
          running = 'NeotestRunning',
          select_win = 'NeotestWinSelect',
          skipped = 'NeotestSkipped',
          target = 'NeotestTarget',
          test = 'NeotestTest',
          unknown = 'NeotestUnknown',
        },

        floating = {
          border = 'rounded',
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },

        default_strategy = 'integrated',

        log_level = vim.log.levels.INFO,

        consumers = {},

        state = {
          enabled = true,
        },

        diagnostic = {
          enabled = true,
          severity = 1,
        },

        projects = {},
      }

      -- 自动命令：保存文件时运行测试
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.py' },
        callback = function()
          -- 只在测试文件或被测试文件发生变化时运行
          local file = vim.fn.expand '%'
          if string.match(file, 'test_.*%.py$') or string.match(file, '.*_test%.py$') then
            -- 可以选择自动运行测试
            -- require('neotest').run.run()
          end
        end,
      })
    end,
  },
}
