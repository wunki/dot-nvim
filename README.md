# .nvim

A minimal Neovim configuration built on native APIs and lazy-loaded plugins. Fast to start, easy to read, and small enough to understand in one sitting. As little as distractions as possible while coding.

## Why this?

Most Neovim configurations fall into two camps: starter kits that hide complexity behind abstractions, and personal configs so tangled they're useful only to their author. This one tries to sit between them.

A few things it does that might save you time:

- **Native LSP, no wrapper plugin.** Language servers are configured with `vim.lsp.config()` and `vim.lsp.enable()` directly. Servers that aren't installed get skipped without errors. You can read the setup in one file and understand what's happening.
- **AI coding assistant integration.** Auto-refreshes buffers when files change on disk (for when Claude Code or similar tools edit files outside Neovim), plus dedicated keybindings for Claude Code and OpenCode.
- **Auto dark/light mode on macOS.** Follows your system appearance setting and switches colorschemes automatically.
- **Completion on demand.** The completion menu stays hidden until you summon it with `<C-Space>`. No popups while you think.

The config is around 600 lines of Lua across 17 files. You can fork the whole thing as a starter, or pull individual files into your own setup.

## Structure

```
init.lua                        Core options, autocmds, clipboard, whitespace
lua/config/
  lazy.lua                      Plugin manager bootstrap
  keybindings.lua               Global keymaps (Lua execution, UI toggles, LSP info)
  plugins/
    lsp.lua                     Language server configs (native vim.lsp API)
    completion.lua              blink.cmp with snippet support
    conform.lua                 Format on save (Biome/Prettier/Stylua/rustfmt/gofmt)
    treesitter.lua              Syntax highlighting for 20+ languages
    snacks.lua                  Fuzzy finder, git browse, lazygit, zen mode
    harpoon.lua                 Quick file switching (with Snacks picker integration)
    mini.lua                    Statusline, file explorer, pairs, surround, textobjects
    colorscheme.lua             Gondolin (dark) + Melange (light), auto-switching
    gitsigns.lua                Git change indicators in the sign column
    which-key.lua               Keybinding discovery popup
    claudecode.lua              Claude Code terminal integration
    opencode.lua                OpenCode AI assistant
    clojure.lua                 Conjure REPL, paredit, rainbow delimiters
    markdown.lua                Rendered markdown preview in-buffer
    todo-comments.lua           Highlighted TODO/FIXME/HACK comments
after/queries/
  elixir/highlights.scm         Custom Elixir attribute highlighting
```

## Install

Back up any existing config first:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone and start Neovim:

```bash
git clone https://github.com/wunki/dot-nvim ~/.config/nvim
nvim
```

Plugins install automatically on first launch. Treesitter parsers download in the background.

## Dependencies

Language servers and formatters are installed globally, not managed by Neovim. The config skips any server whose binary isn't in your PATH, so install only what you need.

### Language servers

| Server                       | Languages  | Install                                                |
| ---------------------------- | ---------- | ------------------------------------------------------ |
| `lua-language-server`        | Lua        | `brew install lua-language-server`                     |
| `typescript-language-server` | JS/TS      | `npm install -g typescript-language-server typescript` |
| `svelte-language-server`     | Svelte     | `npm install -g svelte-language-server`                |
| `biome`                      | JS/TS/JSON | `npm install -g @biomejs/biome`                        |
| `clangd`                     | C/C++      | `brew install llvm` or `xcode-select --install`        |
| `gopls`                      | Go         | `go install golang.org/x/tools/gopls@latest`           |
| `rust-analyzer`              | Rust       | `rustup component add rust-analyzer`                   |
| `clojure-lsp`                | Clojure    | `brew install clojure-lsp/brew/clojure-lsp-native`     |

### Formatters

| Formatter     | Languages                            | Install                                              |
| ------------- | ------------------------------------ | ---------------------------------------------------- |
| `stylua`      | Lua                                  | `brew install stylua`                                |
| `prettierd`   | JS/TS/HTML/JSON/YAML/Markdown/Svelte | `npm install -g @fsouza/prettierd`                   |
| `goimports`   | Go                                   | `go install golang.org/x/tools/cmd/goimports@latest` |
| `rustfmt`     | Rust                                 | `rustup component add rustfmt`                       |
| `fish_indent` | Fish                                 | Included with Fish shell                             |

For Svelte formatting with Prettier:

```bash
npm install -g prettier-plugin-svelte
```

### Other tools

| Tool      | Purpose                            | Install                |
| --------- | ---------------------------------- | ---------------------- |
| `lazygit` | Git TUI (opened with `<leader>gg`) | `brew install lazygit` |

