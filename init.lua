require("config.lazy")

--- sane indentation
vim.opt.expandtab = true          -- tabs to spaces
vim.opt.shiftwidth = 2            -- number of spaces
vim.opt.tabstop = 2               -- number of spaces a tab counts for
vim.opt.softtabstop = 2           -- number of spaces a tab counts for while editing
vim.opt.smartindent = true        -- smart autoindenting for newlines

vim.opt.clipboard = "unnamedplus" -- global clipboard
vim.opt.shortmess:append("I")     -- no startup message

--- do we want line numbers? Neh...
vim.opt.number = false
vim.opt.relativenumber = false

--- KEYBINDINGS
---
--- run the current line
vim.keymap.set("n", "<space>x", function()
  vim.cmd(".lua")
  vim.notify("executed current line", 2)
end)

--- run selection
vim.keymap.set("v", "<space>x", ":lua<CR>")

--- run the current file
vim.keymap.set("n", "<space><space>x", function()
  vim.cmd("source %")
  vim.notify("sourced current file", 2)
end)
