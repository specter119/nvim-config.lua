return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },

  -- Keymap restructuring using namespace rules
  keys = {
    -- <leader>f* = Find/Files namespace
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Live Grep' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Buffers' },
    { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = 'Recent Files' },
    { '<leader>fs', '<cmd>Telescope treesitter<CR>', desc = 'Symbols' },
    { '<leader>fc', '<cmd>Telescope commands<CR>', desc = 'Commands' },

    -- <leader>h* = Help namespace
    { '<leader>hh', '<cmd>Telescope help_tags<CR>', desc = 'Help Tags' },
    { '<leader>hm', '<cmd>Telescope man_pages<CR>', desc = 'Man Pages' },
    { '<leader>hk', '<cmd>Telescope keymaps<CR>', desc = 'Keymaps' },
    { '<leader>ho', '<cmd>Telescope vim_options<CR>', desc = 'Options' },

    -- <leader>g* = Git namespace
    { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Git Commits' },
    { '<leader>gC', '<cmd>Telescope git_bcommits<CR>', desc = 'Buffer Commits' },
    { '<leader>gb', '<cmd>Telescope git_branches<CR>', desc = 'Git Branches' },
    { '<leader>gS', '<cmd>Telescope git_status<CR>', desc = 'Git Status' },
    { '<leader>gt', '<cmd>Telescope git_stash<CR>', desc = 'Git Stash' },

    -- <leader>d* = Debug/Diagnostics namespace
    { '<leader>dd', '<cmd>Telescope diagnostics<CR>', desc = 'Diagnostics' },
    { '<leader>dq', '<cmd>Telescope quickfix<CR>', desc = 'Quickfix' },
    { '<leader>dl', '<cmd>Telescope loclist<CR>', desc = 'Location List' },

    -- Preserved classic keymaps
    { '<C-p>', '<cmd>Telescope git_files<CR>', desc = 'Git Files' },
  },

  config = function()
    require('telescope').setup {
      defaults = {
        -- Performance optimization
        file_ignore_patterns = {
          '%.git/',
          'node_modules/',
          '%.pyc',
          '__pycache__/',
          '%.o',
          '%.so',
          '%.zip',
          '%.tar.gz',
          '%.jpg',
          '%.png',
        },

        -- Layout configuration
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        -- Appearance configuration
        prompt_prefix = '🔍 ',
        selection_caret = '➤ ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',

        -- Search configuration
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        -- Mapping configuration
        mappings = {
          i = {
            ['<C-n>'] = require('telescope.actions').move_selection_next,
            ['<C-p>'] = require('telescope.actions').move_selection_previous,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-c>'] = require('telescope.actions').close,
            ['<Down>'] = require('telescope.actions').move_selection_next,
            ['<Up>'] = require('telescope.actions').move_selection_previous,
            ['<CR>'] = require('telescope.actions').select_default,
            ['<C-x>'] = require('telescope.actions').select_horizontal,
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
          },
          n = {
            ['<esc>'] = require('telescope.actions').close,
            ['<CR>'] = require('telescope.actions').select_default,
            ['<C-x>'] = require('telescope.actions').select_horizontal,
            ['<C-v>'] = require('telescope.actions').select_vertical,
            ['<C-t>'] = require('telescope.actions').select_tab,
            ['j'] = require('telescope.actions').move_selection_next,
            ['k'] = require('telescope.actions').move_selection_previous,
            ['H'] = require('telescope.actions').move_to_top,
            ['M'] = require('telescope.actions').move_to_middle,
            ['L'] = require('telescope.actions').move_to_bottom,
            ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
            ['gg'] = require('telescope.actions').move_to_top,
            ['G'] = require('telescope.actions').move_to_bottom,
          },
        },
      },

      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
          theme = 'dropdown',
        },
        live_grep = {
          additional_args = function(opts)
            return { '--hidden' }
          end,
        },
        buffers = {
          theme = 'dropdown',
          previewer = false,
          initial_mode = 'normal',
        },
        help_tags = {
          theme = 'ivy',
        },
        git_files = {
          theme = 'dropdown',
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }

    -- Load fzf extension
    require('telescope').load_extension 'fzf'
  end,
}
