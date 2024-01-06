return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_y = {},
        lualine_z = { "mode" },
        lualine_x = {},
      },
    })
  end,
}
