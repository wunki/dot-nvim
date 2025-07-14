return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },
      html = { 'prettierd' },
      fish = { 'fish_indent' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
