local M = {}

local utils = {
    trim = function(text)
        return (text:gsub("^%s*(.-)%s*$", "%1"))
    end,
    --- Function to press escape key programmatically. Created so neovim can
    --- update the marks for visual mode.
    press_escape = function()
        local keys = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
        vim.api.nvim_feedkeys(keys, "x", false)
    end,
}

M.wrap_with_abbreviation = function()
    --- @param to_replace string
    --- @param callback function
    local request_abbreviation = function(to_replace, callback)
        local abbreviation = vim.fn.input("Abbreviation: ") --[[@as string]]

        if abbreviation == "" then
            return
        end

        local opts = { text = utils.trim(to_replace) }

        vim.lsp.buf_request(
            0,
            "emmet/expandAbbreviation",
            { abbreviation = abbreviation, options = opts },
            --- @param result string
            function(_, result, _, _)
                if not result then
                    return
                end

                callback(result)
            end
        )
    end

    local for_visual_mode = function()
        utils.press_escape()

        local start_mark = vim.api.nvim_buf_get_mark(0, "<")
        local end_mark = vim.api.nvim_buf_get_mark(0, ">")

        local current_lines =
            vim.api.nvim_buf_get_text(0, start_mark[1] - 1, start_mark[2], end_mark[1] - 1, end_mark[2] + 1, {})

        request_abbreviation(
            table.concat(current_lines, "\n"),
            --- @param result string
            function(result)
                local lines = vim.split(result, "\n")
                vim.api.nvim_buf_set_text(0, start_mark[1] - 1, start_mark[2], end_mark[1] - 1, end_mark[2] + 1, lines)
            end
        )
    end

    local for_visual_block_mode = function()
        utils.press_escape()

        local start_mark = vim.api.nvim_buf_get_mark(0, "<")
        local end_mark = vim.api.nvim_buf_get_mark(0, ">")

        local current_lines = vim.api.nvim_buf_get_lines(0, start_mark[1] - 1, end_mark[1], false)

        request_abbreviation(
            table.concat(current_lines, "\n"),
            --- @param result string
            function(result)
                local lines = vim.split(result, "\n")
                vim.api.nvim_buf_set_lines(0, start_mark[1] - 1, end_mark[1], false, lines)
            end
        )
    end

    local for_normal_mode = function()
        local current_line = vim.api.nvim_get_current_line()
        local current_row = vim.api.nvim_win_get_cursor(0)[1]

        request_abbreviation(
            current_line,
            --- @param result string
            function(result)
                local lines = vim.split(result, "\n")
                vim.api.nvim_buf_set_lines(0, current_row - 1, current_row, false, lines)
            end
        )
    end

    local mode = vim.api.nvim_get_mode().mode --[[@as "i" | "n" | "v" | "V" | "x"]]

    if mode == "v" then
        for_visual_mode()
        return
    end

    if mode == "V" then
        for_visual_block_mode()
        return
    end

    for_normal_mode()
end

return M
