<!-- markdownlint-disable MD033 MD041-->
<h3 align="center">
  nvim-emmet
</h3>

<p align="center">
  A plugin that adds integration between Neovim and olrtg/emmet-language-server.
</p>

# Features

- Wrap in normal, visual and visual block mode with emmet abbreviation.

# Installation

**[lazy.nvim](https://github.com/folke/lazy.nvim)**

```lua
{
  "olrtg/nvim-emmet",
  config = function()
    vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
  end,
},
```
