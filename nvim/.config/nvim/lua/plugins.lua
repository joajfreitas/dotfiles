local M = {}

M.setup = function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out, "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        {
            "folke/lazydev.nvim",
            ft = 'lua',
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
        {
		    'NMAC427/guess-indent.nvim',
		    opts = {
                on_tab_options = {
        		    ["expandtab"] = true,
		        }
            }
        },
        {
            "johnfrankmorgan/whitespace.nvim",
            opts = {
                highlight = "DiffDelete",
                ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
                ignore_terminal = true,
                return_cursor = true,
            },
        },
        "tpope/vim-fugitive",
        {
            "tpope/vim-rhubarb",
            config = function()
                vim.g.github_enterprise_urls = { 'cc-github.bmwgroup.net' }
            end
        },
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
            config = true
        },
        {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 300,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
        }},
        { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", opts={} },
                "williamboman/mason-lspconfig.nvim",
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                { "j-hui/fidget.nvim",       opts = {} },
                'saghen/blink.cmp'
            },
        },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/nvim-cmp" },
        {
            "nvimtools/none-ls.nvim",
            config = function()
                local null_ls = require("null-ls")
                null_ls.setup({ null_ls.builtins.formatting.black })
            end
        },
        {
            "ellisonleao/gruvbox.nvim",
            lazy = false,
            priority = 1000,
        },
        "nvim-telescope/telescope-project.nvim",
        {
            "nvim-tree/nvim-tree.lua",
            config = function()
                require("nvim-tree").setup({
                    sync_root_with_cwd = true,
                    respect_buf_cwd = true,
                    update_focused_file = {
                        enable = true,
                        update_root = true
                    },
                    view = {
                        width = 80,
                    }
                })
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
                },
                {
                    "nvim-telescope/telescope-ui-select.nvim",
                    dependencies = { "nvim-telescope/telescope.nvim" },
                    config = function()
                        require("telescope").load_extension("ui-select")
                    end
                },
                { 'nvim-tree/nvim-web-devicons', enabled = true },
            },
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
            dependencies = { "echasnovski/mini.icons" }
        },
        {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" }
        },
        { "saadparwaiz1/cmp_luasnip" },
        { "pocco81/true-zen.nvim" },
        { "junegunn/limelight.vim" },
        {
            "FabijanZulj/blame.nvim",
            config = function() require("blame").setup() end
        },
        { "ledger/vim-ledger" },
        { "piero-vic/cmp-ledger" },
        {
            "lewis6991/gitsigns.nvim",
            config = function() require("gitsigns").setup() end
        },
        { "github/copilot.vim" },
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
                parser_config.fcp = {
                    install_info = {
                        url = "~/sources/fcp-core/tree-sitter-fcp",
                        files = { "src/parser.c" },
                        generate_requires_npm = false,
                        requires_generate_from_grammar = false,
                    },
                    filetype = "fcp",
                }
                require 'nvim-treesitter.configs'.setup {
                    highlight = {
                        enable = true,
                    }
                }
            end,
        },
        {
            "f-person/auto-dark-mode.nvim",

            opts = {
                fallback = "light"
            }
        },
        { "mfussenegger/nvim-dap" },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio"
            }
        },
        {
            "https://cc-github.bmwgroup.net/shaharklinger/acronymviewer.nvim",
            opts = {},
            lazy = false,
        },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            dependencies = {
                { "nvim-lua/plenary.nvim", branch = "master" },
            },
            build = "make tiktoken",
            opts = {
            },
        },
        {
            "obsidian-nvim/obsidian.nvim",
            version = "*",
            lazy = true,
            event = {
                "BufReadPre " .. vim.fn.expand("~") .. "/sources/wiki/*.md",
                "BufNewFile " .. vim.fn.expand("~") .. "/sources/wiki/*.md",
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            opts = {
                workspaces = {
                    {
                        name = "wiki",
                        path = "~/sources/wiki",
                    },
                },
                attachments = {
                    img_folder = "assets/imgs",
                }

            },
        },
        { "rcarriga/nvim-notify", opts = { stages = "static" } },
        {
            "nvim-neotest/neotest",
            dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
                "alfaix/neotest-gtest"
            },
            config = function()
                require("neotest").setup({
                    adapters = {
                        require("neotest-gtest").setup({
                            -- which debug adater to use? dap.adapters.<this debug_adapter> must be defined.
                            debug_adapter = "gdb",
                        })
                    },
                    discovery =
                    {
                        enabled = false,
                        concurrent = 1
                    },
                })
            end,
        },
    })

    local dap = require("dap")
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "/home/joaj/.local/share/nvim/mason/bin/codelldb",   -- I installed codelldb through mason.nvim
            args = { "--port", "${port}" }
        },
    }


    dap.configurations.c = {
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input('Path to executable: ',
                    '/home/joaj/bmw/orion2/bazel-bin/test/planning/motion_planning/behavior/lane_change/lane_segment_sequence_test')
            end,
            cwd = '${workspaceFolder}'
        },
    }


    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    vim.notify = require("notify")
end

return M
