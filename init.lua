require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus" -- global clipboard
vim.opt.shortmess:append("I") -- no startup message

--- KEYBINDINGS
--- execute the current line
vim.keymap.set("n", "<space>x", function()
  vim.cmd(".lua")
  vim.notify("executed current line", 2)
end)

--- execute selection
vim.keymap.set("v", "<space>x", ":lua<CR>")

--- source the current file
vim.keymap.set("n", "<space><space>x", function()
  vim.cmd("source %")
  vim.notify("sourced current file", 2)
end)
