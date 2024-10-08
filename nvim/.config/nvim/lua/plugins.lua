local M = {}

M.setup = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    local uv = vim.uv or vim.loop

    -- Auto-install lazy.nvim if not present
    if not uv.fs_stat(lazypath) then
        print("Installing lazy.nvim....")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
        print("Done.")
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup()
            end,
        },
        { "tpope/vim-fugitive" },
        { "lunarvim/lunar.nvim" },
        { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/nvim-cmp" },
        { "L3MON4D3/LuaSnip" },
        { "morhetz/gruvbox" },
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
                "3rd/image.nvim",
            },
            config = function()
                require("neo-tree").setup({
                    source_selector = {
                        statusline = true,
                    },
                })
            end,
        },
        { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
        },
        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        { "saadparwaiz1/cmp_luasnip" },
        { "pocco81/true-zen.nvim" },
        { "junegunn/limelight.vim" },
        {
            "FabijanZulj/blame.nvim",
            config = function()
                require("blame").setup()
            end,
        },
        { "ledger/vim-ledger" },
        { "piero-vic/cmp-ledger" },
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end,
        },
        --{
        --  "NeogitOrg/neogit",
        --  dependencies = {
        --    "nvim-lua/plenary.nvim",         -- required
        --    "sindrets/diffview.nvim",        -- optional - Diff integration
        --    -- Only one of these is needed.
        --    "nvim-telescope/telescope.nvim", -- optional
        --  },
        --  config = true
        --},
        --{
        --    "ActivityWatch/aw-watcher-vim"
        --},
    })
end

return M
