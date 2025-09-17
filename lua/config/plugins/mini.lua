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
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 1000 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp_icon = (function()
              local clients = {}
              if vim.lsp.get_clients then
                clients = vim.lsp.get_clients { bufnr = 0 }
              else
                clients = vim.lsp.get_active_clients { bufnr = 0 }
              end
              return (clients and #clients > 0) and '⚙' or ''
            end)()
            local devinfo = table.concat(vim.tbl_filter(function(s)
              return s ~= nil and s ~= ''
            end, { git, diff, diagnostics, lsp_icon }), ' ')
            local filename = MiniStatusline.section_filename { trunc_width = 140 }

            local location = tostring(vim.fn.line '.')

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { devinfo } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
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
