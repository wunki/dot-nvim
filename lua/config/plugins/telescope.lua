return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-frecency.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = '• ',
        color_devicons = false,
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        frecency = {
          show_filter_column = false,
        },
      },
    }

    telescope.load_extension 'frecency'

    -- find files in current directory (sorted by recent use)
    vim.keymap.set('n', '<space>ff', function()
      telescope.extensions.frecency.frecency { workspace = 'CWD' }
    end)

    -- find my neovim config files
    vim.keymap.set('n', '<space>fc', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
      }
    end)

    -- find my dotfiles
    vim.keymap.set('n', '<space>fd', function()
      builtin.find_files {
        cwd = vim.fn.expand '~/code/dotfiles',
      }
    end)

    -- colorschemes
    vim.keymap.set('n', '<space>fh', builtin.colorscheme)

    -- help tags
    vim.keymap.set('n', '<space>fh', builtin.help_tags)

    -- grep
    vim.keymap.set('n', '<space>fg', builtin.live_grep)
  end,
}
