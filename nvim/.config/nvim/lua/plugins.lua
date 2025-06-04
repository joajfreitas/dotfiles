local M = {}

M.setup = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    local uv = vim.uv or vim.loop

    -- Auto-install lazy.nvim if not present
    if not uv.fs_stat(lazypath) then
        print("Installing lazy.nvim....")
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
        print("Done.")
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        {"folke/neodev.nvim", config = function()
            require("neodev").setup()
        end},
        {
			"johnfrankmorgan/whitespace.nvim",
			config = function()
				require("whitespace-nvim").setup({
					highlight = "DiffDelete",
					ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
					ignore_terminal = true,
					return_cursor = true,
				})
			end,
		},
        {"tpope/vim-fugitive"},

        {"tpope/vim-rhubarb",
            config = function()
                vim.cmd("let g:github_enterprise_urls = ['cc-github.bmwgroup.net']")
            end
        },
        {
          "NeogitOrg/neogit",
          dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
            "echasnovski/mini.pick",         -- optional
          },
          config = true
        },
        {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {"neovim/nvim-lspconfig"},
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/nvim-cmp"},
        {
            "nvimtools/none-ls.nvim",
            config = function()
                local null_ls = require("null-ls")
                null_ls.setup({null_ls.builtins.formatting.black})
            end
        },
        {"morhetz/gruvbox"},
        {"ahmedkhalf/project.nvim"},
        {
            "nvim-tree/nvim-tree.lua",
            config = function()
                require("nvim-tree").setup({
                    sync_root_with_cwd = true,
                    respect_buf_cwd = true,
                    update_focused_file = {
                        enable = true,
                        update_root = true
                    }
                })
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim"}
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        },
        {
            "nvim-telescope/telescope-symbols.nvim"
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
            dependencies = {"echasnovski/mini.icons"}
        },
        {"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}},
        {"saadparwaiz1/cmp_luasnip"},
        {"pocco81/true-zen.nvim"},
        {"junegunn/limelight.vim"},
        {
            "FabijanZulj/blame.nvim",
            config = function() require("blame").setup() end
        }, 
	    {"ledger/vim-ledger"},
	    {"piero-vic/cmp-ledger"}, 
        {
            "lewis6991/gitsigns.nvim",
            config = function() require("gitsigns").setup() end
        },
	    {"github/copilot.vim"},
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
              local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
              parser_config.fcp = {
                install_info = {
                  url = "~/sources/fcp-core/tree-sitter-fcp", -- local path or git repo
                  files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
                  -- optional entries:
                  generate_requires_npm = false, -- if stand-alone parser without npm dependencies
                  requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
                },
                filetype = "fcp", -- if filetype does not match the parser name
              }
              require'nvim-treesitter.configs'.setup {
                highlight = {
                  enable = true,
                }
              }
            end,
        },
        {"f-person/auto-dark-mode.nvim",

        opts = {
            fallback = "light"
        }
        },
    })
end

return M
