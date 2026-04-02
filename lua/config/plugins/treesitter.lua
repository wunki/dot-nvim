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

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    treesitter.setup()

    local group = vim.api.nvim_create_augroup('treesitter-start', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = filetypes,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
