return {
  {
    'nvim-treesitter/nvim-treesitter',
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
        },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
}
