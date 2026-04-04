# AGENTS.md

This document provides guidance for AI agents working with this Neovim configuration repository.

## Repository Overview

This is a personal Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration prioritizes:

- Fast startup through lazy-loading
- Minimal, clean design
- Modern LSP integration (native, no nvim-lspconfig)
- Productivity-focused keybindings

## Project Structure

```
.
├── init.lua                    # Entry point - core vim options and settings
├── lua/config/
│   ├── lazy.lua                # Plugin manager bootstrap and setup
│   ├── keybindings.lua         # Global keybinding definitions
│   └── plugins/                # Individual plugin configurations
│       ├── claudecode.lua
│       ├── clojure.lua
│       ├── colorscheme.lua
│       ├── completion.lua      # blink.cmp
│       ├── conform.lua         # Code formatting
│       ├── gitsigns.lua
│       ├── harpoon.lua
│       ├── lsp.lua             # Language server configuration
│       ├── markdown.lua        # render-markdown.nvim
│       ├── mini.lua
│       ├── opencode.lua
│       ├── snacks.lua          # Snacks pickers, dashboard, etc.
│       ├── todo-comments.lua
│       ├── treesitter.lua
│       └── which-key.lua
└── after/queries/              # Custom treesitter queries
```

## Code Style and Conventions

### Lua Formatting

- **Formatter**: StyLua (configured in `stylua.toml`)
- **Indentation**: 2 spaces
- **Line width**: 160 characters
- **Quotes**: Single quotes preferred
- **Call parentheses**: Omit when possible (e.g., `require 'module'` not `require('module')`)

### Plugin Configuration Patterns

1. **Plugin specs** are defined as Lua tables returned from files in `lua/config/plugins/`
2. **Lazy-loading** is preferred - use `ft`, `cmd`, `keys`, or `event` to defer loading
3. **Options** should use the `opts = {}` pattern when possible for cleaner configuration

Example plugin configuration:
```lua
return {
  'plugin/name',
  ft = 'lua',  -- lazy load on filetype
  opts = {
    -- plugin options here
  },
}
```

### Keybinding Conventions

- **Leader key**: Space (`<Space>` or `<leader>`)
- **Local leader**: Backslash (`\`)
- All keymaps should include a `desc` field for which-key integration
- Use the `vim.keymap.set()` API

Keybinding namespaces:
- `<leader>x` / `<leader>X` - Execute current line / source current file as Lua
- `<leader>u` - UI toggles (line numbers, statusline)
- `<leader>l` - LSP operations (diagnostics, restart)
- `g` prefix - Go-to operations (LSP navigation)
- `gr` prefix - LSP refactoring (rename, references, actions, incoming calls)

### LSP Configuration

- Language servers are configured in `lua/config/plugins/lsp.lua`
- Servers are expected to be installed globally (not via Mason)
- Use `vim.lsp.config()` and `vim.lsp.enable()` for server setup
- Capabilities are extended with blink.cmp for autocompletion
- Servers only enabled if their binary is found in PATH

### Filetype Settings

- Custom treesitter queries go in `after/queries/`

## Making Changes

### Adding a New Plugin

1. Create a new file in `lua/config/plugins/<plugin-name>.lua`
2. Return a lazy.nvim plugin spec table
3. Configure lazy-loading where appropriate
4. Add keybindings with descriptive `desc` fields

### Adding a New Language Server

1. Add the server configuration to the `servers` table in `lua/config/plugins/lsp.lua`
2. Include `cmd`, `filetypes`, and `root_markers` as needed
3. Ensure the language server binary is available in PATH (servers are auto-skipped if not found)

### Modifying Keybindings

- Global keybindings: Edit `lua/config/keybindings.lua`
- Plugin-specific keybindings: Edit the respective plugin file in `lua/config/plugins/`
- Always register groups with which-key for discoverability

## Testing Changes

1. Execute current line with `<leader>x` or source current file with `<leader>X`
2. Run `:Lazy` to check plugin status
3. Use `:checkhealth` to verify LSP and plugin health
4. Check `:messages` for any errors

## Dependencies

External tools expected to be available:

- **Formatters**: stylua, prettierd, biome, goimports, gofmt, rustfmt, fish_indent
- **Language Servers**: lua_ls, biome, typescript-language-server (ts_ls), clangd, gopls, rust-analyzer, svelteserver, clojure-lsp, expert (Elixir)
- **Other**: lazygit (for git integration), tree-sitter CLI (for parser compilation)

## Important Notes

- This config uses Neovim's native LSP (not nvim-lspconfig plugin wrapper)
- Format on save is enabled by default via conform.nvim (biome preferred over prettier when `biome.json` present)
- The configuration assumes a modern terminal with 24-bit color support
- Relative line numbers are enabled by default (toggle with `<leader>ul`)
- Treesitter uses the new `nvim-treesitter` main branch (Neovim 0.12+)
