return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    -- LSP 键位映射
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      
      -- 跳转和查看
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      
      -- 工作区管理
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      
      -- 代码操作
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
      
      -- 诊断导航
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    end

    -- LSP 增强能力
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- 配置诊断显示
    vim.diagnostic.config({
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
    })

    -- 诊断符号
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
    mason_lspconfig.setup({
      ensure_installed = {
        -- 核心语言
        'lua_ls',           -- Lua (Neovim 配置)
        'pyright',          -- Python (主要语言)
        
        -- 未来学习的语言
        'rust_analyzer',    -- Rust
        'ts_ls',           -- TypeScript
        'gopls',           -- Go
        
        -- 数据科学相关
        'marksman',        -- Markdown (文档和笔记)
        'jsonls',          -- JSON (配置文件)
        'yamlls',          -- YAML (配置文件)
        'taplo',           -- TOML (配置文件)
        'tinymist',        -- Typst (文档生成) - 推荐的 Typst LSP
        
        -- 可选的 Web 开发支持
        'html',            -- HTML
        'cssls',           -- CSS
      },
      automatic_installation = true,
    })

    -- 默认服务器配置
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- 特殊服务器配置
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

    -- 手动配置需要特殊设置的服务器
    for server_name, server_config in pairs(server_configs) do
      local config = vim.tbl_deep_extend('force', default_config, server_config)
      lspconfig[server_name].setup(config)
    end
  end,
}