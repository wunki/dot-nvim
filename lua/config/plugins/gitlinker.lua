return {
  'ruifm/gitlinker.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('gitlinker').setup {
      opts = {
        add_current_line_on_normal_mode = true,
        print_url = true,
      },
      mappings = '<leader>gy',
    }
  end,
  keys = {
    { '<leader>gy', desc = 'Open current line in GitHub' },
    { '<leader>gy', mode = 'v',                          desc = 'Open selected lines in GitHub' },
  },
}
