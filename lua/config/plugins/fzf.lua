return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    -- to check which commands are available, run the `FzfLua builtin` command.
    -- find files in current directory
    vim.keymap.set("n", "<space>fd", require('fzf-lua').files)

    -- find files in my neovim configuration
    vim.keymap.set("n", "<space>en", function()
      require('fzf-lua').files {
        cwd = vim.fn.stdpath("config")
      }
    end)

    -- colorschemes
    vim.keymap.set("n", "<space>cs", require('fzf-lua').colorschemes)
  end
}
