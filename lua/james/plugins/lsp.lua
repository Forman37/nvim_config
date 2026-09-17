return {

    -- LSP installer + bridge
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "ts_ls",
                "tailwindcss",
                "eslint",
                "lua_ls",
                "pyright",
                "ruff",
                "rust_analyzer",
                "clangd", },
            automatic_enable = {
                exclude = { "dartls" }
            },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- add this dependency
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("ts_ls", { capabilities = capabilities })
            vim.lsp.config("tailwindcss", { capabilities = capabilities })
            vim.lsp.config("eslint", { capabilities = capabilities })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("ruff", {
                capabilities = capabilities,
                on_attach = function(client, _)
                    client.server_capabilities.hoverProvider = false
                end,
            })
            vim.lsp.config("rust_analyzer", { capabilities = capabilities })
            vim.lsp.config("clangd", { capabilities = capabilities })
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        version = "*",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),

                    ["jk"] = cmp.mapping(function(fallback) -- NEW: add this block
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { "i" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            local tabout_ok, tabout = pcall(require, "tabout")
                            if tabout_ok then
                                -- Feed the <Plug>(TaboutMulti) key to trigger tabout
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<Plug>(TaboutMulti)", true, true, true),
                                    "n", false
                                )
                            else
                                fallback()
                            end
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            local tabout_ok, tabout = pcall(require, "tabout")
                            if tabout_ok then
                                vim.api.nvim_feedkeys(
                                    vim.api.nvim_replace_termcodes("<Plug>(TaboutBackMulti)", true, true, true),
                                    "n", false
                                )
                            else
                                fallback()
                            end
                        end
                    end, { "i", "s" }),
                }),


                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
}
