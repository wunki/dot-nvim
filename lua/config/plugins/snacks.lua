return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    gitbrowse = { enabled = true },
    lazygit = { enabled = true },
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
      win = {
        width = 100,
        minimal = true,
        backdrop = { transparent = false },
        wo = {
          wrap = true,
          linebreak = true,
        },
      },
    },
    picker = {
      prompt = ' ',
      ui_select = true,
      matcher = { frecency = true, sort_empty = true },
      sources = {
        select = {
          matcher = { frecency = false, sort_empty = false },
          sort = { fields = { 'idx' } },
        },
      },
    },
  },
  keys = {
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find files' },
    { '<leader>fF', function() Snacks.picker.files { hidden = true, ignored = true } end, desc = 'Find all files' },
    { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find config files' },
    { '<leader>fd', function() Snacks.picker.files { cwd = vim.fn.expand '~/code/dotfiles' } end, desc = 'Find dotfiles' },
    { '<leader>fh', function() Snacks.picker.help() end, desc = 'Find help tags' },
    { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Find by grep' },
    { '<leader>fw', function() Snacks.picker.grep_word() end, desc = 'Find word under cursor', mode = { 'n', 'x' } },
    { '<leader>fs', function() Snacks.picker.colorschemes() end, desc = 'Find colorscheme' },
    { '<leader>gy', function() Snacks.gitbrowse() end, desc = 'Open in GitHub', mode = { 'n', 'v' } },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' },
    { '<leader>uz', function() Snacks.zen() end, desc = 'Toggle Zen mode' },
  },
}
