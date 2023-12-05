<!-- markdownlint-disable MD033 MD041 -->
<div align="center">
    <img src="./assets/logo.svg">
    <h3>nvim-emmet</h3>
    <p>A plugin that adds integration between Neovim and <a href="https://github.com/olrtg/emmet-language-server" target="_blank">emmet-language-server</a>.</p>
</div>

---

### Features

> [!NOTE]
> If you have an idea of a possible feature, let me know with an issue.

- Wrap in normal, visual and visual block mode with emmet abbreviation.

### Installation

> [!WARNING]
> This plugin requires [emmet-language-server](https://github.com/olrtg/emmet-language-server) (v2.2.0 and above) so make sure you have it setup correctly first.

**[lazy.nvim](https://github.com/folke/lazy.nvim)**

```lua
{
  "olrtg/nvim-emmet",
  config = function()
    vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
  end,
},
```
