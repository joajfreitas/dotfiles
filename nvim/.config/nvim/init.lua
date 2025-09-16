vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.wo.number = true
vim.o.mouse = 'a'

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250

vim.opt.swapfile = false

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set conceallevel to 1 for markdown files, needed for obsidian.nvim
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    command = "lua vim.opt.conceallevel = 1",
})

require("plugins").setup()
require("lsp").setup()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnippets" })
require("telescope").setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
require("telescope").load_extension("fzf")
require("keybindings").setup()
require("colorscheme").setup()
require("neovide").setup()

-- gitsings config doesn't work in the lazy config table
require('gitsigns').setup {
    --word_diff = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
    },
}
