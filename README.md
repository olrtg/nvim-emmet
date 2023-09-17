<!-- markdownlint-disable MD033 MD041 -->
<div align="center">
    <img src="./assets/logo.svg">
    <h3>nvim-emmet</h3>
    <p>A plugin that adds integration between Neovim and <a href="https://github.com/olrtg/emmet-language-server" target="_blank">emmet-language-server</a>.</p>
</div>

---

### Features

- Wrap in normal, visual and visual block mode with emmet abbreviation.

### Installation

**[lazy.nvim](https://github.com/folke/lazy.nvim)**

```lua
{
  "olrtg/nvim-emmet",
  config = function()
    vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
  end,
},
```
