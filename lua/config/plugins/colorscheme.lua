local gondolin_dir = '/home/petar/Code/wunki/gondolin.nvim'

local function clear_gondolin()
  for name, _ in pairs(package.loaded) do
    if name:match '^gondolin' or name:match '^lualine%.themes%.gondolin' then
      package.loaded[name] = nil
    end
  end
  vim.cmd 'highlight clear'
end

local function setup_gondolin()
  require('gondolin').setup {
    cache = false,
    gutter = false,
  }
end

local function load_gondolin(variant)
  clear_gondolin()
  setup_gondolin()

  if variant == 'dark' or variant == 'light' then
    vim.cmd.colorscheme('gondolin-' .. variant)
  else
    vim.cmd.colorscheme 'gondolin'
    variant = vim.o.background
  end

  vim.notify('Loaded local gondolin ' .. variant, vim.log.levels.INFO)
end

return {
  {
    'wunki/gondolin.nvim',
    name = 'gondolin',
    dir = gondolin_dir,
    lazy = false,
    priority = 1000,
    config = function()
      setup_gondolin()
      vim.cmd.colorscheme 'gondolin'

      vim.api.nvim_create_user_command('GondolinDark', function()
        load_gondolin 'dark'
      end, { desc = 'Load local Gondolin dark variant' })

      vim.api.nvim_create_user_command('GondolinLight', function()
        load_gondolin 'light'
      end, { desc = 'Load local Gondolin light variant' })

      vim.api.nvim_create_user_command('GondolinAuto', function()
        load_gondolin 'auto'
      end, { desc = 'Load local Gondolin variant from background' })

      vim.keymap.set('n', '<leader>ur', function()
        load_gondolin(vim.o.background)
      end, { desc = 'Reload local Gondolin colorscheme' })

      vim.keymap.set('n', '<leader>uD', function()
        load_gondolin 'dark'
      end, { desc = 'Gondolin dark' })

      vim.keymap.set('n', '<leader>uL', function()
        load_gondolin 'light'
      end, { desc = 'Gondolin light' })
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
  },
  {
    'f-person/auto-dark-mode.nvim',
    enabled = vim.fn.has 'mac' == 1 or vim.fn.has 'linux' == 1,
    opts = {
      update_interval = 3000,
      set_dark_mode = function()
        vim.opt.background = 'dark'
        load_gondolin 'dark'
      end,
      set_light_mode = function()
        vim.opt.background = 'light'
        load_gondolin 'light'
      end,
    },
  },
}
