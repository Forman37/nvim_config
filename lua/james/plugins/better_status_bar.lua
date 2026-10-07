return {

    -- Better status bar
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    globalstatus = true,
                },

                sections = {
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                },
            })
        end,
    },
}
