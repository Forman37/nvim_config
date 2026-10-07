return {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
        require("mini.pairs").setup()

        vim.keymap.set("i", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]

            local before = line:sub(col, col)
            local after = line:sub(col + 1, col + 1)

            if before == "{" and after == "}" then
                return "<CR><Esc>O"
            end

            return "<CR>"
        end, { expr = true })
    end,
}
