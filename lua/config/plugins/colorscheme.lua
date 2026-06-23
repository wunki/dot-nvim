local function local_gondolin_dir()
  local candidates = {
    vim.fn.expand '~/Code/gondolin.nvim',
    vim.fn.expand '~/Code/wunki/gondolin.nvim',
  }

  for _, path in ipairs(candidates) do
    if vim.uv.fs_stat(path) then
      return path
    end
  end

  return candidates[1]
end

local function gondolin_variant(background)
  return background == 'light' and 'gondolin-light' or 'gondolin-dark'
end

local function current_gondolin_variant()
  if vim.g.colors_name == 'gondolin-light' or vim.g.colors_name == 'gondolin-dark' then
    return vim.g.colors_name
  end

  return gondolin_variant(vim.o.background)
end

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

local function load_gondolin(opts)
  opts = type(opts) == 'table' and opts or { variant = opts }

  local theme = opts.theme
  if not theme then
    if opts.variant == 'dark' or opts.variant == 'light' then
      theme = 'gondolin-' .. opts.variant
    else
      theme = gondolin_variant(vim.o.background)
    end
  end

  if theme == 'gondolin-light' then
    vim.o.background = 'light'
  elseif theme == 'gondolin-dark' then
    vim.o.background = 'dark'
  end

  clear_gondolin()
  setup_gondolin()
  vim.cmd.colorscheme(theme)

  if opts.notify then
    vim.notify('Loaded local ' .. theme, vim.log.levels.INFO)
  end
end

return {
  {
    'wunki/gondolin.nvim',
    name = 'gondolin',
    dir = local_gondolin_dir(),
    lazy = false,
    priority = 1000,
    config = function()
      load_gondolin()

      local switching_background = false
      vim.api.nvim_create_autocmd('ColorSchemePre', {
        group = vim.api.nvim_create_augroup('petar-gondolin-background', { clear = true }),
        pattern = { 'gondolin', 'gondolin-dark', 'gondolin-light' },
        callback = function(args)
          if switching_background then
            return
          end

          local requested_background = vim.o.background
          local theme = gondolin_variant(requested_background)
          if args.match == theme then
            return
          end

          vim.schedule(function()
            if vim.g.colors_name == theme then
              return
            end

            switching_background = true
            vim.o.background = requested_background
            vim.cmd.colorscheme(theme)
            switching_background = false
          end)
        end,
      })

      local function reload_gondolin()
        load_gondolin {
          notify = true,
          theme = current_gondolin_variant(),
        }
      end

      vim.api.nvim_create_user_command('GondolinDark', function()
        load_gondolin { notify = true, variant = 'dark' }
      end, { desc = 'Load local Gondolin dark variant' })

      vim.api.nvim_create_user_command('GondolinLight', function()
        load_gondolin { notify = true, variant = 'light' }
      end, { desc = 'Load local Gondolin light variant' })

      vim.api.nvim_create_user_command('GondolinAuto', function()
        load_gondolin { notify = true, variant = 'auto' }
      end, { desc = 'Load local Gondolin variant from background' })

      vim.api.nvim_create_user_command('GondolinReload', reload_gondolin, {
        desc = 'Reload the current Gondolin colorscheme variant',
      })

      vim.keymap.set('n', '<leader>ur', reload_gondolin, { desc = 'Reload local Gondolin colorscheme' })

      vim.keymap.set('n', '<leader>uD', function()
        load_gondolin { notify = true, variant = 'dark' }
      end, { desc = 'Gondolin dark' })

      vim.keymap.set('n', '<leader>uL', function()
        load_gondolin { notify = true, variant = 'light' }
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
        load_gondolin 'dark'
      end,
      set_light_mode = function()
        load_gondolin 'light'
      end,
    },
  },
}
