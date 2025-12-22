-- Reload the finde colorscheme (useful during development)
local function reload_finde()
  -- Clear cached modules
  for name, _ in pairs(package.loaded) do
    if name:match '^finde' then
      package.loaded[name] = nil
    end
  end
  -- Clear highlights and reload
  vim.cmd 'highlight clear'
  require('finde').setup { gutter = true }
  vim.cmd.colorscheme 'finde'
  vim.notify('Reloaded finde colorscheme', vim.log.levels.INFO)
end

-- Expose globally for easy access
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

      -- Keybinding to reload my colorscheme
      vim.keymap.set('n', '<leader>ur', reload_finde, { desc = 'Reload finde colorscheme' })
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones = {
        solid_line_nr = true,
        solid_vert_split = true,
        lightness = 'bright',
      }
    end,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'finde-dark'
        vim.opt.background = 'dark'
      end,
      set_light_mode = function()
        vim.cmd 'highlight clear'
        vim.cmd.colorscheme 'zenbones'
        vim.opt.background = 'light'
      end,
    },
  },
}
