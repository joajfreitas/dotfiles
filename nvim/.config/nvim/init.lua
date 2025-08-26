vim.wo.number = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.opt.swapfile = false

-- Set conceallevel to 1 for markdown files, needed for obsidian.nvim
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    command = "lua vim.opt.conceallevel = 1",
})

require("plugins").setup()
require("dap").setup()
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

-- disable inline lsp warnings
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
})

-- gitsings config doesn't work in the lazy config table
require('gitsigns').setup {
    --word_diff = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
    },
}
