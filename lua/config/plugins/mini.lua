return {
  {
    'echasnovski/mini.nvim',
    keys = {
      { '<leader>fm', function() require('mini.files').open() end, desc = 'Open MiniFiles' },
    },
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = false,
        content = {
          active = function()
            local branch = vim.b.gitsigns_head or ''
            local diff = (function()
              local status = vim.b.gitsigns_status_dict
              if not status then return '' end
              local parts = {}
              if (status.added or 0) > 0 then table.insert(parts, '%#diffAdded#+' .. status.added .. '%*') end
              if (status.changed or 0) > 0 then table.insert(parts, '%#DiagnosticWarn#~' .. status.changed .. '%*') end
              if (status.removed or 0) > 0 then table.insert(parts, '%#diffRemoved#-' .. status.removed .. '%*') end
              return table.concat(parts, ' ')
            end)()
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = #vim.lsp.get_clients { bufnr = 0 } > 0 and '󰒋' or ''
            local devinfo = table.concat(vim.tbl_filter(function(s) return s ~= '' end, { diagnostics, lsp }), ' ')
            local filename = vim.fn.expand '%:.'
            local modified = vim.bo.modified and '●' or ''
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }
            local location = vim.fn.line('.') .. ':' .. vim.fn.col('.')

            return MiniStatusline.combine_groups {
              devinfo ~= '' and { hl = 'MiniStatuslineDevinfo', strings = { devinfo } } or '',
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename, modified } },
              '%=',
              search ~= '' and { hl = 'MiniStatuslineFileinfo', strings = { search } } or '',
              diff ~= '' and { strings = { diff } } or '',
              branch ~= '' and { hl = 'MiniStatuslineModeInsert', strings = { branch } } or '',
              { hl = 'MiniStatuslineDevinfo', strings = { location } },
            }
          end,
        },
      }

      require('mini.files').setup()
      require('mini.comment').setup()
    end,
  },
}
