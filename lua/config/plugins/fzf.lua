return {
  "ibhagwan/fzf-lua",
  opts = {
    defaults = {
      header = false,    -- don't show header
      file_icons = false -- don't use any file icons
    }
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)

    -- to check which commands are available, run the `FzfLua builtin` command.
    -- find files in current directory
    vim.keymap.set("n", "<space>fd", require("fzf-lua").files)

    -- find files in my neovim configuration
    vim.keymap.set("n", "<space>en", function()
      require("fzf-lua").files({
        cwd = vim.fn.stdpath("config"),
      })
    end)

    -- colorschemes
    vim.keymap.set("n", "<space>fc", require("fzf-lua").colorschemes)

    -- help tags
    vim.keymap.set("n", "<space>fh", require("fzf-lua").help_tags)
  end,
}
