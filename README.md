# configs

My personal configuration files and setup scripts.

Currently, the repository contains a **Neovim configuration** under `nvim/`. The `main` branch targets modern Neovim releases using the current `vim.lsp.config()` / `vim.lsp.enable()` LSP interface.

> **Note:** The repository also has a `deprecs` branch containing an `nvim/` directory with configurations intended for **Neovim < 0.11.3**. This README documents the configuration on the `main` branch only.

---

## Neovim

The configuration is written in Lua and uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

### Features

- Lazy-loaded plugin management
- TokyoNight colorscheme with transparent background
- Lualine statusline
- Tree-sitter syntax highlighting
- Telescope fuzzy finding
- LSP support for Lua, C/C++, JavaScript/TypeScript, HTML, CSS, and Python
- `nvim-cmp` completion with LuaSnip snippets
- Automatic bracket/parenthesis/quote closing
- Conform-based formatting
- Ruff formatting for Python
- Prettier formatting for JavaScript/TypeScript/HTML/CSS
- Clang-format formatting for C/C++
- Stylua formatting for Lua
- Git integration through Fugitive
- OSC 52 clipboard support through `vim-oscyank`
- CSS color highlighting
- Useful file-explorer and Telescope shortcuts

---

## Plugins

### Core / UI

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File-type icons |

TokyoNight is configured with a transparent `Normal` background, and Lualine uses the TokyoNight theme.

### Navigation / Search

| Plugin | Purpose |
|---|---|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finding and search |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Telescope dependency |

Telescope is pinned to version `0.1.8` in the configuration.

### Syntax

| Plugin | Purpose |
|---|---|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing and highlighting |

The configured Tree-sitter languages are:

- Lua
- C
- C++
- JavaScript
- TypeScript
- TSX
- HTML
- CSS
- Python

Tree-sitter is configured with `:TSUpdate` as its build step.

### Completion / Snippets

| Plugin | Purpose |
|---|---|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer completion |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Filesystem path completion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip completion source |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Predefined snippets |

Completion sources currently include LSP, LuaSnip, the current buffer, and filesystem paths.

### Automatic Pairing

| Plugin | Purpose |
|---|---|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Automatically closes brackets, parentheses, and quotes |

`nvim-autopairs` is integrated with `nvim-cmp` so completion confirmation works correctly with automatic pairing.

### LSP

