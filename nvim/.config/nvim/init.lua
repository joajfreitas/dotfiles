-- disable netrw at the very start of your init.lua
vim.g.loaded_netrwPlugin = 1
vim.o.autochdir = false
vim.wo.number = true
vim.g.mapleader = " "

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = "Clear search highlighting" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

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
pcall(require("telescope").load_extension, 'fzf')
pcall(require("telescope").load_extension, 'ui-select')

require('keybindings').setup()
require('colorscheme').setup()

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*.md' },
    callback = function()
        vim.o.conceallevel = 2
    end,
})
