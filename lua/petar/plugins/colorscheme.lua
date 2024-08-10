local config = function()
  require('kanagawa').setup {
    compile = false,
    dimInactive = false,
    colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
  }
end

return {
  {
    'AlexvZyl/nordic.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic'.load()
    end
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd("colorscheme kanagawa-dragon")
    end,
    config = config,
  },
  {
    "sho-87/kanagawa-paper.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd("colorscheme kanagawa-paper")
    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
  {
    "neanias/everforest-nvim",
    enabled = false,
    version = false,
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme everforest]])
    end,
    config = function()
      require("everforest").setup({
        background = "hard"
      })
    end,
  }
}
