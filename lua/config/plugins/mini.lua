return {
  {
    'echasnovski/mini.nvim',
    keys = {
      {
        '<leader>fm',
        function()
          require('mini.files').open()
        end,
        desc = 'Open MiniFiles',
      },
    },

    config = function()
      -- statusline
      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = true,
      }

      -- files
      local files = require 'mini.files'
      files.setup()
    end,
  },
}
