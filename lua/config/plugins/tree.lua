return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup { color_icons = false }
      end,
    },
  },
  lazy = false,
  keys = {
    { '<leader>ft', '<cmd>NvimTreeFindFile<cr>', desc = 'Find file in filetree' },
    { '<C-b>', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle filetree' },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)

    local group = vim.api.nvim_create_augroup('nvimtree-statusline', { clear = true })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = group,
      pattern = 'NvimTree_*',
      callback = function()
        vim.wo.statusline = '%#Normal#'
        vim.o.laststatus = 0
      end,
    })
    vim.api.nvim_create_autocmd('BufLeave', {
      group = group,
      pattern = 'NvimTree_*',
      callback = function()
        vim.o.laststatus = 2
      end,
    })
  end,
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 'O', function()
        local node = api.tree.get_node_under_cursor()
        if node then
          vim.fn.jobstart({ 'open', node.absolute_path }, { detach = true })
        end
      end, opts('Open with System Default'))
    end,
    filters = {
      custom = { '.git', 'node_modules', '.vscode' },
      dotfiles = false,
    },
    view = {
      adaptive_size = true,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = 'name',
      icons = {
        show = { git = false },
      },
    },
    git = {
      enable = true,
    },
  },
}
