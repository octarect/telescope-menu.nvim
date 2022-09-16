# telescope-menu.nvim

[![CI](https://github.com/octarect/telescope-menu.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/octarect/telescope-menu.nvim/actions/workflows/ci.yml)

`telescope-menu.nvim` is an extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) which provides custom menus.

## Getting started

### Dependencies

- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Installation

Using [dein.vim](https://github.com/Shougo/dein.vim)

```lua
call dein#add('nvim-telescope/telescope.nvim')
call dein#add('octarect/telescope-menu.nvim')
```

if using TOML,

```toml
[[plugins]]
repo = 'nvim-telescope/telescope.nvim'

[[plugins]]
repo = 'octarect/telescope-menu.nvim'
```

## Usage

### Configuration

```lua
require("telescope").setup {
  extensions = {
    menu = {
      default = {
        items = {
          { display = "Show LSP Info", value = "LspInfo" },
          { display = "Files", value = "Telescope find_files" },
          { display = "Change colorscheme", value = "Telescope colorscheme" },
        },
      },
    },
  },
}

require("telescope").load_extension "menu"
```

### Run

Run `Telescope menu` or `lua require("telescope").extensions.menu.menu()`

### CHANGELOG

**v0.1.0**

- [x] Basic features (Open a custom menu by `Telescope menu`)
- [x] CI for automated test
