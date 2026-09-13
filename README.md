# configs

Personal configuration files and setup scripts.

This branch contains my **Neovim configuration** and is intended for **Neovim versions older than 0.11.3**.

> **Current version:** If you are using a recent Neovim release, see the [`main` branch](../../tree/main) instead. The `main` configuration has been updated for modern Neovim and includes LSP-based autocomplete, snippets, formatting, and additional development tooling.

---

# Neovim Configuration

The `nvim/` directory contains a modular Lua-based Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as its plugin manager.

The configuration is deliberately simple and focuses on providing a comfortable editing environment without introducing a large number of plugins.

## Features

* `lazy.nvim` plugin management
* TokyoNight colorscheme
* Transparent editor background
* Lualine statusline
* Tree-sitter syntax highlighting
* Telescope fuzzy finding
* Git integration
* OSC 52 clipboard support
* CSS color highlighting
* Relative and absolute line numbers
* Cursor-line highlighting
* Four-space indentation
* Custom leader-key mappings

---

## Plugins

### Plugin Manager

#### [lazy.nvim](https://github.com/folke/lazy.nvim)

Used to install and manage all Neovim plugins.

The configuration automatically bootstraps `lazy.nvim` if it is not already installed.

---

### Appearance

#### [TokyoNight](https://github.com/folke/tokyonight.nvim)

Used as the primary colorscheme.

The configuration also removes the background from the normal editor area to provide a transparent appearance.

#### [Lualine](https://github.com/nvim-lualine/lualine.nvim)

Provides the statusline.

Lualine is configured to use the TokyoNight theme and depends on [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) for file-type icons.

---

### Navigation and Search

#### [Telescope](https://github.com/nvim-telescope/telescope.nvim)

Provides fuzzy finding and searching functionality.

The configuration currently pins Telescope to version `0.1.8`.

It provides shortcuts for:

| Key          | Function           |
| ------------ | ------------------ |
| `<leader>ff` | Find files         |
| `<leader>fg` | Live grep          |
| `<leader>fb` | List buffers       |
| `<leader>fh` | Search Neovim help |

Telescope uses [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) as a dependency.

---

### Syntax Highlighting

#### [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Tree-sitter is used for syntax parsing and highlighting.

The configured languages are:

* Lua
* C
* C++
* JavaScript
* TypeScript
* TSX
* HTML
* CSS

The configuration uses the older `nvim-treesitter.configs` interface:

```lua
require("nvim-treesitter.configs").setup(...)
```

and runs `:TSUpdate` as its build step.

---

### Git

#### [vim-fugitive](https://github.com/tpope/vim-fugitive)

Provides Git integration directly inside Neovim.

---

### Clipboard

#### [vim-oscyank](https://github.com/ojroques/vim-oscyank)

Provides OSC 52 clipboard support.

This is particularly useful when working through SSH or terminal environments where directly accessing the local system clipboard may not otherwise work.

---

### CSS Color Highlighting

#### [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)

Displays CSS color values visually inside the editor.

---

# Autocomplete

## Limitations of This Configuration

This branch **does not provide a dedicated language-aware autocomplete system**.

In particular, it does **not** contain:

* `nvim-cmp`
* `cmp-nvim-lsp`
* LuaSnip
* Language servers
* Mason
* `nvim-lspconfig`

Tree-sitter should also not be confused with autocomplete.

Tree-sitter provides **syntax parsing and highlighting**, but it does not by itself provide IDE-style semantic completion.

Therefore, this configuration does **not** provide the kind of completion where the editor understands things such as:

```text
object.method
module.function
Class.member
function arguments
types
imports
```

or provides language-server-powered suggestions and documentation.

Any completion available here is limited to Neovim's existing/built-in completion mechanisms and whatever functionality individual plugins or editing modes provide.

---

## Autocomplete in `main`

The [`main` branch](../../tree/main) expands this considerably for modern Neovim versions.

It uses:

* `nvim-cmp` — completion engine
* `cmp-nvim-lsp` — LSP completion source
* `cmp-buffer` — buffer completion
* `cmp-path` — filesystem path completion
* LuaSnip — snippets
* friendly-snippets — predefined snippets
* Language servers through Mason and `nvim-lspconfig`

The current language-server configuration includes:

| Language                      | Language Server |
| ----------------------------- | --------------- |
| Lua                           | `lua_ls`        |
| C / C++                       | `clangd`        |
| JavaScript / TypeScript / TSX | `ts_ls`         |
| HTML                          | `html`          |
| CSS                           | `cssls`         |
| Python                        | `pyright`       |

This gives the `main` configuration significantly more IDE-like completion and language intelligence.

The `deprecs` branch intentionally remains a simpler configuration for older Neovim versions.

---

# Editor Options

The configuration enables:

```text
Absolute line numbers
Relative line numbers
Cursor-line highlighting
4-space indentation
```

