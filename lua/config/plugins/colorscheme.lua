return {
  {
    'sainnhe/gruvbox-material',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_enable_bold = false
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.g.gruvbox_material_visual = 'green background'
      vim.g.gruvbox_material_sign_column_background = 'none'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require('github-theme').setup(opts)
      vim.cmd.colorscheme 'github_dark_tritanopia'
    end,
  },
  {
    'Shatur/neovim-ayu',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      mirage = false,
    },
    config = function(_, opts)
      require('ayu').setup(opts)
      vim.cmd.colorscheme 'ayu-dark'
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    enabled = true,
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones = {
        solid_line_nr = true,
        solid_vert_split = true,
        lightness = 'bright',
      }
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      tweak_background = {
        normal = 'none',
      },
    },
    config = function(_, opts)
      local lackluster = require 'lackluster'
      opts.tweak_background.normal = lackluster.color.gray1
      lackluster.setup(opts)
      vim.cmd.colorscheme 'lackluster'
    end,
  },

  {
    dir = '/Users/petar/Code/finde.nvim',
    name = 'finde',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require('finde').setup {}
      vim.cmd.colorscheme 'finde'
    end,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'finde'
        vim.opt.background = 'dark'
      end,
      set_light_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'zenbones'
        vim.opt.background = 'light'
      end,
    },
  },
}
