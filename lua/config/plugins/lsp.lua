return {
  {
    'neovim/nvim-lspconfig',
    -- sane configuration for Lua
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} }, -- useful notifcations
      'saghen/blink.cmp', -- autocompletion
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      -- blink autocompletion capabilities
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- lua
      require('lspconfig').lua_ls.setup { capabilities = capabilities }

      -- typescript
      require('lspconfig').ts_ls.setup { capabilities = capabilities }

      -- C
      require('lspconfig').clangd.setup { capabilities = capabilities }

      -- setup formatting on save for every lsp that supports it.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          -- @diagnostic disable-next-line: missing-parameter
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format { bufnr = args.buf, id = client.id }
              end,
            })
          end
        end,
      })
    end,
  },
}
