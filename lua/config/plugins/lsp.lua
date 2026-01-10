return {
  {
    -- Dependencies for LSP functionality
    { 'j-hui/fidget.nvim', opts = {} }, -- useful notifications
  },
  {
    'saghen/blink.cmp', -- autocompletion
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    name = 'native-lsp-config',
    dir = vim.fn.stdpath 'config',
    config = function()
      -- blink autocompletion capabilities
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- LSP server configurations
      local servers = {
        lua_ls = {
          cmd = { 'lua-language-server' },
          filetypes = { 'lua' },
          root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
        },
        biome = {
          cmd = { 'biome', 'lsp-proxy' },
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc' },
          root_markers = { 'biome.json', 'biome.jsonc' },
        },
        ts_ls = {
          cmd = { 'typescript-language-server', '--stdio' },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
        },
        clangd = {
          cmd = { 'clangd' },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
          root_markers = { 'compile_commands.json', '.clangd', '.git' },
        },
        svelte = {
          cmd = { 'svelteserver', '--stdio' },
          filetypes = { 'svelte' },
          root_markers = { 'package.json', 'svelte.config.js', 'svelte.config.ts', '.git' },
        },
        expert = {
          cmd = { vim.fn.expand '~/.local/bin/expert_darwin_arm64', '--stdio' },
          root_markers = { 'mix.exs', '.git' },
          filetypes = { 'elixir', 'eelixir', 'heex' },
        },
      }

      -- Configure and enable each server
      for server, config in pairs(servers) do
        local cmd = config.cmd and config.cmd[1]
        if cmd and vim.fn.executable(cmd) == 1 then
          config.capabilities = capabilities
          vim.lsp.config(server, config)
          vim.lsp.enable(server)
        end
      end

      -- setup formatting on save for every lsp that supports it.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          -- Easily create a mapping.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
          end

          -- custom mappings
          map('gd', function()
            Snacks.picker.lsp_definitions()
          end, '[G]oto [D]efinition')

          -- these are now the default mappings in HEAD
          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('grr', vim.lsp.buf.references, 'References')
          map('gri', vim.lsp.buf.implementation, 'Implementation')
          map('grc', vim.lsp.buf.incoming_calls, 'Incoming Calls')
          map('gO', vim.lsp.buf.document_symbol, 'Document Symbol')
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
