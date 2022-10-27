# telescope-menu.nvim

[![CI](https://github.com/octarect/telescope-menu.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/octarect/telescope-menu.nvim/actions/workflows/ci.yml)

`telescope-menu.nvim` is an extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) which provides custom menus.

## Getting Started

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

### Example Configuration

```lua
require("telescope").setup {
  extensions = {
    menu = {
      default = {
        items = {
          { "Checkhealth", "checkhealth" },
          { "Show LSP Info", "LspInfo" },
          { "Files", "Telescope find_files" },

          -- The above examples are syntax-sugars of the following;
          { display = "Change colorscheme", value = "Telescope colorscheme" },
        },
      },
    },
  },
}

require("telescope").load_extension "menu"
```

### Run

Run `Telescope menu` to open the menu `default`.

### Default Mappings

| Mappings | Action            |
|:---------|:------------------|
| `<CR>`   | Confirm selection |

### Pickers

| Vim Command                   | Lua                                                   | Description                 |
|:------------------------------|:------------------------------------------------------|:----------------------------|
| `:Telescope menu`             | `:lua require"telescope".extensions.menu.menu{}`      | Open default menu           |
| `:Telescope menu filetype`         | `lua require"telescope".extensions.menu.filetype{}`     | Open filetype-specific menu |
| `:Telescope menu <menu_name>` | `:lua require"telescope".extensions.menu.<menu_name>{}` | Open <menu_name>            |

## Configuration

### Multiple menus

Defining multiple menus is supported. Menus except for `default` is opened by `Telescope menu <menu_name>`.

For example, you can have another menu named `editor` by the following config;

```lua
{
  extensions = {
    menu = {
      default = {
        items = {
          -- Jump to another menu
          { "Editor", "Telescope menu editor" },
        },
      },
      -- `editor` is an example, and you can name it as you like.
      editor = {
        items = {
          { "Split window vertically", "vsplit" },
          { "Split window horizontally", "split" },
          { "Write", "w" },
        },
      },
    },
  },
}
```

Then, you can open the menu by

- ExCommand: `Telescope menu editor`
- Lua: `require("telescope").extensions.menu.editor()`

### Filetype-specific menu

You can define menu for a particular filetype, and open them by `Telescope menu filetype`.

Example:

```lua
{
  extensions = {
    menu = {
      filetype = {
        lua = {
          items = {
            { "Format", "!stylua %" },
            { "Open Luadev menu", "Luadev" },
            { "Execute a current buffer", "LuaRun" },
          },
        },
        -- Format
        -- <filetype> = {
        --   items = {
        --     -- your favorite commands
        --   }
        -- }
      }
    },
  },
}
```

## Contributing

Any pull requests are welcome. We consider you have granted non-exclusive right to your contributed code under [MIT License](https://github.com/octarect/telescope-menu.nvim/blob/master/LICENSE). Use http://github.com/octarect/telescope-menu.nvim/issues for discussion.

### CHANGELOG

**v0.1.0**

- [x] Basic features (Open a custom menu by `Telescope menu`)
- [x] CI for automated test
