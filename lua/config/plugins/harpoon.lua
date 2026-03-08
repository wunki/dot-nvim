local keys = {
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
}

for i = 1, 5 do
  keys[#keys + 1] = {
    '<leader>h' .. i,
    function() require('harpoon'):list():select(i) end,
    desc = 'Go to file ' .. i,
  }
end

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
          return vim.uv.cwd()
        end,
      },
    }

    local extensions = require 'harpoon.extensions'
    harpoon:extend(extensions.builtins.navigate_with_number())
    harpoon:extend(extensions.builtins.highlight_current_file())
  end,
  keys = keys,
}
