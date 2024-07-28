<div align="center">
    <h1>neocolumn.nvim</h1>
    <img src="https://img.shields.io/badge/version-v1.0.0-8A2BE2" />
    <img src="https://img.shields.io/badge/license-MIT-blue" />
</div>

**neocolumn.nvim** is a replacement for Neovim's builtin `colorcolumn`

![sample screenshot](https://github.com/user-attachments/assets/cbe0e6c8-ce19-4dbf-b34f-f769774a1d94)

### Table of contents

* [Features](#features)
* [Installation](#installation)
* [Configuration](#configuration)
* [Highlighting](#highlighting)

## Features

* Blazingly fast
* Diagnostics integration
* Use custom character for colorcolumn

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
These are the available options and their default values:

```lua
{
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
    max_line_length = 100
}
```

## Highlighting

**neocolumn.nvim** uses the following highlight groups:

* Neocolumn: The neocolumn
* NeocolumnCursor: The neocolumn on the same line as the cursor

The rest are variants of these used for diagnostics e.g `NeocolumnError`, `NeocolumnCursorWarn`
