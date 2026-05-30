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
      yaml = oxfmt,
      markdown = oxfmt,
      html = oxfmt,
      css = oxfmt,
      scss = oxfmt,
      less = oxfmt,
      fish = { 'fish_indent' },
    },
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'svelte' then
        return {
          timeout_ms = 3000,
          lsp_format = 'prefer',
          filter = function(client)
            return client.name == 'svelte'
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
