local filetypes = {
  'c',
  'lua',
  'vim',
  'fish',
  'help',
  'query',
  'elixir',
  'heex',
  'css',
  'go',
  'gomod',
  'gowork',
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'html',
  'markdown',
  'rust',
  'toml',
  'astro',
  'svelte',
  'clojure',
}

local enabled_filetypes = {} ---@type table<string, boolean>
for _, filetype in ipairs(filetypes) do
  enabled_filetypes[filetype] = true
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  init = function(plugin)
    vim.opt.rtp:append(plugin.dir .. '/runtime')
  end,
  config = function()
    local treesitter = require 'nvim-treesitter'
    treesitter.setup()

    local function start(buf)
      local filetype = vim.bo[buf].filetype
      if filetype == '' or not enabled_filetypes[filetype] then
        return
      end
      pcall(vim.treesitter.start, buf)
    end

    local group = vim.api.nvim_create_augroup('treesitter-start', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = filetypes,
      callback = function(args)
        start(args.buf)
      end,
    })

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        start(buf)
      end
    end
  end,
}
