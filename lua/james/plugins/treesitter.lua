return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local ts = require("nvim-treesitter")

        ts.setup({})

        ts.install({
            "python",
            "lua",
            "javascript",
            "typescript",
            "html",
            "css",
            "rust",
            "c",
            "cpp",
            "bash",
            "json",
            "markdown",
            "markdown_inline",
            "dart",
            "dockerfile",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
