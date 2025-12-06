return {
  {
    dir = '/Users/petar/Code/finde.nvim',
    name = 'finde',
    lazy = false,
    priority = 1000,
    config = function()
      require('finde').setup {}
      vim.cmd.colorscheme 'finde'
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
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
