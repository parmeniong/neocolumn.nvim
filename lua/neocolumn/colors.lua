local M = {}

---@class RGB
---@field r integer
---@field g integer
---@field b integer

---@param hex string
---@return RGB
local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return {
        r = tonumber("0x" .. hex:sub(1, 2)),
        g = tonumber("0x" .. hex:sub(3, 4)),
        b = tonumber("0x" .. hex:sub(5, 6))
    }
end

---@param rgb RGB
---@return string
local function rgb_to_hex(rgb)
    return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

---@param ... RGB
---@return RGB
local function mix_rgb(...)
    local args = {...}

    local out = { r = 0, g = 0, b = 0 }

    for _, color in pairs(args) do
        out = {
            r = out.r + color.r / #args,
            g = out.g + color.g / #args,
            b = out.b + color.b / #args
        }
    end

    out.r = math.floor(out.r + 0.5)
    out.g = math.floor(out.g + 0.5)
    out.b = math.floor(out.b + 0.5)

    return out
end

---@param ... string
---@return string
local function mix_hex(...)
    local args = vim.tbl_map(function(value)
        return hex_to_rgb(value)
    end, {...})
    return rgb_to_hex(mix_rgb(unpack(args)))
end

function M.set_colors(colors, ns)
    local error_near = mix_hex(colors.error, colors.normal, colors.error)
    local error_far  = mix_hex(colors.error, colors.normal, colors.normal)
    local warn_near  = mix_hex(colors.warn,  colors.normal, colors.warn)
    local warn_far   = mix_hex(colors.warn,  colors.normal, colors.normal)
    local info_near  = mix_hex(colors.info,  colors.normal, colors.info)
    local info_far   = mix_hex(colors.info,  colors.normal, colors.normal)
    local hint_near  = mix_hex(colors.hint,  colors.normal, colors.hint)
    local hint_far   = mix_hex(colors.hint,  colors.normal, colors.normal)

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
        fg = error_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnErrorFar", {
        fg = error_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnWarnNear", {
        fg = warn_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnWarnFar", {
        fg = warn_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnInfoNear", {
        fg = info_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnInfoFar", {
        fg = info_far,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnHintNear", {
        fg = hint_near,
        bg = colors.bg
    })
    vim.api.nvim_set_hl(ns, "NeocolumnHintFar", {
        fg = hint_far,
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