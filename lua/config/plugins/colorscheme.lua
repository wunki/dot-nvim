-- Reload the gondolin colorscheme (useful during development)
local function reload_gondolin()
  for name, _ in pairs(package.loaded) do
    if name:match '^gondolin' then
      package.loaded[name] = nil
    end
  end
  vim.cmd 'highlight clear'
  require('gondolin').setup { gutter = true }
  vim.cmd.colorscheme 'gondolin'
  vim.notify('Reloaded gondolin colorscheme', vim.log.levels.INFO)
end

vim.g.reload_gondolin = reload_gondolin

return {
  {
    'wunki/gondolin.nvim',
    name = 'gondolin',
    lazy = false,
    priority = 1000,
    config = function()
      require('gondolin').setup { gutter = false }
      vim.cmd.colorscheme 'gondolin'
      vim.keymap.set('n', '<leader>ur', reload_gondolin, { desc = 'Reload gondolin colorscheme' })
    end,
  },
  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    lazy = false,
    priority = 1000,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'gondolin'
        vim.opt.background = 'dark'
      end,
      set_light_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'flexoki-light'
        vim.opt.background = 'light'
      end,
    },
  },
}
