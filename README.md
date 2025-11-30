# 🚀 Dot Neovim

A minimal yet powerful Neovim configuration focused on productivity and clean design.

## ✨ Features

- Lazy-loaded plugins for fast startup time
- Modern LSP integration for code intelligence
- Treesitter for improved syntax highlighting
- Fuzzy finding with Telescope
- File navigation with Harpoon and Mini.files
- Git integration with Lazygit
- Fast code formatting with Conform
- Which-key for discovering keybindings

## 🔧 Installation

1. Clone this repository to your Neovim config directory:

```bash
git clone https://github.com/yourusername/dot-nvim ~/.config/nvim
```

2. Start Neovim. Plugins will be automatically installed.

```bash
nvim
```

## 🌐 External Dependencies

This setup expects language servers and formatters to be installed globally.

### Language Servers

| Server | Languages | Install |
|--------|-----------|---------|
| lua-language-server | Lua | `brew install lua-language-server` |
| typescript-language-server | JS/TS | `npm install -g typescript-language-server typescript` |
| svelte-language-server | Svelte | `npm install -g svelte-language-server` |
| biome | JS/TS/JSON | `npm install -g @biomejs/biome` |
| clangd | C/C++ | `brew install llvm` or `xcode-select --install` |

### Formatters

| Formatter | Languages | Install |
|-----------|-----------|---------|
| stylua | Lua | `brew install stylua` |
| prettierd | JS/TS/HTML/JSON/YAML/Markdown/Svelte | `npm install -g @fsouza/prettierd` |
| shfmt | ZSH | `brew install shfmt` |
| fish_indent | Fish | Included with Fish shell |

For Svelte formatting with prettier, also install the plugin:
```bash
npm install -g prettier-plugin-svelte
```

## ⌨️ Key Bindings

### General

| Key | Description |
|-----|-------------|
| `<Esc>` | Clear search highlights |
| `<Space>ul` | Toggle line numbers |

### Lua Execution

| Key | Description |
|-----|-------------|
| `<Space>x` | Execute current line as Lua |
| `<Space>x` (visual) | Execute selection as Lua |
| `<Space><Space>x` | Source current file |

### File Navigation

| Key | Description |
|-----|-------------|
| `<Space>fm` | Open Mini.files file browser |
| `<Space>ft` | Find file in file tree |
| `<C-n>` | Toggle file tree |

### Telescope Fuzzy Finding

| Key | Description |
|-----|-------------|
| `<Space>ff` | Find files in current directory |
| `<Space>fc` | Find Neovim config files |
| `<Space>fd` | Find dotfiles |
| `<Space>fh` | Help tags |
| `<Space>fg` | Live grep in files |

### LSP (Code Intelligence)

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |
| `gO` | Document symbol |

### Harpoon (File Bookmarking)

| Key | Description |
|-----|-------------|
| `<leader>A` | Add file to harpoon |
| `<leader>a` | Toggle harpoon quick menu |
| `<leader>ft` | Find harpoon marks with Telescope |
| `<leader>1-5` | Jump to harpoon file 1-5 |

### Git Integration

| Key | Description |
|-----|-------------|
| `<leader>lg` | Open LazyGit |
| `<leader>gy` | Open current line in GitHub |
| `<leader>gy` (visual) | Open selected lines in GitHub |

### Code Completion

| Key | Description |
|-----|-------------|
| `<C-Space>` | Show completion menu |

## 🧩 Core Plugins

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion plugin
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [harpoon](https://github.com/ThePrimeagen/harpoon) - File navigation
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper
- [mini.nvim](https://github.com/echasnovski/mini.nvim) - Collection of small plugins
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Git integration
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Code formatting
- [gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim) - GitHub integration

## 📝 Customization

Most configuration files are in the `lua/config/plugins/` directory. Add new plugins or modify existing ones by editing these files.

## 🔄 Updates

Pull the latest changes from the repository to update:

```bash
cd ~/.config/nvim
git pull
```

---

💡 This configuration is maintained and optimized for personal use. Feel free to fork and customize to suit your needs!