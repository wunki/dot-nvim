return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
      defaults = {
        prompt_prefix = ' ',
        color_devicons = false,
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    }

    -- find files in current directory
    vim.keymap.set('n', '<space>ff', builtin.find_files)

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

    -- help tags
    vim.keymap.set('n', '<space>fh', builtin.help_tags)

    -- grep
    vim.keymap.set('n', '<space>fg', builtin.live_grep)
  end,
}
