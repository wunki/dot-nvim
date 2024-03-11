return {
  'cbochs/grapple.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  keys = {
    { '<leader>tt', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
    { '<leader>tl', '<cmd>Grapple toggle_tags<cr>', desc = 'List all tags' },
  },
}
