local M = {}

M.defaults = {
    colors = {
        normal = "#7d7d7d",
        error = "#db4b4b",
        warn = "#e0af68",
        info = "#0db9d7",
        hint = "#1abc9c",
        bg = nil,
        cursor_bg = nil
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