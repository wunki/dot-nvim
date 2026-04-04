require 'config.lazy'

-- sane indentation
vim.opt.expandtab = true -- tabs to spaces
vim.opt.shiftwidth = 2 -- number of spaces
vim.opt.tabstop = 2 -- number of spaces a tab counts for
vim.opt.softtabstop = 2 -- number of spaces a tab counts for while editing
vim.opt.smartindent = true -- smart autoindenting for newlines

-- move between words
vim.opt.iskeyword:remove '_'

-- enable break indent, making longer lines easier to read
vim.opt.breakindent = true

-- system wide clipboard, async to keep startup time fast
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = {
  trail = '·', -- Highlight trailing whitespace
  extends = '»', -- Highlight text extending beyond window
  precedes = '«', -- Highlight text preceding the window
  nbsp = '␣', -- Highlight non-breaking spaces
  tab = '  ', -- Hide tab characters
}

-- no startup message
vim.opt.shortmess:append 'I'

-- relative line numbers with absolute on current line
vim.opt.number = false
vim.opt.relativenumber = false

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- prevent layout shift when diagnostics/gitsigns appear
vim.opt.signcolumn = 'yes'

-- smooth scrolling on ctrl-d/ctrl-u
vim.opt.smoothscroll = true

-- ctrl-o/ctrl-i behave like browser back/forward
vim.opt.jumpoptions = 'stack'

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- preview substitutions when typing.
vim.opt.inccommand = 'split'

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('petar-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- restore cursor position when reopening files
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position',
  group = vim.api.nvim_create_augroup('petar-restore-cursor', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- auto-refresh files when changed externally (useful when working with an agent side-by-side)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = vim.api.nvim_create_augroup('petar-file-watcher', { clear = true }),
  command = 'silent! checktime',
})

-- Setup keybindings
require 'config.keybindings'
