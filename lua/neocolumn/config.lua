local M = {}

local function hex(n)
    return string.format("#%06x", n)
end

local function bg(n)
    local color = vim.api.nvim_get_hl(0, { name = n })
    return hex(color.bg)
end

M.defaults = {
    colors = {
        normal = "#7d7d7d",
        error = "#db4b4b",
        warn = "#e0af68",
        info = "#0db9d7",
        hint = "#1abc9c",
        bg = bg("Normal"),
        cursor_bg = bg("CursorLine")
    },
    exclude_filetypes = {
        "help",
        "man"
    },
    diagnostics = true,
    min_diagnostic_severity = vim.diagnostic.severity.HINT,
    max_line_length = 100,
    character = "│",
    max_distance = 0
}

function M.set(opts)
    M.opts = vim.tbl_deep_extend("force", M.defaults, opts)
end

return M