local M = {}

function M.setup()
  -- clear highlights on search
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

  -- run the current line
  vim.keymap.set('n', '<space>x', function()
    vim.cmd '.lua'
    vim.notify('executed current line', 2)
  end, { desc = 'Execute current line as Lua' })

  -- run selection
  vim.keymap.set('v', '<space>x', ':lua<CR>', { desc = 'Execute selection as Lua' })

  -- run the current file
  vim.keymap.set('n', '<space><space>x', function()
    vim.cmd 'source %'
    vim.notify('sourced current file', 2)
  end, { desc = 'Source current file' })

  -- toggle line numbers
  vim.keymap.set('n', '<space>ul', function()
    vim.opt.number = not vim.o.number
  end, { desc = 'Toggle line numbers' })

  -- Register which-key groups
  local wk = require 'which-key'
  wk.add {
    { '<leader>x', desc = 'Execute Lua' },
    { '<leader>u', group = 'UI' },
    { '<leader>ul', desc = 'Toggle line numbers' },
  }
end

return M
