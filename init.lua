-- Set leader key early
vim.g.mapleader = " "

require("james.options")
require("james.keymaps")
require("james.commands")
require("james.format")

require("lazy").setup("james.plugins")
