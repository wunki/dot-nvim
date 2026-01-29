return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      settings = {
        save_on_toggle = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    }

    local extensions = require 'harpoon.extensions'
    harpoon:extend(extensions.builtins.navigate_with_number())
    harpoon:extend(extensions.builtins.highlight_current_file())
  end,
  keys = {
    {
      '<leader>ha',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Add file',
    },
    {
      '<leader>hh',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Quick menu',
    },
    {
      '<leader>hf',
      function()
        local harpoon = require 'harpoon'
        local list = harpoon:list()
        local items = {}
        for _, it in ipairs(list.items or {}) do
          table.insert(items, { text = it.value, file = it.value })
        end
        Snacks.picker.pick {
          source = 'harpoon',
          items = items,
          format = 'file',
          preview = 'preview',
          confirm = function(picker, item)
            picker:close()
            if not item then
              return
            end
            for i, it in ipairs(list.items or {}) do
              if it.value == item.text then
                list:select(i)
                break
              end
            end
          end,
        }
      end,
      desc = 'Find marks',
    },
    {
      '<leader>h1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Go to file 1',
    },
    {
      '<leader>h2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Go to file 2',
    },
    {
      '<leader>h3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Go to file 3',
    },
    {
      '<leader>h4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Go to file 4',
    },
    {
      '<leader>h5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Go to file 5',
    },
  },
}
