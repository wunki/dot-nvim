return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup({ color_icons = false })
      end,
    },
  },
  lazy = false,
  keys = {
    { '<leader>ft', '<cmd>NvimTreeFindFile<cr>', desc = 'Find file in filetree' },
    { '<C-n>', '<cmd>NvimTreeToggle<cr>', desc = 'Find file in filetree' },
  },
  opts = {
    filters = {
      custom = { '.git', 'node_modules', '.vscode' },
      dotfiles = true,
    },
    git = {},
    view = {
      adaptive_size = true,
      float = {
        enable = false,
      },
    },
  },
}
