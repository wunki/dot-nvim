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
      vim.g.gruvbox_material_sign_column_background = 'grey'
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    enabled = true,
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'light'
      vim.opt.termguicolors = true
      vim.g.zenbones = {
        solid_line_nr = true,
        solid_vert_split = true,
        lightness = 'bright',
      }
    end,
  },
  {
    'datsfilipe/vesper.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.opt.termguicolors = true
      require('vesper').setup {
        transparent = false, -- Boolean: Sets the background to transparent
        italics = {
          comments = true, -- Boolean: Italicizes comments
          keywords = false, -- Boolean: Italicizes keywords
          functions = false, -- Boolean: Italicizes functions
          strings = true, -- Boolean: Italicizes strings
          variables = false, -- Boolean: Italicizes variables
        },
        overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
        palette_overrides = {},
      }
      vim.cmd 'colorscheme vesper'
    end,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd 'colorscheme vesper'
        vim.cmd 'set bg=dark'
      end,
      set_light_mode = function()
        vim.cmd 'colorscheme zenbones'
        vim.cmd 'set bg=light'
      end,
    },
  },
}
