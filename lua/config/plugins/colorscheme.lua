return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'latte',
      no_italic = true,
      color_overrides = {
        -- make it a little bit darker
        mocha = {
          base = '#181825',
          mantle = '#11111b',
          crust = '#08080f',
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      -- vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {},
    config = function(_, opts)
      require('nightfox').setup(opts)
      vim.cmd.colorscheme 'dayfox'
    end,
  }
}
