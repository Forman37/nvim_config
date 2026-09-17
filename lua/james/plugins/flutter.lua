return {
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require("flutter-tools").setup({
                flutter_path = nil,
                fvm = false,
                widget_guides = {
                    enabled = false,
                },
                closing_tags = {
                    enabled = true,
                },
                dev_log = {
                    enabled = true,
                },
                lsp = {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    settings = {
                        lineLength = 80,
                    },
                },
                decorations = {
                    statusline = {
                        device = true,
                        app_version = true,
                    },
                },
            })
        end,
    },
    {
        "dart-lang/dart-vim-plugin",
    },
}
