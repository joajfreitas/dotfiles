-- disable netrw at the very start of your init.lua
vim.g.loaded_netrwPlugin = 1

require('plugins').setup()
require('lsp').setup()
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnippets"})
require("telescope").setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
})
require("telescope").load_extension("fzf")
require('keybindings').setup()
require('colorscheme').setup()

vim.o.autochdir = false
vim.wo.number = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
