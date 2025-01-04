require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus" -- global clipboard
vim.opt.shortmess:append("I") -- no startup message

-- easily run source code
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
