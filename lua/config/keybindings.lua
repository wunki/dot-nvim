local M = {}

function M.setup()
  -- clear highlights on search
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

  -- run the current line
  vim.keymap.set('n', '<leader>x', function()
    vim.cmd '.lua'
    vim.notify('executed current line', 2)
  end, { desc = 'Execute current line as Lua' })

  -- run selection
  vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Execute selection as Lua' })

  -- run the current file
  vim.keymap.set('n', '<leader>X', function()
    vim.cmd 'source %'
    vim.notify('sourced current file', 2)
  end, { desc = 'Source current file' })

  -- reload entire config
  vim.keymap.set('n', '<leader>R', function()
    -- clear config modules from cache
    for name, _ in pairs(package.loaded) do
      if name:match '^config' then
        package.loaded[name] = nil
      end
    end
    -- re-source init.lua
    dofile(vim.env.MYVIMRC)
    vim.notify('Config reloaded', vim.log.levels.INFO)
  end, { desc = 'Reload config' })

  -- toggle line numbers
  vim.keymap.set('n', '<leader>ul', function()
    local enabled = not vim.o.number
    vim.opt.number = enabled
    vim.opt.relativenumber = enabled
  end, { desc = 'Toggle line numbers' })

  -- toggle statusline
  vim.keymap.set('n', '<leader>ub', function()
    vim.o.laststatus = vim.o.laststatus == 0 and 2 or 0
  end, { desc = 'Toggle statusline' })

  -- switch colorschemes
  vim.keymap.set('n', '<leader>us', function()
    if vim.g.colors_name == 'zenbones' then
      vim.cmd 'highlight clear'
      vim.cmd 'colorscheme gondolin'
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

  -- open current file in default program
  vim.api.nvim_create_user_command('SystemOpen', function()
    local path = vim.fn.expand('%:p')
    if path == '' then
      vim.notify('Buffer has no file path', vim.log.levels.WARN)
      return
    end
    vim.fn.jobstart({ 'open', path }, { detach = true })
    vim.notify('Opening ' .. path, vim.log.levels.INFO)
  end, { desc = 'Open current file in default system program' })

  -- Register which-key groups
  local wk = require 'which-key'
  wk.add {
    { '<leader>f', group = 'Find' },
    { '<leader>g', group = 'Git' },
    { '<leader>h', group = 'Harpoon' },
    { '<leader>l', group = 'LSP' },
    { '<leader>o', group = 'Opencode' },
    { '<leader>u', group = 'UI' },
  }
end

return M
