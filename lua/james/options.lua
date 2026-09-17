-- Make lazy.nvim available
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.breakindentopt = { "shift:2" }
vim.opt.showbreak = "↪ "

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Better UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Clipboard (Mac integration)
vim.opt.clipboard = "unnamedplus"

-- Completion menu behavior
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Fix timeout
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10

-- Auto indent for dart specific
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dart",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
    end,
})

-- Folding
vim.opt.foldmethod = "manual" -- ufo overrides this, just set to manual
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*",
    callback = function()
        if vim.fn.expand("%") ~= "" then
            vim.cmd("mkview")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    command = "silent! loadview"
})
