return {
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
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
        gopls = {
          cmd = { 'gopls' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_markers = { 'go.work', 'go.mod', '.git' },
        },
        rust_analyzer = {
          cmd = { 'rust-analyzer' },
          filetypes = { 'rust' },
          root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
        },
        svelte = {
          cmd = { 'svelteserver', '--stdio' },
          filetypes = { 'svelte' },
          root_markers = { 'package.json', 'svelte.config.js', 'svelte.config.ts', '.git' },
        },
        clojure_lsp = {
          cmd = { 'clojure-lsp' },
          filetypes = { 'clojure', 'edn' },
          root_markers = { 'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', 'bb.edn', '.git' },
        },
        expert = {
          cmd = {
            (function()
              local uname = vim.uv.os_uname()
              local arch = uname.machine == 'x86_64' and 'amd64' or uname.machine
              return vim.fn.expand(('~/.local/bin/expert_%s_%s'):format(uname.sysname:lower(), arch))
            end)(),
            '--stdio',
          },
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

      -- LSP keymaps (buffer-local)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          -- Easily create a mapping.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
          end

          -- gd via Snacks picker for preview support
          map('gd', function() Snacks.picker.lsp_definitions() end, 'Go to definition')

          -- grc is not a default, the rest (grn, gra, grr, gri, gO) are built-in since 0.11
          map('grc', vim.lsp.buf.incoming_calls, 'Incoming calls')

          map('<leader>ld', function() Snacks.picker.diagnostics() end, 'Diagnostics')
          map('<leader>lD', function() Snacks.picker.diagnostics_buffer() end, 'Buffer diagnostics')

          map('<leader>lr', function()
            local clients = vim.lsp.get_clients { bufnr = args.buf }
            for _, c in ipairs(clients) do
              c:stop()
            end
            vim.defer_fn(function()
              vim.cmd 'edit'
              vim.notify 'LSP clients restarted'
            end, 100)
          end, 'Restart clients')
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
        },
      }
    end,
  },
}
