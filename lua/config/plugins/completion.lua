return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',

  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        auto_show = false,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    -- we don't polute the buffer and only trigger
    -- completions when requested.
    keymap = {
      preset = 'default',
      ['<C-space>'] = {
        function(cmp)
          cmp.show()
        end,
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    cmdline = {
      enabled = false,
    },
  },
  opts_extend = { 'sources.default' },
}
