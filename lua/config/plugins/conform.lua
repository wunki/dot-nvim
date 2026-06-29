local oxfmt = { 'oxfmt' }

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = oxfmt,
      javascriptreact = oxfmt,
      typescript = oxfmt,
      typescriptreact = oxfmt,
      json = oxfmt,
      jsonc = oxfmt,
      rust = { 'rustfmt' },
      go = { 'goimports', 'gofmt' },
      odin = { 'odinfmt' },
      zig = { 'zigfmt' },
      zon = { 'zigfmt' },
      yaml = oxfmt,
      markdown = oxfmt,
      html = oxfmt,
      css = oxfmt,
      scss = oxfmt,
      less = oxfmt,
      fish = { 'fish_indent' },
    },
    format_on_save = function(bufnr)
      -- When the warm oxfmt LSP (see lsp.lua) is attached, prefer it (fast, no
      -- per-save startup) and filter to it so other LSPs (ts_ls, jsonls,
      -- svelteserver) don't also format. Otherwise use conform's formatters --
      -- the oxfmt CLI for oxfmt filetypes, or LSP formatting as a last resort.
      if #vim.lsp.get_clients { bufnr = bufnr, name = 'oxfmt' } > 0 then
        return {
          timeout_ms = 3000,
          lsp_format = 'prefer',
          filter = function(client)
            return client.name == 'oxfmt'
          end,
        }
      end

      return {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      }
    end,
  },
}
