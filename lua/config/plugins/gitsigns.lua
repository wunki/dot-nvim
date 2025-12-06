return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}
