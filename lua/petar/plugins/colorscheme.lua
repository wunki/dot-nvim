local config = function()
  require("kanagawa").setup({
    compile = false,
    dimInactive = true,
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  })
  vim.cmd.colorscheme("kanagawa")
end

return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = config,
  },
}
