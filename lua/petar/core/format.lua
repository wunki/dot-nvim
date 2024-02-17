vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.clj",
  callback = function()
    vim.lsp.buf.format()
  end,
})