## Keybindings

Leader is `<Space>`. Local leader is `\`.

Keybindings are discoverable at runtime: press `<leader>` and wait for the which-key popup.

### Navigation and files

| Key          | Action                                    |
| ------------ | ----------------------------------------- |
| `<leader>ff` | Find files (respects `.gitignore`)        |
| `<leader>fF` | Find all files (including hidden/ignored) |
| `<leader>fg` | Grep across project                       |
| `<leader>fw` | Grep word under cursor                    |
| `<leader>fc` | Find Neovim config files                  |
| `<leader>fd` | Find dotfiles                             |
| `<leader>fh` | Search help tags                          |
| `<leader>fT` | Find TODO comments                        |
| `<C-b>`      | Toggle file explorer at current file      |
| `<leader>fm` | File explorer at working directory        |

### Harpoon (quick file switching)

| Key                | Action                     |
| ------------------ | -------------------------- |
| `<leader>ha`       | Add current file           |
| `<leader>hh`       | Open quick menu            |
| `<leader>hf`       | Fuzzy-find harpooned files |
| `<leader>h1`..`h5` | Jump to file 1-5           |

### LSP

| Key          | Action                          |
| ------------ | ------------------------------- |
| `gd`         | Go to definition (with preview) |
| `grn`        | Rename symbol                   |
| `gra`        | Code action                     |
| `grr`        | Find references                 |
| `gri`        | Go to implementation            |
| `grc`        | Incoming calls                  |
| `gO`         | Document symbols                |
| `<leader>ld` | Project diagnostics             |
| `<leader>lD` | Buffer diagnostics              |
| `<leader>li` | Show attached LSP clients       |
| `<leader>lr` | Restart LSP clients             |

### Git

| Key          | Action                                               |
| ------------ | ---------------------------------------------------- |
| `<leader>gg` | Open LazyGit                                         |
| `<leader>gy` | Open current line on GitHub (visual mode: selection) |

### AI assistants

| Key          | Action                               |
| ------------ | ------------------------------------ |
| `<leader>ac` | Toggle Claude Code terminal          |
| `<leader>as` | Send selection to Claude (visual)    |
| `<leader>ab` | Add current buffer to Claude context |
| `<leader>oo` | Toggle OpenCode                      |
| `<leader>oa` | Ask OpenCode about current file      |
| `<leader>os` | Select OpenCode action               |

### UI and utilities

| Key          | Action                      |
| ------------ | --------------------------- |
| `<Esc>`      | Clear search highlights     |
| `<leader>ul` | Toggle line numbers         |
| `<leader>ub` | Toggle statusline           |
| `<leader>uz` | Toggle zen mode             |
| `<leader>ur` | Reload colorscheme          |
| `<leader>x`  | Execute current line as Lua |
| `<leader>X`  | Source current file         |

## Design decisions

A few choices worth knowing about if you're borrowing from this config:

**No Mason.** Language servers and formatters live outside Neovim. This keeps the config simpler and avoids a second package manager. The tradeoff: you install tools yourself.

**No nvim-lspconfig.** Neovim 0.11+ has `vim.lsp.config()` and `vim.lsp.enable()` built in. The extra plugin layer isn't needed anymore. Each server is a table with `cmd`, `filetypes`, and `root_markers`.

**Snacks over Telescope.** The config uses `folke/snacks.nvim` for fuzzy finding, git browsing, lazygit, and zen mode. Fewer plugins, same coverage.

**blink.cmp over nvim-cmp.** Faster completion engine. The menu is configured to stay hidden until manually triggered, keeping the editing experience quiet.

**Mini.nvim for small utilities.** Statusline, file explorer, auto-pairs, surround, and textobjects all come from `mini.nvim` instead of five separate plugins.

## Customization

Add a plugin: create a file in `lua/config/plugins/` that returns a lazy.nvim spec table.

```lua
-- lua/config/plugins/example.lua
return {
  'author/plugin-name',
  event = 'BufRead',
  opts = {},
}
```

Add a language server: add an entry to the `servers` table in `lua/config/plugins/lsp.lua`.

```lua
your_server = {
  cmd = { 'your-server-binary', '--stdio' },
  filetypes = { 'your-filetype' },
  root_markers = { 'config-file', '.git' },
},
```

If the binary isn't found, the server is silently skipped.

## Requirements

- Neovim 0.12+ (uses native LSP APIs and `vim.lsp.config`)
- Terminal with 24-bit color support
- Git (for plugin installation)
