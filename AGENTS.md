# AGENTS.md

This document provides guidance for AI agents working with this Neovim configuration repository.

## Repository Overview

This is a personal Neovim configuration written in Lua, using lazy.nvim as the plugin manager. The configuration prioritizes:

- Fast startup through lazy-loading
- Minimal, clean design
- Modern LSP integration
- Productivity-focused keybindings

## Project Structure

```
.
├── init.lua                    # Entry point - core vim options and settings
├── lua/config/
│   ├── lazy.lua                # Plugin manager bootstrap and setup
│   ├── keybindings.lua         # Global keybinding definitions
│   └── plugins/                # Individual plugin configurations
│       ├── colorscheme.lua
│       ├── completion.lua
│       ├── conform.lua         # Code formatting
│       ├── lsp.lua             # Language server configuration
│       ├── treesitter.lua
│       └── ...
├── after/ftplugin/             # Filetype-specific settings
│   ├── lua.lua
│   ├── svelte.lua
│   └── ...
└── after/plugin/               # Post-load plugin configurations
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
- `<leader>f` - File/find operations (telescope, file browser)
- `<leader>u` - UI toggles (line numbers, colorscheme)
- `<leader>l` - Lazy/git operations
- `g` prefix - Go-to operations (LSP navigation)
- `gr` prefix - LSP refactoring (rename, references, actions)

### LSP Configuration

- Language servers are configured in `lua/config/plugins/lsp.lua`
- Servers are expected to be installed globally (not via Mason)
- Use `vim.lsp.config()` and `vim.lsp.enable()` for server setup
- Capabilities are extended with blink.cmp for autocompletion

### Filetype Settings

- Filetype-specific settings go in `after/ftplugin/<filetype>.lua`
- Use `vim.opt_local` for buffer-local options

## Making Changes

### Adding a New Plugin

1. Create a new file in `lua/config/plugins/<plugin-name>.lua`
2. Return a lazy.nvim plugin spec table
3. Configure lazy-loading where appropriate
4. Add keybindings with descriptive `desc` fields

### Adding a New Language Server

1. Add the server configuration to the `servers` table in `lua/config/plugins/lsp.lua`
2. Include `cmd`, `filetypes`, and `root_markers` as needed
3. Ensure the language server binary is available in PATH

### Modifying Keybindings

- Global keybindings: Edit `lua/config/keybindings.lua`
- Plugin-specific keybindings: Edit the respective plugin file in `lua/config/plugins/`
- Always register groups with which-key for discoverability

## Testing Changes

1. Source the current file with `<Space><Space>x` to reload Lua modules
2. Run `:Lazy` to check plugin status
3. Use `:checkhealth` to verify LSP and plugin health
4. Check `:messages` for any errors

## Dependencies

External tools expected to be available:

- **Formatters**: stylua, prettierd, fish_indent
- **Language Servers**: lua_ls, biome, typescript-language-server, clangd, svelteserver
- **Other**: lazygit (for git integration)

## Important Notes

- This config uses Neovim's native LSP (not nvim-lspconfig plugin wrapper)
- Format on save is enabled by default via conform.nvim
- The configuration assumes a modern terminal with 24-bit color support
- Line numbers are disabled by default (toggle with `<Space>ul`)
