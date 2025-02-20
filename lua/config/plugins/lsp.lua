return {
  {
    'neovim/nvim-lspconfig',

    -- sane configuration for Lua
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} }, -- useful notifcations
      'saghen/blink.cmp',                 -- autocompletion
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

      -- svelte
      require('lspconfig').svelte.setup { capabilities = capabilities }

      -- elixir
      require('lspconfig').elixirls.setup {
        capabilities = capabilities,
        cmd = { '/Users/petar/.local/bin/elixir-ls' },
      }

      -- setup formatting on save for every lsp that supports it.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          -- Easily create a mapping.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
          end

          -- custom mappings
          map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

          -- these are now the default mappings in HEAD
          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('grr', vim.lsp.buf.references, 'References')
          map('gri', vim.lsp.buf.implementation, 'Implementation')
          map('gO', vim.lsp.buf.document_symbol, 'Document Symbol')

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

      -- clean up the diagnostics
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '• ',
            [vim.diagnostic.severity.WARN] = '• ',
            [vim.diagnostic.severity.INFO] = '• ',
            [vim.diagnostic.severity.HINT] = '• ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end,
  },
}
