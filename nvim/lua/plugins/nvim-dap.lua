return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },

    -- use <leader>d* Debug/Diagnostics namespace
    keys = {
      -- Debug controls
      { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Toggle Breakpoint' },
      { '<leader>dB', '<cmd>DapSetBreakpoint<CR>', desc = 'Set Breakpoint' },
      { '<leader>dc', '<cmd>DapContinue<CR>', desc = 'Continue' },
      { '<leader>dC', '<cmd>DapRunToCursor<CR>', desc = 'Run to Cursor' },
      { '<leader>dg', '<cmd>DapGoto<CR>', desc = 'Go to line (no execute)' },
      { '<leader>di', '<cmd>DapStepInto<CR>', desc = 'Step Into' },
      { '<leader>dj', '<cmd>DapDown<CR>', desc = 'Down' },
      { '<leader>dk', '<cmd>DapUp<CR>', desc = 'Up' },
      { '<leader>dl', '<cmd>DapStepInto<CR>', desc = 'Step Into' },
      { '<leader>do', '<cmd>DapStepOut<CR>', desc = 'Step Out' },
      { '<leader>dO', '<cmd>DapStepOver<CR>', desc = 'Step Over' },
      { '<leader>dp', '<cmd>DapPause<CR>', desc = 'Pause' },
      { '<leader>dr', '<cmd>DapToggleRepl<CR>', desc = 'Toggle REPL' },
      { '<leader>ds', '<cmd>DapSessionStart<CR>', desc = 'Start Session' },
      { '<leader>dt', '<cmd>DapTerminate<CR>', desc = 'Terminate' },
      { '<leader>dw', '<cmd>DapShowLog<CR>', desc = 'Show Log' },
      { '<leader>dx', '<cmd>DapTerminate<CR>', desc = 'Terminate' },
      { '<leader>dz', '<cmd>DapDisconnect<CR>', desc = 'Disconnect' },
    },

    config = function()
      local dap = require 'dap'

      -- Set breakpoint icons
      vim.fn.sign_define(
        'DapBreakpoint',
        { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
      )
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = '🔶', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
      )
      vim.fn.sign_define(
        'DapBreakpointRejected',
        { text = '🔸', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
      )
      vim.fn.sign_define(
        'DapLogPoint',
        { text = '🔷', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' }
      )
      vim.fn.sign_define(
        'DapStopped',
        { text = '➡️', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' }
      )
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },

    keys = {
      { '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', desc = 'Toggle DAP UI' },
      { '<leader>de', '<cmd>lua require("dapui").eval()<CR>', desc = 'Evaluate Expression' },
      { '<leader>dE', '<cmd>lua require("dapui").eval(vim.fn.input("Expression: "))<CR>', desc = 'Evaluate Input' },
    },

    config = function()
      local dapui = require 'dapui'

      dapui.setup {
        controls = {
          element = 'repl',
          enabled = true,
          icons = {
            disconnect = '',
            pause = '',
            play = '',
            run_last = '',
            step_back = '',
            step_into = '',
            step_out = '',
            step_over = '',
            terminate = '',
          },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        force_buffers = true,
        icons = {
          collapsed = '',
          current_frame = '',
          expanded = '',
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            position = 'left',
            size = 40,
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            position = 'bottom',
            size = 10,
          },
        },
        mappings = {
          edit = 'e',
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          repl = 'r',
          toggle = 't',
        },
        render = {
          indent = 1,
          max_value_lines = 100,
        },
      }

      -- Automatically open/close DAP UI
      local dap = require 'dap'
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },

    keys = {
      { '<leader>dPt', '<cmd>lua require("dap-python").test_method()<CR>', desc = 'Test Method' },
      { '<leader>dPc', '<cmd>lua require("dap-python").test_class()<CR>', desc = 'Test Class' },
      { '<leader>dPs', '<cmd>lua require("dap-python").debug_selection()<CR>', desc = 'Debug Selection' },
    },

    config = function()
      -- Mason installed debugpy path
      local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'

      -- If mason path doesn't exist, use system Python
      if vim.fn.executable(mason_path) == 1 then
        require('dap-python').setup(mason_path)
      else
        require('dap-python').setup 'python3'
      end

      -- Add Python debug configuration
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Launch file with arguments',
        program = '${file}',
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
        pythonPath = function()
          local venv_path = os.getenv 'VIRTUAL_ENV'
          if venv_path then
            return venv_path .. '/bin/python'
          end
          return '/usr/bin/python3'
        end,
      })

      -- Add Django debug configuration
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = '${workspaceFolder}/manage.py',
        args = { 'runserver', '--noreload' },
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
        pythonPath = function()
          local venv_path = os.getenv 'VIRTUAL_ENV'
          if venv_path then
            return venv_path .. '/bin/python'
          end
          return '/usr/bin/python3'
        end,
      })

      -- Add Flask debug configuration
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Flask',
        module = 'flask',
        env = {
          FLASK_APP = '${workspaceFolder}/app.py',
          FLASK_ENV = 'development',
        },
        args = { 'run', '--no-debugger', '--no-reload' },
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
        pythonPath = function()
          local venv_path = os.getenv 'VIRTUAL_ENV'
          if venv_path then
            return venv_path .. '/bin/python'
          end
          return '/usr/bin/python3'
        end,
      })

      -- Add Pytest debug configuration
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Pytest',
        module = 'pytest',
        args = { '${file}', '-v' },
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
        pythonPath = function()
          local venv_path = os.getenv 'VIRTUAL_ENV'
          if venv_path then
            return venv_path .. '/bin/python'
          end
          return '/usr/bin/python3'
        end,
      })
    end,
  },
}
