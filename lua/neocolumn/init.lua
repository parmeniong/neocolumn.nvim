local config = require("neocolumn.config")
local colors = require("neocolumn.colors")

local function get_neighbouring_diagnostics(line, lines_with_diagnostics)
    local max_severity_diagnostic
    if lines_with_diagnostics[line - 1] then
        if max_severity_diagnostic and
            lines_with_diagnostics[line - 1] < max_severity_diagnostic[2]
        then
            max_severity_diagnostic = { 1, lines_with_diagnostics[line - 1] }
        end
    end
    if lines_with_diagnostics[line + 1] then
        if max_severity_diagnostic and
            lines_with_diagnostics[line + 1] < max_severity_diagnostic[2]
        then
            max_severity_diagnostic = { 1, lines_with_diagnostics[line + 1] }
        end
    end
    if lines_with_diagnostics[line - 2] then
        if max_severity_diagnostic and
            max_severity_diagnostic[1] > 1 and
            lines_with_diagnostics[line - 2] < max_severity_diagnostic[2]
        then
            max_severity_diagnostic = { 2, lines_with_diagnostics[line - 2] }
        end
    end
    if lines_with_diagnostics[line + 2] then
        if max_severity_diagnostic and
            max_severity_diagnostic[1] > 1 and
            lines_with_diagnostics[line + 2] < max_severity_diagnostic[2]
        then
            max_severity_diagnostic = { 2, lines_with_diagnostics[line + 2] }
        end
    end

    return max_severity_diagnostic
end

local M = {}

DrawNormal = {}
Ids = {}
LinesWithDiagnostics = {}

function M.setup(opts)
    config.set(opts or {})

    local ns = vim.api.nvim_create_namespace("neocolumn")
    vim.api.nvim_set_hl_ns(ns)

    colors.set_colors(config.opts.colors, ns)

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
                if Ids[event.buf] then
                    for _, id in pairs(Ids[event.buf]) do
                        vim.api.nvim_buf_del_extmark(0, ns, id)
                    end
                    Ids[event.buf] = nil
                end
                return
            end

            if vim.bo.buftype ~= "" then
                return
            end

            if not DrawNormal[event.buf] then
                if config.opts.max_distance ~= 0 then
                    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
                    DrawNormal[event.buf] = vim.api.nvim_buf_get_lines(
                        0,
                        cursor_line - 1,
                        cursor_line,
                        false
                    )[1]:len() >= config.opts.max_line_length - config.opts.max_distance
                else
                    DrawNormal[event.buf] = 0
                end
            end

            if not LinesWithDiagnostics[event.buf] then
                LinesWithDiagnostics[event.buf] = {}
            end

            if event.event == "DiagnosticChanged" then
                if config.opts.diagnostics then
                    local diagnostics = vim.diagnostic.get(0)
                    LinesWithDiagnostics[event.buf] = {}
                    for _, v in pairs(diagnostics) do
                        if v.severity <= config.opts.min_diagnostic_severity then
                            if LinesWithDiagnostics[event.buf][v.lnum + 1] then
                                if v.severity < LinesWithDiagnostics[event.buf][v.lnum + 1] then
                                    LinesWithDiagnostics[event.buf][v.lnum + 1] = v.severity
                                end
                            else
                                LinesWithDiagnostics[event.buf][v.lnum + 1] = v.severity
                            end
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
                        if Ids[event.buf] then
                            if Ids[event.buf][i] then
                                vim.api.nvim_buf_del_extmark(0, ns, Ids[event.buf][i])
                                table.remove(Ids[event.buf], i)
                                goto continue
                            end
                        end
                    end
                end

                local hl
                if i == vim.api.nvim_win_get_cursor(0)[1] then
                    hl = "NeocolumnCursor"
                    if config.opts.diagnostics then
                        if LinesWithDiagnostics[event.buf][i] then
                            if LinesWithDiagnostics[event.buf][i] == 1 then
                                hl = "NeocolumnCursorError"
                            elseif LinesWithDiagnostics[event.buf][i] == 2 then
                                hl = "NeocolumnCursorWarn"
                            elseif LinesWithDiagnostics[event.buf][i] == 3 then
                                hl = "NeocolumnCursorInfo"
                            elseif LinesWithDiagnostics[event.buf][i] == 4 then
                                hl = "NeocolumnCursorHint"
                            end
                        else
                            local neighbouring_diagnostics = get_neighbouring_diagnostics(
                                i,
                                LinesWithDiagnostics[event.buf]
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
                else
                    hl = "Neocolumn"
                    if config.opts.diagnostics then
                        if LinesWithDiagnostics[event.buf][i] then
                            if LinesWithDiagnostics[event.buf][i] == 1 then
                                hl = "NeocolumnError"
                            elseif LinesWithDiagnostics[event.buf][i] == 2 then
                                hl = "NeocolumnWarn"
                            elseif LinesWithDiagnostics[event.buf][i] == 3 then
                                hl = "NeocolumnInfo"
                            elseif LinesWithDiagnostics[event.buf][i] == 4 then
                                hl = "NeocolumnHint"
                            end
                        else
                            local neighbouring_diagnostics = get_neighbouring_diagnostics(
                                i,
                                LinesWithDiagnostics[event.buf]
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
                end

                local char = config.opts.character
                if not DrawNormal[event.buf] == 0 and
                    (hl == "Neocolumn" or hl == "NeocolumnCursor")
                then
                    char = " "
                end

                if not Ids[event.buf] then
                    Ids[event.buf] = {}
                end

                if Ids[event.buf][i] then
                    Ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
                        id = Ids[event.buf][i],
                        virt_text = { { char, hl } },
                        virt_text_pos = "overlay",
                        virt_text_win_col = config.opts.max_line_length
                    })
                else
                    Ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
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
