local filetypes = {
  'c',
  'lua',
  'vim',
  'fish',
  'vimdoc',
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

    local parsers = {
      'c',
      'lua',
      'vim',
      'fish',
      'query',
      'elixir',
      'heex',
      'css',
      'go',
      'gomod',
      'gowork',
      'javascript',
      'typescript',
      'html',
      'markdown',
      'rust',
      'toml',
      'astro',
      'svelte',
      'clojure',
      'vimdoc',
    }
    local installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim
      .iter(parsers)
      :filter(function(p)
        return not vim.tbl_contains(installed, p)
      end)
      :totable()
    if #to_install > 0 then
      require('nvim-treesitter').install(to_install)
    end
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
