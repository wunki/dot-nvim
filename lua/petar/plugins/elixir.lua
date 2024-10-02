return {
  'elixir-tools/elixir-tools.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local elixir = require 'elixir'
    local elixirls = require 'elixir.elixirls'

    elixir.setup {
      nextls = { enable = true },
      elixirls = {
        cmd = '/Users/petar/.local/share/elixir-ls/release/language_server.sh',
        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = true,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
          vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
          vim.keymap.set('v', '<space>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
        end,
      },
      projectionist = {
        enable = false,
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
