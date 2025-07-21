return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },

  -- use lazy.nvim keys field to define keymaps
  keys = {
    -- Code actions (using <leader>c* namespace)
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

    -- Workspace management (using <leader>cw* sub-namespace)
    { '<leader>cwa', vim.lsp.buf.add_workspace_folder, desc = 'Add Workspace Folder' },
    { '<leader>cwr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove Workspace Folder' },
    {
      '<leader>cwl',
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = 'List Workspace Folders',
    },

    -- Diagnostic navigation (using <leader>d* namespace)
    { '<leader>de', vim.diagnostic.open_float, desc = 'Diagnostics Float' },
    { '<leader>dl', vim.diagnostic.setloclist, desc = 'Diagnostics List' },
    { '[d', vim.diagnostic.goto_prev, desc = 'Previous Diagnostic' },
    { ']d', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },

    -- Standard LSP navigation keymaps
    { 'gd', vim.lsp.buf.definition, desc = 'Go to Definition' },
    { 'K', vim.lsp.buf.hover, desc = 'Hover' },
    { 'gi', vim.lsp.buf.implementation, desc = 'Go to Implementation' },
    { '<leader>cR', vim.lsp.buf.references, desc = 'References' },
    { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Help' },
  },

  config = function()
    local lspconfig = require 'lspconfig'
    local mason_lspconfig = require 'mason-lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    -- simplified on_attach function, keymaps managed by lazy.nvim
    local on_attach = function(client, bufnr)
      -- Only keep necessary buffer settings
      -- Keymaps already defined through lazy.nvim keys field
    end

    -- LSP enhanced capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostic display
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

    -- Diagnostic symbols
    local signs = { Error = '󰅚 ', Warn = '󰀪 ', Hint = '󰌶 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- LSP floating window style
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })

    -- Mason-lspconfig automatic configuration - data science and multi-language development
    mason_lspconfig.setup {
      ensure_installed = {
        -- core languages
        'lua_ls', -- Lua (Neovim configuration)
        'pyright', -- Python (primary language)
        'fortls', -- Fortran (ABAQUS user subroutines)

        -- future learning languages
        'rust_analyzer', -- Rust
        'ts_ls', -- TypeScript
        'gopls', -- Go

        -- data science related
        'marksman', -- Markdown (documentation and notes)
        'jsonls', -- JSON (config files)
        'yamlls', -- YAML (config files)
        'taplo', -- TOML (config files)
        'tinymist', -- Typst (document generation) - recommended Typst LSP

        -- optional Web development support
        'html', -- HTML
        'cssls', -- CSS
      },
      automatic_installation = true,
    }

    -- default server configuration
    local default_config = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- special server configurations
    local server_configs = {
      -- Lua configuration (Neovim development)
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

      -- Python configuration (data science primary)
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

      -- Fortran configuration (ABAQUS user subroutines development)
      fortls = {
        settings = {
          fortls = {
            nthreads = 1,
            use_signature_help = true,
            use_hover_for_signature = true,
            hover_signature = true,
            hover_language = 'fortran',
            -- include_dirs = {
            --   '/usr/include',
            --   -- ABAQUS include directories can be adjusted based on installation location
            -- },
            pp_suffixes = { '.F', '.F90', '.f90', '.f95', '.f03', '.f08' },
            lowercase_intrinsics = false,
            debug_log = false,
          },
        },
      },

      -- Rust configuration
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

      -- TypeScript configuration
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

      -- Go configuration
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

      -- Tinymist configuration (Typst LSP)
      tinymist = {
        settings = {
          exportPdf = 'onSave',
          outputPath = '$root/target/$dir/$name',
        },
      },
    }

    -- Manual configuration for servers requiring special settings
    for server_name, server_config in pairs(server_configs) do
      local config = vim.tbl_deep_extend('force', default_config, server_config)
      lspconfig[server_name].setup(config)
    end
  end,
}
