return {
  {
    'wunki/gondolin.nvim',
    name = 'gondolin',
    lazy = false,
    priority = 1000,
    config = function()
      require('gondolin').setup { gutter = false }
      vim.cmd.colorscheme 'gondolin'

      vim.keymap.set('n', '<leader>ur', function()
        for name, _ in pairs(package.loaded) do
          if name:match '^gondolin' then
            package.loaded[name] = nil
          end
        end
        vim.cmd 'highlight clear'
        require('gondolin').setup { gutter = false }
        vim.cmd.colorscheme 'gondolin'
        vim.notify('Reloaded gondolin colorscheme', vim.log.levels.INFO)
      end, { desc = 'Reload gondolin colorscheme' })
    end,
  },
  {
    'savq/melange-nvim',
    name = 'melange',
    lazy = true,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'gondolin'
        vim.opt.background = 'dark'
      end,
      set_light_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'melange'
        vim.opt.background = 'light'
      end,
    },
  },
}
