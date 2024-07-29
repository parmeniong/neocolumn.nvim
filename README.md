<div align="center">
    <h1>neocolumn.nvim</h1>
    <img src="https://img.shields.io/badge/version-v2.1.0-8A2BE2" />
    <img src="https://img.shields.io/badge/license-MIT-blue" />
</div>

**neocolumn.nvim** is a replacement for Neovim's builtin `colorcolumn`

![sample screenshot](https://github.com/user-attachments/assets/5a6bd46b-2aba-4b2e-b599-21ee7b8d8ead)

### Table of contents

* [Features](#features)
* [Installation](#installation)
* [Configuration](#configuration)

## Features

* Blazingly fast
* Diagnostics integration
* Use custom character as colorcolumn
* Modern style and look
* Show colorcolumn only if the current line length is close enough to it

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
        error = "#db4b4b",      -- the color of the neocolumn on lines with an error
        error_near = "#ad6565", -- the color of the neocolumn on lines next to a line with an error
        error_far = "#957171",  -- the color of the neocolumn on lines 2 lines away from a line with
                                -- an error
        warn = "#e0af68",       -- the color of the neocolumn on lines with a warning
        warn_near = "#af9672",  -- the color of the neocolumn on lines next to a line with a warning
        warn_far = "#968a78",   -- the color of the neocolumn on lines 2 lines away from a line with
                                -- a warning
        info = "#0db9d7",       -- the color of the neocolumn on lines with an info diagnostic
        info_near = "#459cab",  -- the color of the neocolumn on lines next to a line with an info
                                -- diagnostic
        info_far = "#618c94",   -- the color of the neocolumn on lines 2 lines away from a line with
                                -- an info diagostic
        hint = "#1abc9c",       -- the color of the neocolumn on lines with a hint diagnostic
        hint_near = "#4c9d8d",  -- the color of the neocolumn on lines next to a line with a hint
                                -- diagnostic
        hint_far = "#648d85",   -- the color of the neocolumn on lines 2 lines away from a line with
                                -- a hint diagnostic
        bg = "#303030",         -- the background color of the neocolumn
        cursor_bg = "#4d4d4d"   -- the background color of the neocolumn on the same line as the
                                -- cursor
    }
    -- neocolumn.nvim will be disabled in buffers with these filetypes
    exclude_filetypes = {
        "help",
        "man"
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
    max_distance = 0
}
```
