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
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = { add = '┃', change = '┃', delete = '▁' },
        },
      }

      local function set_minidiff_highlights()
        vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { link = 'Added' })
        vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { link = 'Changed' })
        vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { link = 'Removed' })
      end
      set_minidiff_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('petar-minidiff-highlights', { clear = true }),
        callback = set_minidiff_highlights,
      })

      require('mini.git').setup()

      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          { mode = { 'n', 'x' }, keys = '<Leader>' },
        },
        clues = {
          { mode = { 'n', 'x' }, keys = '<Leader>a', desc = 'AI' },
          { mode = { 'n', 'x' }, keys = '<Leader>f', desc = 'Find' },
          { mode = { 'n', 'x' }, keys = '<Leader>g', desc = 'Git' },
          { mode = { 'n', 'x' }, keys = '<Leader>h', desc = 'Harpoon' },
          { mode = { 'n', 'x' }, keys = '<Leader>l', desc = 'LSP' },
          { mode = { 'n', 'x' }, keys = '<Leader>o', desc = 'Opencode' },
          { mode = { 'n', 'x' }, keys = '<Leader>u', desc = 'UI' },
        },
        window = {
          delay = 300,
        },
      }

      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = false,
        content = {
          active = function()
            local git = vim.b.minigit_summary or {}
            local branch = git.head_name or ''
            local diff = (function()
              local status = vim.b.minidiff_summary
              if not status or not status.add then
                return ''
              end
              local parts = {}
              if (status.add or 0) > 0 then
                table.insert(parts, '%#diffAdded#+' .. status.add .. '%*')
              end
              if (status.change or 0) > 0 then
                table.insert(parts, '%#DiagnosticWarn#~' .. status.change .. '%*')
              end
              if (status.delete or 0) > 0 then
                table.insert(parts, '%#diffRemoved#-' .. status.delete .. '%*')
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
