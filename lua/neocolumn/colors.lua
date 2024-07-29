local M = {}

function M.set_colors(colors, ns)
    vim.api.nvim_set_hl(ns, "Neocolumn", {
        fg = colors.normal,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnError", {
        fg = colors.error,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnWarn", {
        fg = colors.warn,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnInfo", {
        fg = colors.info,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnHint", {
        fg = colors.hint,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnErrorNear", {
        fg = colors.error_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnErrorFar", {
        fg = colors.error_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnWarnNear", {
        fg = colors.warn_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnWarnFar", {
        fg = colors.warn_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnInfoNear", {
        fg = colors.info_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnInfoFar", {
        fg = colors.info_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnHintNear", {
        fg = colors.hint_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnHintFar", {
        fg = colors.hint_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursor", {
        fg = colors.normal,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorError", {
        fg = colors.error,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorWarn", {
        fg = colors.warn,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorInfo", {
        fg = colors.info,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorHint", {
        fg = colors.hint,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorErrorNear", {
        fg = colors.error_near,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorErrorFar", {
        fg = colors.error_far,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorWarnNear", {
        fg = colors.warn_near,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorWarnFar", {
        fg = colors.warn_far,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorInfoNear", {
        fg = colors.info_near,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorInfoFar", {
        fg = colors.info_far,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorHintNear", {
        fg = colors.hint_near,
        bg = colors.cursor_bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnCursorHintFar", {
        fg = colors.hint_far,
        bg = colors.cursor_bg
    })
end

return M
