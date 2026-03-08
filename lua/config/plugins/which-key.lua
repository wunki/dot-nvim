return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Harpoon' },
      { '<leader>l', group = 'LSP' },
      { '<leader>o', group = 'Opencode' },
      { '<leader>u', group = 'UI' },
    },
  },
}
