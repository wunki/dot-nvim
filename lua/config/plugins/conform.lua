local function use_biome()
  return vim.fs.root(0, 'biome.json') ~= nil
end

local function biome_or_prettier()
  return use_biome() and { 'biome' } or { 'prettierd' }
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      typescript = biome_or_prettier,
      typescriptreact = biome_or_prettier,
      json = biome_or_prettier,
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },
      html = { 'prettierd' },
      svelte = biome_or_prettier,
      fish = { 'fish_indent' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
