local M = {}

M.defaults = {
    colors = {
        normal = "#7d7d7d",
        error = "#db4b4b",
        error_near = "#ad6565",
        error_far = "#957171",
        warn = "#e0af68",
        warn_near = "#af9672",
        warn_far = "#968a78",
        info = "#0db9d7",
        info_near = "#459cab",
        info_far = "#618c94",
        hint = "#1abc9c",
        hint_near = "#4c9d8d",
        hint_far = "#648d85",
        bg = "#303030",
        cursor_bg = "#4d4d4d"
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
