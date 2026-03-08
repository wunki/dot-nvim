return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',

  version = '*',

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

    keymap = {
      preset = 'default',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },
    cmdline = {
      enabled = false,
    },
  },
  opts_extend = { 'sources.default' },
}
