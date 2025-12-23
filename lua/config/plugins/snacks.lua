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
    vim.keymap.set('n', '<space>ff', function()
      P.git_files()
    end, { desc = 'Find git files' })

    -- find all files (ignores hidden directories)
    vim.keymap.set('n', '<space>fF', function()
      P.files { matcher = { frecency = true, sort_empty = true } }
    end, { desc = 'Find all files' })

    -- find my neovim config files
    vim.keymap.set('n', '<space>fc', function()
      P.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Find config files' })

    -- find my dotfiles
    vim.keymap.set('n', '<space>fd', function()
      P.files { cwd = vim.fn.expand '~/code/dotfiles' }
    end, { desc = 'Find dotfiles' })

    -- help tags
    vim.keymap.set('n', '<space>fh', function()
      P.help()
    end, { desc = 'Help tags' })

    -- grep
    vim.keymap.set('n', '<space>fg', function()
      P.grep()
    end, { desc = 'Live grep' })

    -- colorscheme picker
    vim.keymap.set('n', '<space>fcs', function()
      P.colorschemes()
    end, { desc = 'Pick colorscheme' })

    -- lazygit
    vim.keymap.set('n', '<leader>gl', function()
      Snacks.lazygit()
    end, { desc = 'LazyGit' })
  end,
}
