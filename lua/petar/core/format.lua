local opt = vim.opt

-- Max width of 80, so I can easily have split windows.
opt.textwidth = 80

-- Format the buffer for Go, Clojure and Lua
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go", "*.clj", "*.cljs", "*.cljc", "*.edn", "*.lua" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Don't show the LSP warnings in the conjure log buffer
vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "Conjure Log disable LSP diagnostics",
  pattern = { "conjure-log-*" },
  callback = function()
    return vim.diagnostics.disable(0)
  end,
  group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", {
    clear = true,
  }),
})
