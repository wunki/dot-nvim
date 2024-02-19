local opt = vim.opt

-- Max width of 80, so I can easily have split windows.
opt.textwidth = 80

-- Format the buffer for Clojure.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*.clj",
  callback = function()
    vim.lsp.buf.format()
  end,
})
