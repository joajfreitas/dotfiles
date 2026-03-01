vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.wo.number = true
vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250

vim.opt.swapfile = false

vim.o.inccommand = 'split'
vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Set conceallevel to 1 for markdown files, needed for obsidian.nvim
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.md' },
    command = 'lua vim.opt.conceallevel = 1',
})

vim.opt.termsync = false

require('plugins').setup()
require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/luasnippets' }
require('keybindings').setup()
require('colorscheme').setup()
require('neovide').setup()
require('completion').setup()
require('dap_config').setup()
require('gitsigns_config').setup()
