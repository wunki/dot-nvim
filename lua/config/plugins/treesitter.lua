return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
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
        'tsx',
        'html',
        'markdown',
        'rust',
        'toml',
        'astro',
        'svelte',
        'clojure',
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = false,
        },
      },
    }
  end,
}
