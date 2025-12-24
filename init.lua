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

-- 24 bit colors
vim.opt.termguicolors = true

-- relative line numbers with absolute on current line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

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

-- auto-refresh files when changed externally (works even when Neovim is in background)
-- comes in useful when working with an agent side-by-side and you want the recent
-- changes to be reflected in Neovim at all times
vim.opt.autoread = true
do
  local w = vim.uv.new_fs_event()
  if w then
    local function watch(path)
      w:stop()
      w:start(
        path,
        {},
        vim.schedule_wrap(function()
          vim.cmd 'checktime'
          watch(path) -- restart watcher (editors may replace files instead of modifying)
        end)
      )
    end
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('petar-file-watcher', { clear = true }),
      callback = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path ~= '' and vim.uv.fs_stat(path) then
          watch(path)
        end
      end,
    })
  end
end

-- Setup keybindings
require('config.keybindings').setup()
