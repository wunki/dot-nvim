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
    end,
    init = function()
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {
        options = {
          dim_inactive = false,
        },
      }

      vim.cmd 'colorscheme github_dark_tritanopia'
    end,
  },
}
