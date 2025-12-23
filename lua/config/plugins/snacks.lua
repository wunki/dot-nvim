return {
  'folke/snacks.nvim',
  event = 'VimEnter',
  opts = {
    lazygit = { enabled = true },
    picker = {
      prompt = ' ',
      ui_select = true,
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        filename_bonus = true,
        frecency = true,
        sort_empty = true,
      },
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)
    local P = Snacks.picker

    -- find git files (includes files in hidden directories like .github)
    vim.keymap.set('n', '<leader>ff', function()
      P.git_files()
    end, { desc = 'Find git files' })

    -- find all files (ignores hidden directories)
    vim.keymap.set('n', '<leader>fF', function()
      P.files { matcher = { frecency = true, sort_empty = true } }
    end, { desc = 'Find all files' })

    -- find my neovim config files
    vim.keymap.set('n', '<leader>fc', function()
      P.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Find config files' })

    -- find my dotfiles
    vim.keymap.set('n', '<leader>fd', function()
      P.files { cwd = vim.fn.expand '~/code/dotfiles' }
    end, { desc = 'Find dotfiles' })

    -- help tags
    vim.keymap.set('n', '<leader>fh', function()
      P.help()
    end, { desc = 'Find help tags' })

    -- grep
    vim.keymap.set('n', '<leader>fg', function()
      P.grep()
    end, { desc = 'Find by grep' })

    -- colorscheme picker
    vim.keymap.set('n', '<leader>fs', function()
      P.colorschemes()
    end, { desc = 'Find colorscheme' })

    -- lazygit
    vim.keymap.set('n', '<leader>gg', function()
      Snacks.lazygit()
    end, { desc = 'LazyGit' })
  end,
}
