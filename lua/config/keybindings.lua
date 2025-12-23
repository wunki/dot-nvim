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
    local enabled = not vim.o.number
    vim.opt.number = enabled
    vim.opt.relativenumber = enabled
  end, { desc = 'Toggle line numbers' })

  -- toggle statusline
  vim.keymap.set('n', '<space>ub', function()
    vim.o.laststatus = vim.o.laststatus == 0 and 2 or 0
  end, { desc = 'Toggle statusline' })

  -- switch colorschemes
  vim.keymap.set('n', '<space>us', function()
    if vim.g.colors_name == 'zenbones' then
      vim.cmd 'highlight clear'
      vim.cmd 'colorscheme finde'
      vim.cmd 'set bg=dark'
    else
      vim.cmd 'highlight clear'
      vim.cmd 'colorscheme zenbones'
      vim.cmd 'set bg=light'
    end
  end, { desc = 'Toggle colorscheme (dark|light)' })

  -- show attached LSP clients
  vim.keymap.set('n', '<leader>li', function()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    if #clients == 0 then
      vim.notify('No LSP attached', vim.log.levels.WARN)
    else
      for _, c in ipairs(clients) do
        vim.notify(c.name .. ' (id: ' .. c.id .. ')', vim.log.levels.INFO)
      end
    end
  end, { desc = 'Show attached LSP clients' })

  -- Register which-key groups
  local wk = require 'which-key'
  wk.add {
    { '<leader>u', group = 'UI' },
    { '<leader>l', group = 'LSP/Lazy' },
  }
end

return M
