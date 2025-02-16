return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      svelte = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      fish = { 'fish_indent' },
      sh = { 'shfmt' },
      lua = { 'stylua' },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_fallback = true,
    },
  },
}
