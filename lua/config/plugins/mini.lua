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
        use_icons = false,
      }

      -- files
      local files = require 'mini.files'
      files.setup()

      -- comment
      local comment = require 'mini.comment'
      comment.setup()
    end,
  },
}
