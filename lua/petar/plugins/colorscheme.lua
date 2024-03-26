local config = function()
  require('kanagawa').setup {
    compile = false,
    dimInactive = false,
    colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
  }
end

return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd("colorscheme kanagawa")
    end,
    config = config,
  },
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    lazy = false,
    init = function()
      -- vim.cmd("colorscheme gruvbox-material")
    end,
  },
}
