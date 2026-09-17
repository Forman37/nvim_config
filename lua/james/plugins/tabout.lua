return {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("tabout").setup({
            tabkey = "<Tab>",
            backwards_tabkey = "<S-Tab>",
            completion_tabkey = "",
            ignore_beginning = false, -- changed from true
            act_as_tab = false,
            enable_backwards = true,
            completion = false,
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = "`", close = "`" },
                { open = "(", close = ")" },
                { open = "[", close = "]" },
                { open = "{", close = "}" },
                { open = "<", close = ">" },
            },
        })
    end,
}