These are defined in:

```text
nvim/lua/config/options.lua
```

---

# Keybindings

The leader key is:

```text
Space
```

## File Explorer

| Key          | Action     |
| ------------ | ---------- |
| `<leader>cd` | Open `:Ex` |

## Telescope

| Key          | Action           |
| ------------ | ---------------- |
| `<leader>ff` | Find files       |
| `<leader>fg` | Live grep        |
| `<leader>fb` | List buffers     |
| `<leader>fh` | Search help tags |

---

# Repository Structure

```text
configs/
└── nvim/
    ├── init.lua
    ├── lazy-lock.json
    ├── lua/
    │   ├── config/
    │   │   ├── keybinds.lua
    │   │   ├── lazy.lua
    │   │   └── options.lua
    │   │
    │   └── plugins/
    │       ├── colors.lua
    │       ├── oneliners.lua
    │       ├── telescope.lua
    │       └── treesitter.lua
    │
    └── ...
```

---

# Configuration Files

## `nvim/init.lua`

The main entry point of the Neovim configuration.

It loads:

```lua
require('config.options')
require('config.keybinds')
require('config.lazy')
require('plugins.treesitter')
require('plugins.telescope')
```

This keeps the configuration separated into logical modules.

---

## `nvim/lua/config/options.lua`

Contains general editor options.

Currently:

```lua
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
```

---

## `nvim/lua/config/keybinds.lua`

Defines global keybindings.

It:

* Sets Space as the leader key.
* Maps `<leader>cd` to Neovim's `:Ex` file explorer.

---

## `nvim/lua/config/lazy.lua`

Bootstraps and configures `lazy.nvim`.

If `lazy.nvim` does not exist in Neovim's data directory, it is cloned automatically.

Plugin specifications are imported from:

```text
lua/plugins/
```

The configuration also enables automatic update checking while disabling change-detection notifications.

---

## `nvim/lua/plugins/colors.lua`

Contains the visual configuration.

It configures:

* TokyoNight
* Transparent background
* Lualine
* nvim-web-devicons

---

## `nvim/lua/plugins/oneliners.lua`

Contains miscellaneous standalone plugins:

* `vim-oscyank`
* `vim-fugitive`
* `nvim-highlight-colors`

These plugins do not require large configuration blocks, so they are grouped together here.

---

## `nvim/lua/plugins/telescope.lua`

Configures Telescope and its keybindings.

The mappings are:

```text
<leader>ff → Find files
<leader>fg → Live grep
<leader>fb → Buffers
<leader>fh → Help tags
```

---

## `nvim/lua/plugins/treesitter.lua`

Configures Tree-sitter syntax highlighting and parser installation.

Supported languages:

```text
lua
c
cpp
javascript
typescript
tsx
html
css
```

---

## `nvim/lazy-lock.json`

The `lazy.nvim` lockfile.

It records the specific plugin revisions used by the configuration, allowing the environment to be reproduced with known plugin versions.

---

# Installation

Clone the repository:

```bash
git clone <repository-url>
cd configs
```

Switch to this branch:

```bash
git checkout deprecs
```

Place the Neovim configuration in:

```text
~/.config/nvim
```

For example:

```bash
ln -s "$(pwd)/nvim" ~/.config/nvim
```

Then launch:

```bash
nvim
```

`lazy.nvim` will automatically bootstrap itself if it is not already installed.

---

# Neovim Compatibility

This branch targets:

```text
Neovim < 0.11.3
```

It is maintained primarily for compatibility with older Neovim installations.

If you are installing Neovim today, the recommended configuration is the one in the **`main` branch**.

---

# `main` vs `deprecs`

|                  | `deprecs`               | `main`                               |
| ---------------- | ----------------------- | ------------------------------------ |
| Target           | Neovim `< 0.11.3`       | Modern Neovim                        |
| Tree-sitter      | Older configuration API | Updated configuration                |
| LSP              | Not configured          | Configured                           |
| Language servers | None                    | Lua, C/C++, JS/TS, HTML, CSS, Python |
| LSP autocomplete | ❌                       | ✅                                    |
| `nvim-cmp`       | ❌                       | ✅                                    |
| Snippets         | ❌                       | ✅ LuaSnip                            |
| Mason            | ❌                       | ✅                                    |
| Formatting       | ❌                       | ✅ Conform                            |
| Autopairs        | ❌                       | ✅                                    |
| Telescope        | ✅                       | ✅                                    |
| Tree-sitter      | ✅                       | ✅                                    |
| Git              | ✅                       | ✅                                    |
| TokyoNight       | ✅                       | ✅                                    |

The `deprecs` branch is therefore the **older, lightweight configuration**, while `main` is the actively expanded configuration for newer Neovim releases.

---

# License

No license has currently been specified for this repository.
