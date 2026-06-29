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
      local oxlint_filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'svelte',
      }
      local vite_plus_root_markers = {
        'oxfmt.config.ts',
        'oxlint.config.ts',
        '.oxfmtrc.json',
        '.oxfmtrc.jsonc',
        '.oxlintrc.json',
        'vite.config.ts',
        'vite.config.js',
        'vite.config.mts',
        'vite.config.mjs',
        'svelte.config.ts',
        'svelte.config.js',
        'package.json',
      }

      -- Resolve a node CLI: project-local node_modules/.bin first, then the
      -- global binary (skipped when local_only -- e.g. oxfmt needs the local
      -- install to resolve a project's svelte/compiler).
      local function node_bin(name)
        return function(root_dir, local_only)
          if root_dir then
            local local_cmd = vim.fs.joinpath(root_dir, 'node_modules', '.bin', name)
            if vim.fn.executable(local_cmd) == 1 then
              return local_cmd
            end
          end

          if local_only then
            return nil
          end

          local global_cmd = vim.fn.exepath(name)
          if global_cmd ~= '' then
            return global_cmd
          end

          return nil
        end
      end

      local oxlint_executable = node_bin 'oxlint'

      local oxlint = {
        cmd = function(dispatchers, config)
          local cmd = assert(oxlint_executable(config.root_dir), 'oxlint executable not found')
          return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers, { cwd = config.root_dir })
        end,
        root_dir = function(bufnr, on_dir)
          local root_dir = vim.fs.root(bufnr, vite_plus_root_markers)
          if root_dir and oxlint_executable(root_dir) then
            on_dir(root_dir)
          end
        end,
        filetypes = oxlint_filetypes,
        init_options = {
          settings = {
            typeAware = false,
            typeCheck = false,
          },
        },
      }

      -- oxfmt as a long-running LSP formatter (warm server, no per-save startup
      -- cost) for every filetype oxfmt handles. Resolves a project-local oxfmt
      -- first, falling back to the global binary -- except for Svelte: `.svelte`
      -- formatting needs the project-local oxfmt to resolve the project's
      -- `svelte/compiler`, and must be enabled via `fmt: { svelte: {} }` in the
      -- vite/oxfmt config. conform prefers this client over the oxfmt CLI.
      local oxfmt_filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'jsonc',
        'yaml',
        'markdown',
        'html',
        'css',
        'scss',
        'less',
        'svelte',
      }

      local oxfmt_executable = node_bin 'oxfmt'

      local oxfmt = {
        cmd = function(dispatchers, config)
          local cmd = assert(oxfmt_executable(config.root_dir, false), 'oxfmt executable not found')
          return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers, { cwd = config.root_dir })
        end,
        root_dir = function(bufnr, on_dir)
          local root_dir = vim.fs.root(bufnr, vite_plus_root_markers)
          -- Svelte needs a project-local oxfmt; other filetypes can use the global one.
          local local_only = vim.bo[bufnr].filetype == 'svelte'
          if root_dir and oxfmt_executable(root_dir, local_only) then
            on_dir(root_dir)
          end
        end,
        filetypes = oxfmt_filetypes,
      }

      -- LSP server configurations
      local servers = {
        lua_ls = {
          cmd = { 'lua-language-server' },
          filetypes = { 'lua' },
          root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
        },
        jsonls = {
          cmd = { 'vscode-json-language-server', '--stdio' },
          filetypes = { 'json', 'jsonc' },
          root_markers = { '.git' },
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
        oxlint = oxlint,
        oxfmt = oxfmt,
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
        zls = {
          cmd = { 'zls' },
          filetypes = { 'zig', 'zon' },
          root_markers = { 'build.zig', 'build.zig.zon', '.git' },
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
        ols = {
          cmd = { 'ols' },
          filetypes = { 'odin' },
          root_markers = { 'ols.json', 'odinfmt.json', '.git' },
        },
        expert = {
          cmd = {
            (function()
              return vim.fn.expand '~/.local/bin/expert'
            end)(),
            '--stdio',
          },
          root_markers = { 'mix.exs', '.git' },
          filetypes = { 'elixir', 'eelixir', 'heex' },
        },
      }

      -- Configure and enable each server
      for server, config in pairs(servers) do
        local cmd = type(config.cmd) == 'table' and config.cmd[1] or nil
        if type(config.cmd) == 'function' or (cmd and vim.fn.executable(cmd) == 1) then
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

          map('K', function()
            vim.lsp.buf.hover { border = 'rounded' }
          end, 'Hover documentation')
          map('<C-s>', function()
            vim.lsp.buf.signature_help { border = 'rounded' }
          end, 'Signature help', { 'i', 'n' })

          -- gd via Snacks picker for preview support
          map('gd', function()
            Snacks.picker.lsp_definitions()
          end, 'Go to definition')

          -- grc is not a default, the rest (grn, gra, grr, gri, gO) are built-in since 0.11
          map('grc', vim.lsp.buf.incoming_calls, 'Incoming calls')

          map('<leader>ld', function()
            Snacks.picker.diagnostics()
          end, 'Diagnostics')
          map('<leader>lD', function()
            Snacks.picker.diagnostics_buffer()
          end, 'Buffer diagnostics')

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
