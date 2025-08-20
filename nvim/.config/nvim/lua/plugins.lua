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
        {"folke/lazydev.nvim", config = function()
            require("lazydev").setup({library = {"nvim-dap-ui"},})
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
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
          },
          config = true
        },
        {
            "lewis6991/gitsigns.nvim" ,
            config = function()
                require('gitsigns').setup({
                    current_line_blame = false,
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol',
                        delay = 300,
                        ignore_whitespace = false,
                        virt_text_priority = 100,
                        use_focus = true,
                    },
                })
            end
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
        {"morhetz/gruvbox", lazy=false, priority=1000},
        {"sainnhe/everforest"},
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
                    },
                    view = {
                        width = 80,
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
                  url = "~/sources/fcp-core/tree-sitter-fcp",
                  files = {"src/parser.c"},
                  generate_requires_npm = false,
                  requires_generate_from_grammar = false,
                },
                filetype = "fcp", 
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
        {"mfussenegger/nvim-dap"},
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
        {"rcarriga/nvim-notify", opts = {stages = "static"}},
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
            local utils = require("neotest-gtest.utils")
            local lib = require("neotest.lib")
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
    {
      "folke/snacks.nvim",
      ---@type snacks.Config
      opts = {
        input = {}
      }
    }
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
              command = "/home/joaj/.local/share/nvim/mason/bin/codelldb", -- I installed codelldb through mason.nvim
              args = {"--port", "${port}"}
          },
    }


    dap.configurations.c = {
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
           return vim.fn.input('Path to executable: ', '/home/joaj/bmw/orion2/bazel-bin/test/planning/motion_planning/behavior/lane_change/lane_segment_sequence_test')
        end,
        cwd = '${workspaceFolder}'
      },
    }


    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    vim.notify = require("notify")

end

return M
