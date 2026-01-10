return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
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
          'javascript',
          'typescript',
          'tsx',
          'html',
          'markdown',
          'astro',
          'svelte',
        },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
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
  },
}
