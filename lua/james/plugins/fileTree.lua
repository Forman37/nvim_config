return {

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            local function on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
                end

                -- default mappings (important!)
                api.config.mappings.default_on_attach(bufnr)

                -- Custom: open file in new tab
                vim.keymap.set("n", "t", api.node.open.tab, opts("Open in new tab"))
                vim.keymap.set("n", "<leader>l", "<cmd>tabnext<CR>", { desc = "Next tab" })
                vim.keymap.set("n", "<leader>h", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
            end

            require("nvim-tree").setup({
                on_attach = on_attach,
                git = {
                    ignore = false,
                },
            })

            -- global toggle key
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
            -- global focus key
            vim.keymap.set("n", "<leader>t", ":silent! w<CR>:NvimTreeFocus<CR>")
        end,
    },
}
