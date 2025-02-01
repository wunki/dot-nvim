return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  opts = {
    defaults = {
      header = false,     -- don't show header
      file_icons = false, -- don't use any file icons
    },
  },
  config = function(_, opts)
    require('fzf-lua').setup(opts)

    ---
    --- to check which commands are available, run the `FzfLua builtin' command.
    ---
    --- find files in current directory
    vim.keymap.set('n', '<space>ff', require('fzf-lua').git_files)

    --- find my neovim config files
    vim.keymap.set('n', '<space>fc', function()
      require('fzf-lua').files {
        cwd = vim.fn.stdpath 'config',
      }
    end)

    --- find my dotfiles
    vim.keymap.set('n', '<space>fd', function()
      require('fzf-lua').files {
        cwd = vim.fn.expand '~/code/dotfiles',
      }
    end)

    --- help tags
    vim.keymap.set('n', '<space>fh', require('fzf-lua').help_tags)

    --- grep
    vim.keymap.set('n', '<space>fg', require('fzf-lua').live_grep)
  end,
}
