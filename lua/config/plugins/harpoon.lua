return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    -- Basic harpoon setup
    harpoon:setup {}
  end,
  keys = {
    {
      '<leader>A',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Add file to harpoon',
    },
    {
      '<leader>a',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon quick menu',
    },
    {
      '<leader>ft',
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
      desc = 'Find harpoon marks',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Navigate to harpoon file 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Navigate to harpoon file 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Navigate to harpoon file 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Navigate to harpoon file 4',
    },
    {
      '<leader>5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Navigate to harpoon file 5',
    },
  },
}
