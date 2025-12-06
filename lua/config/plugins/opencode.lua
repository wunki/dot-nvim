return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'snacks',
      },
    }

    -- Required for opts.events.reload
    vim.o.autoread = true

    local opencode = require 'opencode'

    -- Keybindings for opencode operations
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() opencode.ask('@this: ', { submit = true }) end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>os', function() opencode.select() end, { desc = 'Select opencode action' })
    vim.keymap.set({ 'n', 'x' }, '<leader>op', function() opencode.prompt('@this') end, { desc = 'Add to opencode' })
    vim.keymap.set({ 'n', 't' }, '<leader>oo', function() opencode.toggle() end, { desc = 'Toggle opencode' })
  end,
}