| Plugin | Purpose |
|---|---|
| [mason.nvim](https://github.com/mason-org/mason.nvim) | External tool/package manager |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Mason ↔ lspconfig integration |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | Completion capabilities for LSP |

The configured language servers are:

| Language | Language Server |
|---|---|
| Lua | `lua_ls` |
| C / C++ | `clangd` |
| JavaScript / TypeScript / TSX | `ts_ls` |
| HTML | `html` |
| CSS | `cssls` |
| Python | `pyright` |

The configuration uses the modern Neovim LSP API:

```lua
vim.lsp.config(...)
vim.lsp.enable(...)
```

Mason-LSPconfig is configured to ensure these language servers are installed.

### Formatting

| Plugin | Purpose |
|---|---|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter management |

Configured formatters:

| Filetype | Formatter |
|---|---|
| Lua | `stylua` |
| Python | `ruff_format` |
| JavaScript | `prettier` |
| TypeScript | `prettier` |
| JavaScript React | `prettier` |
| TypeScript React | `prettier` |
| HTML | `prettier` |
| CSS | `prettier` |
| C | `clang-format` |
| C++ | `clang-format` |

Formatting is **manual**, rather than automatic on save.

The configured formatting shortcut is:

```text
<leader>f
```

It formats the current file, or a selected range when used in Visual mode.

### Other Plugins

| Plugin | Purpose |
|---|---|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |
| [vim-oscyank](https://github.com/ojroques/vim-oscyank) | OSC 52 clipboard support |
| [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | Displays CSS color values visually |

---

## Keybindings

The leader key is set to **Space**.

### File Explorer

| Key | Action |
|---|---|
| `<leader>cd` | Open `:Ex` |

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>fh` | Search help tags |

### Completion

| Key | Action |
|---|---|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selected completion |
| `<Tab>` | Select next completion / expand or jump through snippet |
| `<S-Tab>` | Select previous completion / jump backward through snippet |
| `<C-e>` | Abort completion |

### Formatting

| Key | Action |
|---|---|
| `<leader>f` | Format file or selection |

---

## Repository Structure

```text
configs/
└── nvim/
    ├── init.lua
    ├── install_deps.sh
    ├── lazy-lock.json
    ├── lua/
    │   ├── config/
    │   │   ├── keybinds.lua
    │   │   ├── lazy.lua
    │   │   └── options.lua
    │   │
    │   └── plugins/
    │       ├── colors.lua
    │       ├── completions.lua
    │       ├── formatter.lua
    │       ├── lsp.lua
    │       ├── oneliners.lua
    │       ├── telescope.lua
    │       └── treesitter.lua
    │
    └── nvim.log
```

### `nvim/init.lua`

The main entry point of the configuration.

It loads:

- `config.options`
- `config.keybinds`
- `config.lazy`
- the Tree-sitter plugin configuration
- the Telescope plugin configuration

Plugin specifications under `lua/plugins/` are discovered through the `lazy.nvim` import mechanism.

### `nvim/lua/config/options.lua`

Contains general Neovim editor options.

Currently configured options include:

- Absolute line numbers
- Relative line numbers
- Cursor line highlighting
- Four-space indentation width

### `nvim/lua/config/keybinds.lua`

Defines global keybindings and sets the leader key to Space.

Currently it contains the file-explorer shortcut:

```text
<leader>cd → :Ex
```

### `nvim/lua/config/lazy.lua`

Bootstraps `lazy.nvim` if it is not already installed, prepends it to the runtime path, and loads plugin specifications from the `plugins` namespace.

It also enables automatic plugin update checking while disabling change-detection notifications.

### `nvim/lua/plugins/colors.lua`

Configures:

- TokyoNight
- Transparent background
- Lualine
- nvim-web-devicons

TokyoNight is selected as the active colorscheme.

### `nvim/lua/plugins/completions.lua`

Configures `nvim-cmp` and its completion sources.

It also configures LuaSnip expansion and the completion/snippet keybindings.

### `nvim/lua/plugins/formatter.lua`

Configures `conform.nvim`.

It maps filetypes to their formatters and defines `<leader>f` as the manual formatting shortcut.

### `nvim/lua/plugins/lsp.lua`

Configures Mason, Mason-LSPconfig, and Neovim's LSP support.

The file enables:

```text
lua_ls
clangd
ts_ls
html
cssls
pyright
```

It also passes `nvim-cmp` capabilities to the language servers.

### `nvim/lua/plugins/oneliners.lua`

Contains miscellaneous standalone plugins/configuration, including:

- `vim-oscyank`
- `vim-fugitive`
- `nvim-highlight-colors`
- `nvim-autopairs`

The autopairs configuration is integrated with `nvim-cmp`.

### `nvim/lua/plugins/telescope.lua`

Configures Telescope and its basic navigation shortcuts:

```text
<leader>ff
<leader>fg
<leader>fb
<leader>fh
```

### `nvim/lua/plugins/treesitter.lua`

Configures Tree-sitter syntax highlighting and specifies the supported parsers.

The current configuration targets:

```text
lua
c
cpp
javascript
typescript
tsx
html
css
python
```

### `nvim/install_deps.sh`

Bootstrap script for installing external dependencies required by the Neovim environment.

See the script itself for the exact installation commands and dependency set.

### `nvim/lazy-lock.json`

The lazy.nvim lockfile.

It records the plugin revisions used by the configuration so that plugin versions can be reproduced consistently.

### `nvim/nvim.log`

Neovim log output generated during use/debugging. It is not part of the configuration logic itself.

---

## Installation

Clone the repository:

```bash
git clone <repository-url>
cd configs
```

Enter the Neovim configuration:

```bash
cd nvim
```

Run the dependency installer:

```bash
chmod +x install_deps.sh
./install_deps.sh
```

Then place/symlink the `nvim` directory at:

```text
~/.config/nvim
```

For example:

```bash
ln -s "$(pwd)" ~/.config/nvim
```

Start Neovim:

```bash
nvim
```

`lazy.nvim` will bootstrap itself if necessary and load the plugins specified under `lua/plugins/`.

---

## Supported Languages

The current configuration provides syntax highlighting, LSP support, completion, and/or formatting for:

- **Lua**
- **C**
- **C++**
- **Python**
- **JavaScript**
- **TypeScript**
- **TSX / React**
- **HTML**
- **CSS**

The exact capabilities depend on the corresponding Tree-sitter parser, language server, completion source, and formatter configured for each language.

---

## Branches

### `main`

Contains the current Neovim configuration using the modern Neovim LSP interface.

### `deprecs`

Contains the older `nvim/` configuration intended for:

```text
Neovim < 0.11.3
```

The `deprecs` branch is retained for compatibility with older Neovim installations. It is not documented in detail here.

---

## License

No license has currently been specified for this repository.
