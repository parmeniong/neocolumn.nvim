local M = {}

---@class Config
---@field exclude_filetypes string[] Filetypes in which neocolumn will be disabled.
---@field diagnostics boolean If `true`, the neocolumn will be colored to display diagnostics.
---@field min_diagnostic_severity vim.diagnostic.Severity If diagnostics is `true`, only diagnostics
---with a severity equal to or greater than this will be displayed.
---@field max_line_length integer The maximum allowed length for lines. The neocolumn will be placed
---right after the last column of the maximum line length.

M.defaults = {
    colors = {
        normal = "#7d7d7d",
        error = "#db4b4b",
        error_near = "#7c343a",
        error_far = "#4b2830",
        warn = "#e0af68",
        warn_near = "#7e6647",
        warn_far = "#4c4137",
        info = "#0db9d7",
        info_near = "#146b80",
        info_far = "#184454",
        hint = "#1abc9c",
        hint_near = "#1b6c62",
        hint_far = "#1b4444",
        bg = "#303030",
        cursor_bg = "#4d4d4d"
    },
    exclude_filetypes = {
        "help",
        "man"
    },
    diagnostics = true,
    min_diagnostic_severity = vim.diagnostic.severity.HINT,
    max_line_length = 100
}

function M.set(opts)
    M.opts = vim.tbl_deep_extend("force", M.defaults, opts)
end

return M
