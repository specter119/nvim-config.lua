return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      sort_by = 'case_sensitive',
      view = {
        width = 30,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = 'name',
        root_folder_modifier = ':~',
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            bottom = '─',
            none = ' ',
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = 'before',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = '',
            symlink = '',
            bookmark = '',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', '.cache' },
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
      },
    })
    
    -- 键位映射
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus file tree' })
    vim.keymap.set('n', '<leader>E', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })
    
    -- 自动关闭
    vim.api.nvim_create_autocmd('BufEnter', {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match('NvimTree_') ~= nil then
          vim.cmd('quit')
        end
      end,
    })
  end,
}