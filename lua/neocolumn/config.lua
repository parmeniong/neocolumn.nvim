local M = {}

---@class Config
---@field exclude_filetypes string[] Filetypes in which neocolumn will be disabled.
---@field diagnostics boolean If `true`, the neocolumn will be colored to display diagnostics.
---@field min_diagnostic_severity vim.diagnostic.Severity If diagnostics is `true`, only diagnostics
---with a severity equal to or greater than this will be displayed.
---@field max_line_length integer The maximum allowed length for lines. The neocolumn will be placed
---right after the last column of the maximum line length.

M.defaults = {
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
