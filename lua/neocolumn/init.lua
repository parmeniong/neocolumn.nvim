local config = require("neocolumn.config")
local colors = require("neocolumn.colors")

local function get_neighbouring_diagnostics(line, lines_with_diagnostics)
    if lines_with_diagnostics[line - 1] then
        return { 1, lines_with_diagnostics[line - 1] }
    elseif lines_with_diagnostics[line + 1] then
        return { 1, lines_with_diagnostics[line + 1] }
    elseif lines_with_diagnostics[line - 2] then
        return { 2, lines_with_diagnostics[line - 2] }
    elseif lines_with_diagnostics[line + 2] then
        return { 2, lines_with_diagnostics[line + 2] }
    else
        return nil
    end
end

local M = {}

function M.setup(opts)
    config.set(opts or {})

    local ns = vim.api.nvim_create_namespace("neocolumn")
    vim.api.nvim_set_hl_ns(ns)

    colors.set_colors(config.opts.colors, ns)

    local ids = {}

    vim.api.nvim_create_autocmd({
        "BufEnter",
        "TextChanged",
        "TextChangedI",
        "TextChangedT",
        "CursorMoved",
        "CursorMovedI",
        "DiagnosticChanged",
        "ModeChanged"
    }, {
        callback = function(event)
            local filetype = vim.bo.filetype
            if vim.tbl_contains(config.opts.exclude_filetypes, filetype) then
                if ids[event.buf] then
                    for _, id in pairs(ids[event.buf]) do
                        vim.api.nvim_buf_del_extmark(0, ns, id)
                    end
                    ids[event.buf] = nil
                end
                return
            end

            if vim.bo.buftype ~= "" then
                return
            end

            local draw_normal = true
            if config.opts.max_distance ~= 0 then
                local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
                draw_normal = vim.api.nvim_buf_get_lines(
                    0,
                    cursor_line - 1,
                    cursor_line,
                    false
                )[1]:len() >= config.opts.max_line_length - config.opts.max_distance
            end

            local lines_with_diagnostics
            if config.opts.diagnostics then
                local diagnostics = vim.diagnostic.get(0)
                lines_with_diagnostics = {}
                for _, v in pairs(diagnostics) do
                    if v.severity <= config.opts.min_diagnostic_severity then
                        if lines_with_diagnostics[v.lnum + 1] then
                            if v.severity < lines_with_diagnostics[v.lnum + 1] then
                                lines_with_diagnostics[v.lnum + 1] = v.severity
                            end
                        else
                            lines_with_diagnostics[v.lnum + 1] = v.severity
                        end
                    end
                end
            end

            for i = 1, vim.api.nvim_buf_line_count(0) + 1 do
                if i <= vim.api.nvim_buf_line_count(0) then
                    if vim.api.nvim_buf_get_lines(
                        0,
                        i - 1,
                        i,
                        false
                    )[1]:len() > config.opts.max_line_length then
                        if ids[event.buf] then
                            if ids[event.buf][i] then
                                vim.api.nvim_buf_del_extmark(0, ns, ids[event.buf][i])
                                table.remove(ids[event.buf], i)
                                goto continue
                            end
                        end
                    end
                end

                local hl = "Neocolumn"
                if config.opts.diagnostics then
                    if lines_with_diagnostics[i] then
                        if lines_with_diagnostics[i] == 1 then
                            hl = "NeocolumnError"
                        elseif lines_with_diagnostics[i] == 2 then
                            hl = "NeocolumnWarn"
                        elseif lines_with_diagnostics[i] == 3 then
                            hl = "NeocolumnInfo"
                        elseif lines_with_diagnostics[i] == 4 then
                            hl = "NeocolumnHint"
                        end
                    else
                        local neighbouring_diagnostics = get_neighbouring_diagnostics(
                            i,
                            lines_with_diagnostics
                        )

                        if neighbouring_diagnostics then
                            if neighbouring_diagnostics[2] == 1 then
                                hl = "NeocolumnError"
                            elseif neighbouring_diagnostics[2] == 2 then
                                hl = "NeocolumnWarn"
                            elseif neighbouring_diagnostics[2] == 3 then
                                hl = "NeocolumnInfo"
                            elseif neighbouring_diagnostics[2] == 4 then
                                hl = "NeocolumnHint"
                            end

                            if neighbouring_diagnostics[1] == 1 then
                                hl = hl .. "Near"
                            else
                                hl = hl .. "Far"
                            end
                        end
                    end
                end
                if i == vim.api.nvim_win_get_cursor(0)[1] then
                    hl = "NeocolumnCursor"
                    if config.opts.diagnostics then
                        if lines_with_diagnostics[i] then
                            if lines_with_diagnostics[i] == 1 then
                                hl = "NeocolumnCursorError"
                            elseif lines_with_diagnostics[i] == 2 then
                                hl = "NeocolumnCursorWarn"
                            elseif lines_with_diagnostics[i] == 3 then
                                hl = "NeocolumnCursorInfo"
                            elseif lines_with_diagnostics[i] == 4 then
                                hl = "NeocolumnCursorHint"
                            end
                        else
                            local neighbouring_diagnostics = get_neighbouring_diagnostics(
                                i,
                                lines_with_diagnostics
                            )

                            if neighbouring_diagnostics then
                                if neighbouring_diagnostics[2] == 1 then
                                    hl = "NeocolumnCursorError"
                                elseif neighbouring_diagnostics[2] == 2 then
                                    hl = "NeocolumnCursorWarn"
                                elseif neighbouring_diagnostics[2] == 3 then
                                    hl = "NeocolumnCursorInfo"
                                elseif neighbouring_diagnostics[2] == 4 then
                                    hl = "NeocolumnCursorHint"
                                end

                                if neighbouring_diagnostics[1] == 1 then
                                    hl = hl .. "Near"
                                elseif neighbouring_diagnostics[1] == 2 then
                                    hl = hl .. "Far"
                                end
                            end
                        end
                    end
                end

                local char = config.opts.character
                if not draw_normal and (hl == "Neocolumn" or hl == "NeocolumnCursor") then
                    char = " "
                end

                if not ids[event.buf] then
                    ids[event.buf] = {}
                end

                if ids[event.buf][i] then
                    ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
                        id = ids[event.buf][i],
                        virt_text = { { char, hl } },
                        virt_text_pos = "overlay",
                        virt_text_win_col = config.opts.max_line_length
                    })
                else
                    ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
                        virt_text = { { char, hl } },
                        virt_text_pos = "overlay",
                        virt_text_win_col = config.opts.max_line_length
                    })
                end

                ::continue::
            end
        end
    })
end

return M
