<h1 align="center">
  neocolumn.nvim<br />
  <img src="https://img.shields.io/github/v/release/parmeniong/neocolumn.nvim?style=for-the-badge&labelColor=%2332344A&color=%23AD8EE6" />
  <img src="https://img.shields.io/github/license/parmeniong/neocolumn.nvim?style=for-the-badge&labelColor=%2332344A&color=%237AA2F7" />
  <img src="https://img.shields.io/github/last-commit/parmeniong/neocolumn.nvim?style=for-the-badge&labelColor=%2332344A&color=%239ECE6A" />
</h1>

**neocolumn.nvim** is a replacement for Neovim's builtin `colorcolumn`

**Note**: This repository has been archived as the plugin had multiple bugs and I lost interest in maintaining and updating it.

![sample screenshot](
  https://github.com/user-attachments/assets/5a6bd46b-2aba-4b2e-b599-21ee7b8d8ead
)

### Table of contents

* [Features](#features)
* [Installation](#installation)
* [Configuration](#configuration)

## Features

* Blazingly fast
* Diagnostics integration
* Use custom character as colorcolumn
* Modern style and look
* Show colorcolumn only if the current line is close to it

## Installation

Install **neocolumn.nvim** using your favorite plugin manager.

### lazy.nvim

```lua
{ "parmeniong/neocolumn.nvim" }
```

### packer.nvim

```lua
use "parmeniong/neocolumn.nvim"
```

### vim-plug

```vim
Plug "parmeniong/neocolumn.nvim"
```

## Configuration

To start **neocolumn.nvim** use:

```lua
require("neocolumn").setup({})
```

Instead of an empty table you can use a table with the options you want to change.
Here are the available options and their default values:

```lua
{
    -- these colors will be used on the neocolumn
    colors = {
        normal = "#7d7d7d",     -- the color of the neocolumn
        error = "#db4b4b",      -- the color of the neocolumn to display errors
        warn = "#e0af68",       -- the color of the neocolumn to display warnings
        info = "#0db9d7",       -- the color of the neocolumn info diagnostics
        hint = "#1abc9c",       -- the color of the neocolumn hint diagnostics
        bg = nil,               -- the background color of the neocolumn. Set to nil to use whatever
                                -- color happens to be behind the neocolumn
        cursor_bg = nil         -- the background color of the neocolumn on the same line as the
                                -- cursor. Set to nil to use whatever color happens to be behind the
                                -- neocolumn
    }
    -- neocolumn.nvim will be disabled in buffers with these filetypes
    exclude_filetypes = {
        "help",
        "man"
    },
    -- neocolumn.nvim will be disabled in buffers with these buftypes
    exclude_buftypes = {
        "terminal"
    },
    -- When enabled, the neocolumn will be colored depending on each line's diagnostics
    diagnostics = true,
    -- If `diagnostics` is `true` then diagnostic with a severity lower than this will be ignored
    min_diagnostic_severity = vim.diagnostic.severity.HINT,
    -- The maximum allowed length for a line. The neocolumn will be placed one column to the right
    max_line_length = 100,
    -- The character use as the neocolumn
    character = "│",
    -- The neocolumn will be shown only if the length of the current line is this close to it
    -- zero will make the neocolumn always visible
    max_distance = 0
}
```
