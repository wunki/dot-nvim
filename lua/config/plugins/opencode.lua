return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    { '<leader>oa', function() require('opencode').ask('@this: ', { submit = true }) end, mode = { 'n', 'x' }, desc = 'Ask opencode' },
    { '<leader>os', function() require('opencode').select() end, mode = { 'n', 'x' }, desc = 'Select opencode action' },
    { '<leader>op', function() require('opencode').prompt('@this') end, mode = { 'n', 'x' }, desc = 'Add to opencode' },
    { '<leader>oo', function() require('opencode').toggle() end, mode = { 'n', 't' }, desc = 'Toggle opencode' },
    { '<leader>od', function() require('opencode').prompt('diagnostics') end, desc = 'Explain diagnostics' },
  },
}
