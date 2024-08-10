return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = {},
        lualine_y = {},
        lualine_z = { 'location' },
        lualine_x = {},
      },
    }
  end,
}
