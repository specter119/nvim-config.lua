return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },

  -- use lazy.nvim keys 字段定义快捷键
  keys = {
    -- 代码操作 (使用 <leader>c* 命名空间)
    { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action' },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
    {
      '<leader>cf',
      function()
        vim.lsp.buf.format { async = true }
      end,
      desc = 'Format',
    },
    { '<leader>ct', vim.lsp.buf.type_definition, desc = 'Type Definition' },
    { '<leader>ch', vim.lsp.buf.hover, desc = 'Hover' },
    { '<leader>cs', vim.lsp.buf.signature_help, desc = 'Signature Help' },

    -- 工作区管理 (使用 <leader>cw* 子命名空间)
    { '<leader>cwa', vim.lsp.buf.add_workspace_folder, desc = 'Add Workspace Folder' },
    { '<leader>cwr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove Workspace Folder' },
    {
      '<leader>cwl',
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = 'List Workspace Folders',
    },

    -- diagnostic导航 (使用 <leader>d* 命名空间)
    { '<leader>de', vim.diagnostic.open_float, desc = 'Diagnostics Float' },
    { '<leader>dl', vim.diagnostic.setloclist, desc = 'Diagnostics List' },
    { '[d', vim.diagnostic.goto_prev, desc = 'Previous Diagnostic' },
    { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },

    -- 标准 LSP 导航快捷键
    { 'gd', vim.lsp.buf.definition, desc = 'Go to Definition' },
    { 'K', vim.lsp.buf.hover, desc = 'Hover' },
    { 'gi', vim.lsp.buf.implementation, desc = 'Go to Implementation' },
    { 'gr', vim.lsp.buf.references, desc = 'References' },
    { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Help' },
  },

  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    -- simplified on_attach 函数，快捷键由 lazy.nvim 管理
    local on_attach = function(client, bufnr)
      -- 仅保留必要的缓冲区设置
      -- 快捷键已通过 lazy.nvim keys 字段定义
    end

    -- LSP 增强能力
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configuration诊断显示
    vim.diagnostic.config {
      virtual_text = {
        prefix = '●',
        severity = vim.diagnostic.severity.ERROR,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        source = 'always',
        border = 'rounded',
      },
    }

    -- diagnostic符号
    local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- LSP 悬浮窗口样式
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })

    -- Mason-lspconfig 自动配置 - 数据科学和多语言开发
    mason_lspconfig.setup {
      ensure_installed = {
        -- core语言
        'lua_ls', -- Lua (Neovim 配置)
        'pyright', -- Python (主要语言)

        -- future learning语言
        'rust_analyzer', -- Rust
        'ts_ls', -- TypeScript
        'gopls', -- Go

        -- data science相关
        'marksman', -- Markdown (文档和笔记)
        'jsonls', -- JSON (配置文件)
        'yamlls', -- YAML (配置文件)
        'taplo', -- TOML (配置文件)
        'tinymist', -- Typst (文档生成) - 推荐的 Typst LSP

        -- optional Web 开发支持
        'html', -- HTML
        'cssls', -- CSS
      },
      automatic_installation = true,
    }

    -- default服务器配置
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- special服务器配置
    local server_configs = {
      -- Lua 配置 (Neovim 开发)
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },

      -- Python 配置 (数据科学主力)
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
      },

      -- Rust 配置
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = 'clippy',
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },

      -- TypeScript 配置
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },

      -- Go 配置
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },

      -- Tinymist 配置 (Typst LSP)
      tinymist = {
        settings = {
          exportPdf = 'onSave',
          outputPath = '$root/target/$dir/$name',
        },
      },
    }

    -- manual配置需要特殊设置的服务器
    for server_name, server_config in pairs(server_configs) do
      local config = vim.tbl_deep_extend('force', default_config, server_config)
      lspconfig[server_name].setup(config)
    end
  end,
}
