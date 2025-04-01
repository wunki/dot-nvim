return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
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
    'rose-pine/neovim',
    enabled = false,
    name = 'rose-pine',
    config = function()
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    opts = {},
    config = function(_, opts)
      require('nightfox').setup(opts)
      vim.cmd.colorscheme 'dayfox'
    end,
  },
  {
    'xero/miasma.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme miasma'
    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = false
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.g.gruvbox_material_visual = 'green background'
    end,
    init = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'olivercederborg/poimandres.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        -- options here?
      }
    end,
    init = function()
      vim.cmd 'colorscheme poimandres'
    end,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd 'colorscheme tokyonight-night'
    end,
  },
  {
    'ficcdaf/ashen.nvim',
    enabled = true,
    tag = 'v0.11.0',
    lazy = false,
    priority = 1000,
    opts = {
      -- your settings here
    },
    init = function()
      vim.cmd 'colorscheme ashen'
    end,
  },
}
