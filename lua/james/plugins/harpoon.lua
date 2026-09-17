return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- ─── Tabline ───────────────────────────────────────────────
        -- Build a custom tabline that shows harpoon marks
        local function harpoon_tabline()
            local items = harpoon:list().items
            local current = vim.fn.expand("%:p")
            local line = ""
            for i, item in ipairs(items) do
                -- Get just the filename for display
                local name = vim.fn.fnamemodify(item.value, ":t")
                -- Expand the stored path to absolute for comparison
                local abs = vim.fn.fnamemodify(item.value, ":p")
                local is_active = (abs == current)

                if is_active then
                    line = line .. "%#HarpoonActive# " .. i .. ": " .. name .. " %#TabLineFill#"
                else
                    line = line .. "%#HarpoonInactive# " .. i .. ": " .. name .. " %#TabLineFill#"
                end
            end

            return line
        end

        -- Tell nvim to use our function for the tabline
        vim.o.showtabline = 2 -- Change to 2 to always show tabline
        vim.o.tabline = "%!v:lua.require('harpoon_tabline').get()"

        -- Expose the function globally so the tabline option can call it
        package.loaded["harpoon_tabline"] = { get = harpoon_tabline }

        -- Refresh tabline when switching buffers
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            callback = function()
                vim.cmd("redrawtabline")
            end,
        })

        -- ─── Colors ────────────────────────────────────────────────
        vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
        vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
        vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
        vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
        vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')

        -- ─── Keymaps ───────────────────────────────────────────────
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
        vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)
    end,
}
