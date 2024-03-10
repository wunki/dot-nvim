return {
  "julienvincent/nvim-paredit",
  config = function()
    require("nvim-paredit").setup()
  end,
  keys = {
    { "<localleader>daf", function() require("nvim-paredit").api.delete_form() end, desc = "Delete the current form" },
    { "<localleader>dif", function() require("nvim-paredit").api.delete_in_form() end, desc = "Delete in the current form" },
    { "<localleader>daF", function() require("nvim-paredit").api.delete_top_level_form() end, desc = "Delete the the level form" },
    { "<localleader>diF", function() require("nvim-paredit").api.delete_in_top_level_form() end, desc = "Delete in the top level form" },
  },
}
