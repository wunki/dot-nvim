return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    lazygit = { enabled = true },
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
  config = function(_, opts)
    require('snacks').setup(opts)
    local P = Snacks.picker

    vim.keymap.set('n', '<leader>ff', function() P.files() end, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fF', function() P.files { hidden = true, ignored = true } end, { desc = 'Find all files' })
    vim.keymap.set('n', '<leader>fc', function() P.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find config files' })
    vim.keymap.set('n', '<leader>fd', function() P.files { cwd = vim.fn.expand '~/code/dotfiles' } end, { desc = 'Find dotfiles' })
    vim.keymap.set('n', '<leader>fh', function() P.help() end, { desc = 'Find help tags' })
    vim.keymap.set('n', '<leader>fg', function() P.grep() end, { desc = 'Find by grep' })
    vim.keymap.set('n', '<leader>fs', function() P.colorschemes() end, { desc = 'Find colorscheme' })
    vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'LazyGit' })
  end,
}
