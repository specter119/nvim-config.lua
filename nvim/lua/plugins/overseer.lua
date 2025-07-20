return {
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },

    keys = {
      -- use <leader>T* Terminal 命名空间 (遵循keymap规则)
      { '<leader>To', '<cmd>OverseerToggle<CR>', desc = 'Overseer Toggle' },
      { '<leader>Tr', '<cmd>OverseerRun<CR>', desc = 'Run Task' },
      { '<leader>Ta', '<cmd>OverseerTaskAction<CR>', desc = 'Task Action' },
      { '<leader>Tc', '<cmd>OverseerClearCache<CR>', desc = 'Clear Cache' },
      { '<leader>Ti', '<cmd>OverseerInfo<CR>', desc = 'Overseer Info' },
      { '<leader>Tb', '<cmd>OverseerBuild<CR>', desc = 'Build Task' },
      { '<leader>Tq', '<cmd>OverseerQuickAction<CR>', desc = 'Quick Action' },

      -- Python 任务 (使用子命名空间)
      { '<leader>Tpr', '<cmd>OverseerRunCmd python %<CR>', desc = 'Run Python File' },
      { '<leader>Tpt', '<cmd>OverseerRunCmd python -m pytest %<CR>', desc = 'Run Pytest File' },
      { '<leader>Tpa', '<cmd>OverseerRunCmd python -m pytest<CR>', desc = 'Run All Tests' },
      { '<leader>Tpv', '<cmd>OverseerRunCmd python -m pytest -v<CR>', desc = 'Run Tests Verbose' },
      { '<leader>Tpc', '<cmd>OverseerRunCmd python -m pytest --cov=.<CR>', desc = 'Run with Coverage' },

      -- 代码质量 (使用子命名空间)
      { '<leader>Tll', '<cmd>OverseerRunCmd python -m ruff check .<CR>', desc = 'Ruff Check' },
      { '<leader>Tlf', '<cmd>OverseerRunCmd python -m ruff format .<CR>', desc = 'Ruff Format' },
      { '<leader>Tlm', '<cmd>OverseerRunCmd python -m mypy .<CR>', desc = 'MyPy Check' },

      -- 项目工具
      { '<leader>Tg', '<cmd>OverseerRunCmd git status<CR>', desc = 'Git Status' },
      { '<leader>Tm', '<cmd>OverseerRunCmd marimo edit<CR>', desc = 'Marimo Edit' },
      { '<leader>Tmr', '<cmd>OverseerRunCmd marimo run<CR>', desc = 'Marimo Run' },
      { '<leader>Tmn', '<cmd>OverseerRunCmd marimo edit --new<CR>', desc = 'New Marimo Notebook' },

      -- 智能运行
      { '<leader>TS', '<cmd>SmartRun<CR>', desc = 'Smart Run' },
    },

    config = function()
      require('overseer').setup {
        task_list = {
          direction = 'bottom',
          min_height = 25,
          max_height = 25,
          default_detail = 1,
          bindings = {
            ['?'] = 'ShowHelp',
            ['g?'] = 'ShowHelp',
            ['<CR>'] = 'RunAction',
            ['<C-e>'] = 'Edit',
            ['o'] = 'Open',
            ['<C-v>'] = 'OpenVsplit',
            ['<C-s>'] = 'OpenSplit',
            ['<C-f>'] = 'OpenFloat',
            ['<C-q>'] = 'OpenQuickFix',
            ['p'] = 'TogglePreview',
            ['<C-l>'] = 'IncreaseDetail',
            ['<C-h>'] = 'DecreaseDetail',
            ['L'] = 'IncreaseAllDetail',
            ['H'] = 'DecreaseAllDetail',
            ['['] = 'DecreaseWidth',
            [']'] = 'IncreaseWidth',
            ['{'] = 'PrevTask',
            ['}'] = 'NextTask',
            ['<C-k>'] = 'ScrollOutputUp',
            ['<C-j>'] = 'ScrollOutputDown',
            ['q'] = 'Close',
          },
        },
        form = {
          border = 'rounded',
          zindex = 40,
          min_width = 80,
          max_width = 0.9,
          width = nil,
          min_height = 10,
          max_height = 0.9,
          height = nil,
          win_opts = {
            winblend = 10,
          },
        },
        confirm = {
          border = 'rounded',
          zindex = 40,
          min_width = 20,
          width = 0.5,
          max_width = 0.9,
          min_height = 6,
          height = 0.9,
          max_height = 0.9,
          win_opts = {
            winblend = 10,
          },
        },
        task_win = {
          padding = 2,
          border = 'rounded',
          win_opts = {
            winblend = 10,
          },
        },
        help_win = {
          border = 'rounded',
          win_opts = {},
        },
        -- 任务模板
        templates = {
          builtin = {
            -- Python 任务
            python = {
              name = 'python',
              builder = function()
                local file = vim.fn.expand '%:p'
                if file == '' then
                  return nil
                end
                return {
                  cmd = { 'python' },
                  args = { file },
                  cwd = vim.fn.getcwd(),
                  name = 'python ' .. vim.fn.expand '%:t',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
            -- Pytest 任务
            pytest = {
              name = 'pytest',
              builder = function()
                local file = vim.fn.expand '%:p'
                if file == '' then
                  return nil
                end
                return {
                  cmd = { 'python', '-m', 'pytest' },
                  args = { file, '-v' },
                  cwd = vim.fn.getcwd(),
                  name = 'pytest ' .. vim.fn.expand '%:t',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
            -- 代码质量检查
            ruff_check = {
              name = 'ruff check',
              builder = function()
                return {
                  cmd = { 'python', '-m', 'ruff', 'check' },
                  args = { '.' },
                  cwd = vim.fn.getcwd(),
                  name = 'ruff check',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
            -- 格式化
            ruff_format = {
              name = 'ruff format',
              builder = function()
                return {
                  cmd = { 'python', '-m', 'ruff', 'format' },
                  args = { '.' },
                  cwd = vim.fn.getcwd(),
                  name = 'ruff format',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
            -- Marimo 笔记本
            marimo_edit = {
              name = 'marimo edit',
              builder = function()
                local file = vim.fn.expand '%:p'
                local args = {}
                if file ~= '' and string.match(file, '%.py$') then
                  table.insert(args, file)
                end
                return {
                  cmd = { 'marimo', 'edit' },
                  args = args,
                  cwd = vim.fn.getcwd(),
                  name = 'marimo edit',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
            marimo_run = {
              name = 'marimo run',
              builder = function()
                local file = vim.fn.expand '%:p'
                if file == '' or not string.match(file, '%.py$') then
                  return nil
                end
                return {
                  cmd = { 'marimo', 'run' },
                  args = { file },
                  cwd = vim.fn.getcwd(),
                  name = 'marimo run ' .. vim.fn.expand '%:t',
                }
              end,
              condition = {
                filetype = { 'python' },
              },
            },
          },
        },
        -- 组件配置
        component_aliases = {
          default = {
            { 'display_duration', detail_level = 2 },
            'on_output_summarize',
            'on_exit_set_status',
            'on_complete_notify',
            'on_complete_dispose',
          },
        },
        -- 策略
        strategy = {
          'toggleterm',
          direction = 'horizontal',
          autos_croll = true,
          quit_on_exit = 'success',
        },
        -- 日志
        log = {
          {
            type = 'echo',
            level = vim.log.levels.WARN,
          },
          {
            type = 'file',
            filename = 'overseer.log',
            level = vim.log.levels.INFO,
          },
        },
      }

      -- 创建用户命令
      vim.api.nvim_create_user_command('RunPython', function(opts)
        local args = opts.args
        if args == '' then
          args = vim.fn.expand '%'
        end
        require('overseer').run_template('python', { args = { args } })
      end, {
        nargs = '*',
        desc = 'Run Python file with Overseer',
      })

      vim.api.nvim_create_user_command('RunTest', function(opts)
        local args = opts.args
        if args == '' then
          local file = vim.fn.expand '%'
          if string.match(file, 'test_.*%.py$') or string.match(file, '.*_test%.py$') then
            args = file
          else
            args = '.'
          end
        end
        require('overseer').run_template('pytest', { args = { args, '-v' } })
      end, {
        nargs = '*',
        desc = 'Run tests with Overseer',
      })

      -- 智能运行
      vim.api.nvim_create_user_command('SmartRun', function()
        local file = vim.fn.expand '%:p'

        if string.match(file, 'test_.*%.py$') or string.match(file, '.*_test%.py$') then
          -- 运行测试
          require('overseer').run_template('pytest', { args = { file, '-v' } })
        elseif string.match(file, '%.py$') then
          -- 运行Python文件
          require('overseer').run_template('python', { args = { file } })
        else
          -- default运行项目测试
          require('overseer').run_template('pytest', { args = { '.', '-v' } })
        end
      end, {
        desc = 'Smart run based on file type',
      })

      -- 快捷键
      vim.keymap.set('n', '<leader>TS', '<cmd>SmartRun<CR>', { desc = 'Smart Run' })

      -- Marimo 快捷命令
      vim.api.nvim_create_user_command('MarimoEdit', function(opts)
        local args = opts.args
        if args == '' then
          local file = vim.fn.expand '%'
          if file ~= '' and string.match(file, '%.py$') then
            args = file
          end
        end
        require('overseer').run_template('marimo_edit', { args = args ~= '' and { args } or {} })
      end, {
        nargs = '?',
        desc = 'Edit with Marimo',
      })

      vim.api.nvim_create_user_command('MarimoRun', function(opts)
        local args = opts.args
        if args == '' then
          args = vim.fn.expand '%'
        end
        if args == '' or not string.match(args, '%.py$') then
          vim.notify('Please specify a Python file to run with Marimo', vim.log.levels.ERROR)
          return
        end
        require('overseer').run_template('marimo_run', { args = { args } })
      end, {
        nargs = '?',
        desc = 'Run with Marimo',
      })

      vim.api.nvim_create_user_command('MarimoNew', function()
        require('overseer').run_template('marimo_edit', { args = { '--new' } })
      end, {
        desc = 'Create new Marimo notebook',
      })

      -- 状态栏集成
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OverseerTaskStart',
        callback = function()
          -- 可以在状态栏显示任务状态
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'OverseerTaskComplete',
        callback = function()
          -- 任务完成时的处理
        end,
      })
    end,
  },
}
