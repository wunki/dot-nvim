local function toggle_files(path)
  local mf = require 'mini.files'
  if not mf.close() then
    mf.open(path)
  end
end

return {
  {
    'echasnovski/mini.nvim',
    lazy = false,
    keys = {
      {
        '<C-b>',
        function()
          toggle_files(vim.api.nvim_buf_get_name(0))
        end,
        desc = 'Toggle file explorer (current file)',
      },
      {
        '<leader>ft',
        function()
          toggle_files(vim.api.nvim_buf_get_name(0))
        end,
        desc = 'Find file in tree',
      },
      {
        '<leader>fm',
        function()
          toggle_files(vim.uv.cwd())
        end,
        desc = 'File explorer (cwd)',
      },
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
              if not status then
                return ''
              end
              local parts = {}
              if (status.added or 0) > 0 then
                table.insert(parts, '%#diffAdded#+' .. status.added .. '%*')
              end
              if (status.changed or 0) > 0 then
                table.insert(parts, '%#DiagnosticWarn#~' .. status.changed .. '%*')
              end
              if (status.removed or 0) > 0 then
                table.insert(parts, '%#diffRemoved#-' .. status.removed .. '%*')
              end
              return table.concat(parts, ' ')
            end)()
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = #vim.lsp.get_clients { bufnr = 0 } > 0 and '󰒋' or ''
            local devinfo = table.concat(
              vim.tbl_filter(function(s)
                return s ~= ''
              end, { diagnostics, lsp }),
              ' '
            )
            local filename = vim.fn.expand '%:.'
            local modified = vim.bo.modified and '●' or ''
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }
            local location = vim.fn.line '.' .. ':' .. vim.fn.col '.'

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
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.ai').setup {
        custom_textobjects = {
          f = require('mini.ai').gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
          c = require('mini.ai').gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
        },
      }
    end,
  },
}
