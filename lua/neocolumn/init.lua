local config = require("neocolumn.config")

local M = {}

---Configure neocolumn.nvim
---@param opts Config Configuration options
function M.setup(opts)
    config.set(opts or {})

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
            local ns = vim.api.nvim_create_namespace("neocolumn")

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
                    if vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:len() > config.opts.max_line_length then
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
                        if lines_with_diagnostics[i] == vim.diagnostic.severity.ERROR then
                            hl = "NeocolumnError"
                        elseif lines_with_diagnostics[i] == vim.diagnostic.severity.WARN then
                            hl = "NeocolumnWarn"
                        elseif lines_with_diagnostics[i] == vim.diagnostic.severity.INFO then
                            hl = "NeocolumnInfo"
                        elseif lines_with_diagnostics[i] == vim.diagnostic.severity.HINT then
                            hl = "NeocolumnHint"
                        end
                    end
                end
                if i == vim.api.nvim_win_get_cursor(0)[1] then
                    hl = "NeocolumnCursor"
                    if config.opts.diagnostics then
                        if lines_with_diagnostics[i] then
                            if lines_with_diagnostics[i] == vim.diagnostic.severity.ERROR then
                                hl = "NeocolumnCursorError"
                            elseif lines_with_diagnostics[i] == vim.diagnostic.severity.WARN then
                                hl = "NeocolumnCursorWarn"
                            elseif lines_with_diagnostics[i] == vim.diagnostic.severity.INFO then
                                hl = "NeocolumnCursorInfo"
                            elseif lines_with_diagnostics[i] == vim.diagnostic.severity.HINT then
                                hl = "NeocolumnCursorHint"
                            end
                        end
                    end
                end

                if not ids[event.buf] then
                    ids[event.buf] = {}
                end

                if ids[event.buf][i] then
                    ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
                        id = ids[event.buf][i],
                        virt_text = { { "│", hl } },
                        virt_text_pos = "overlay",
                        virt_text_win_col = config.opts.max_line_length
                    })
                else
                    ids[event.buf][i] = vim.api.nvim_buf_set_extmark(0, ns, i - 1, 0, {
                        virt_text = { { "│", hl } },
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
