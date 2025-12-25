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

Leader key is `<Space>`. All bindings below use `<leader>` prefix unless otherwise noted.

### General

| Key | Description |
|-----|-------------|
| `<Esc>` | Clear search highlights |
| `<leader>x` | Execute current line as Lua |
| `<leader>x` (visual) | Execute selection as Lua |
| `<leader>X` | Source current file |
| `<leader>R` | Reload entire config |

### UI Toggles (`<leader>u`)

| Key | Description |
|-----|-------------|
| `<leader>ul` | Toggle line numbers |
| `<leader>ub` | Toggle statusline |
| `<leader>us` | Toggle colorscheme (dark/light) |

### Find (`<leader>f`)

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find git files |
| `<leader>fF` | Find all files |
| `<leader>fc` | Find config files |
| `<leader>fd` | Find dotfiles |
| `<leader>fg` | Find by grep |
| `<leader>fh` | Find help tags |
| `<leader>fs` | Find colorscheme |

### Harpoon (`<leader>h`)

| Key | Description |
|-----|-------------|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Quick menu |
| `<leader>hf` | Find marks |
| `<leader>h1-5` | Go to file 1-5 |

### Git (`<leader>g`)

| Key | Description |
|-----|-------------|
| `<leader>gg` | LazyGit |
| `<leader>gy` | Open line in GitHub |
| `<leader>gy` (visual) | Open selection in GitHub |

### LSP (`<leader>l` and `g` prefix)

| Key | Description |
|-----|-------------|
| `<leader>li` | Show attached LSP clients |
| `gd` | Go to definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |
| `gO` | Document symbols |

### Opencode (`<leader>o`)

| Key | Description |
|-----|-------------|
| `<leader>oo` | Toggle opencode |
| `<leader>oa` | Ask opencode |
| `<leader>os` | Select opencode action |
| `<leader>op` | Add to opencode prompt |
| `<leader>od` | Explain diagnostics |

### File Navigation

| Key | Description |
|-----|-------------|
| `<C-b>` | Toggle file tree |

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