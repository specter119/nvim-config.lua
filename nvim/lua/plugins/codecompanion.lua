return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'j-hui/fidget.nvim', -- Display status
    'ravitemer/codecompanion-history.nvim', -- Save and load conversation history
    {
      'ravitemer/mcphub.nvim', -- Manage MCP servers
      cmd = 'MCPHub',
      build = 'bundled_build.lua',
      opts = {
        use_bundled_binary = true,
      },
    },
    {
      'Davidyz/VectorCode', -- Index and search code in your repositories
      version = '*',
      build = 'uv tool install vectorcode',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      'HakonHarnes/img-clip.nvim', -- Share images with the chat buffer
      event = 'VeryLazy',
      cmd = 'PasteImage',
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = '[Image]($FILE_PATH)',
            use_absolute_path = true,
          },
        },
      },
    },
  },
  opts = {
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = 'gh',
          save_chat_keymap = 'sc',
          auto_save = false,
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = 'snacks',
          enable_logging = false,
          dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion-history',
        },
      },
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      vectorcode = {
        opts = {
          add_tool = true,
        },
      },
    },

    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'ollama',
          schema = {
            model = {
              default = 'qwen3:14b',
            },
            num_ctx = {
              default = 20000,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
    },
  },
}
