-- Reload the finde colorscheme (useful during development)
local function reload_finde()
  for name, _ in pairs(package.loaded) do
    if name:match '^finde' then
      package.loaded[name] = nil
    end
  end
  vim.cmd 'highlight clear'
  require('finde').setup { gutter = true }
  vim.cmd.colorscheme 'finde'
  vim.notify('Reloaded finde colorscheme', vim.log.levels.INFO)
end

vim.g.reload_finde = reload_finde

return {
  {
    dir = '~/Code/finde.nvim',
    name = 'finde',
    lazy = false,
    priority = 1000,
    config = function()
      require('finde').setup { gutter = false }
      vim.cmd.colorscheme 'finde'
      vim.keymap.set('n', '<leader>ur', reload_finde, { desc = 'Reload finde colorscheme' })
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
        vim.cmd.colorscheme 'finde'
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
