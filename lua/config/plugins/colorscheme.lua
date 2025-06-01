return {
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_enable_bold = false
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.g.gruvbox_material_visual = 'green background'
      vim.g.gruvbox_material_sign_column_background = 'none'
    end,
    init = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    enabled = true,
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
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
    init = function()
      local lackluster = require 'lackluster'
      local color = lackluster.color
      lackluster.setup {
        tweak_background = {
          normal = color.gray1,
        },
      }
      vim.cmd.colorscheme 'lackluster-hack'
    end,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd 'colorscheme gruvbox-material'
        vim.cmd 'set bg=dark'
      end,
      set_light_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd 'colorscheme zenbones'
        vim.cmd 'set bg=light'
      end,
    },
  },
  { 'datsfilipe/vesper.nvim' },
}
