-- Save with Ctrl+s
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", { desc = "Save file" })

-- Quit with leader + q
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- Save and quit with leader + sq
vim.keymap.set("n", "<leader>sq", "<cmd>wq<CR>", { desc = "Save and quit" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Exit insert mode with jj
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Open file explorer
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Build C++ Project
vim.keymap.set("n", "<leader>rb", function()
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.cmd("!cmake -S . -B build && cmake --build build && ./build/" .. project)
end)

-- LSP keymaps: these only work when a language server is attached
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf, noremap = true, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    end,
})


-- Treesitter context
vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to context" })

-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


-- Tab Key fixes
vim.keymap.set("i", "<C-f>", "<Tab>", { silent = true })
vim.keymap.set("i", "<C-b>", "<S-Tab>", { silent = true })


-- Clear search in norms
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
