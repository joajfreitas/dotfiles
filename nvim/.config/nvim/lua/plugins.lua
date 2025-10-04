local M = {}

M.setup = function()
    local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    local uv = vim.uv or vim.loop

    -- Auto-install lazy.nvim if not present
    if not uv.fs_stat(lazypath) then
        print 'Installing lazy.nvim....'
        vim.fn.system {
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable',
            lazypath,
        }
        print 'Done.'
    end

    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({
        {
            'NMAC427/guess-indent.nvim',
            opts = {
                on_tab_options = {
                    ['expandtab'] = true,
                },
            },
        },
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    { path = '${3rd}/luv/library', word = { 'vim%.uv' } },
                },
            },
        },
        {
            'johnfrankmorgan/whitespace.nvim',
            config = function()
                require('whitespace-nvim').setup {
                    highlight = 'DiffDelete',
                    ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },
                    ignore_terminal = true,
                    return_cursor = true,
                }
            end,
        },
        { 'tpope/vim-fugitive' },
        { 'tpope/vim-rhubarb' },
        { 'shumphrey/fugitive-gitlab.vim' },
        {
            "NeogitOrg/neogit",
            opts = {
                graph_style="unicode",
            },
            dependencies = {
                'nvim-lua/plenary.nvim',
                'sindrets/diffview.nvim',
                'nvim-telescope/telescope.nvim',
            },
            config = true,
        },
        { 'lewis6991/gitsigns.nvim' },

        --- LSP ---

        { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' }, -- TODO: deprecated
        { 'mason-org/mason.nvim' },
        { 'mason-org/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/nvim-cmp' },
        {
            'folke/trouble.nvim',
            opts = {},
            cmd = 'Trouble',
        },
        {
            "zbirenbaum/copilot-cmp",
            opts = {},
        },
        {
            'L3MON4D3/LuaSnip',
            run = 'make install_jsregexp',
            dependencies = { 'rafamadriz/friendly-snippets' },
        },
        --- Follow system wide theme (dark/light)
        { 'vimpostor/vim-lumen' },
        --- Gruvbox! ---
        {
            'ellisonleao/gruvbox.nvim',
            opts = { transparent_mode = not vim.g.neovide },
        },
        --- Render image inline ---
        {
            '3rd/image.nvim',
            event = 'VeryLazy',
            opts = {
                --backend = "kitty",
                backend = 'sixel',
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = true,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        only_render_image_at_cursor_mode = 'inline',
                        filetypes = { 'markdown' }, -- markdown extensions (ie. quarto) can go here
                        resolve_image_path = function(document_path, image_path, fallback)
                            local working_dir = vim.fn.getcwd()
                            -- Format image path for Obsidian notes
                            if working_dir:find '/home/joaj/Sync/wiki' then
                                return working_dir .. '/' .. 'assets/' .. image_path
                            end
                            -- Fallback to the default behavior
                            return fallback(document_path, image_path)
                        end,
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        filetypes = { 'norg' },
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = 75,
                max_height_window_percentage = 50,
                kitty_method = 'normal',
            },
        },
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-tree/nvim-web-devicons',
                'MunifTanjim/nui.nvim',
            },
            config = function()
                vim.g.loaded_netrw = 1
                vim.g.loaded_netrwPlugin = 1
                vim.opt.termguicolors = true

                require('nvim-tree').setup {
                    sync_root_with_cwd = true,
                    respect_buf_cwd = true,
                    update_focused_file = {
                        enable = true,
                        update_root = true,
                    },
                    sort = {
                        sorter = 'case_sensitive',
                    },
                    view = {
                        width = 50,
                    },
                    renderer = {
                        group_empty = true,
                    },
                    filters = {
                        dotfiles = true,
                    },
                }
            end,
        },
        {
            'stevearc/oil.nvim',
            dependencies = { { 'echasnovski/mini.icons', opts = {} } },
            opts = {},
            lazy = false,
    	},
	{
            "nvim-telescope/telescope.nvim",
            event = 'VimEnter',
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
                },
                { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
                "nvim-telescope/telescope-ui-select.nvim"
            },
            config = function()
                require("telescope").setup({
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown({}),
                        },
                    }
                })

                --require("telescope_config").setup()
                pcall(require("telescope").load_extension, "fzf")
                pcall(require("telescope").load_extension, "ui-select")
            end
        },
        {
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            dependencies = {
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
                },
                { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
                'nvim-telescope/telescope-ui-select.nvim',
            },
            config = function()
                require('telescope').setup {
                    extensions = {
                        ['ui-select'] = {
                            require('telescope.themes').get_dropdown {},
                        },
                    },
                }

                pcall(require('telescope').load_extension, 'fzf')
                pcall(require('telescope').load_extension, 'ui-select')
            end,
        },
        {
            'folke/which-key.nvim',
            event = 'VimEnter',
            opts = {
                delay = 0,
                icon = {
                    mappings = vim.g.have_nerd_font,
                },
            },
        },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'pocco81/true-zen.nvim' },
        { 'junegunn/limelight.vim' },
        {
            'FabijanZulj/blame.nvim',
            config = function()
                require('blame').setup()
            end,
        },
        { 'ledger/vim-ledger' },
        { 'piero-vic/cmp-ledger' },
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end,
        },
        {
            'DrKJeff16/project.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope.nvim',
            },
            opts = {},
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            opts = {
                ensure_installed = {
                    'bash',
                    'c',
                    'diff',
                    'html',
                    'lua',
                    'luadoc',
                    'markdown',
                    'markdown_inline',
                    'query',
                    'vimdoc',
                    'rust',
                    'toml',
                    'yaml',
                    'cpp',
                },
                auto_install = true,
                highlight = { enable = true },
            },
            --config = function()
            --    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            --    parser_config.fcp = {
            --        install_info = {
            --            url = "~/sources/fcp-core/tree-sitter-fcp",
            --            files = { "src/parser.c" },
            --            generate_requires_npm = false,
            --            requires_generate_from_grammar = false,
            --        },
            --        filetype = "fcp",
            --    }
            --    require("nvim-treesitter.configs").setup({
            --        ensure_installed = { "markdown" },
            --        highlight = { enable = true },
            --    })
            --end,
        },
        { 'github/copilot.vim' },
        {
            'CopilotC-Nvim/CopilotChat.nvim',
            dependencies = {
                { 'nvim-lua/plenary.nvim', branch = 'master' },
            },
            build = 'make tiktoken',
            opts = {},
        },
        { 'ActivityWatch/aw-watcher-vim' },
        {
            'epwalsh/obsidian.nvim',
            version = '*',
            lazy = true,
            event = {
                'BufReadPre ' .. vim.fn.expand '~' .. '/Sync/wiki/*.md',
                'BufNewFile ' .. vim.fn.expand '~' .. '/Sync/wiki/*.md',
            },
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            opts = {
                workspaces = {
                    {
                        name = 'wiki',
                        path = '~/Sync/wiki',
                    },
                },
                attachments = {
                    img_folder = 'assets',
                },
            },
        },
        { 'mfussenegger/nvim-dap' },
        {
            'rcarriga/nvim-dap-ui',
            dependencies = {
                'mfussenegger/nvim-dap',
                'nvim-neotest/nvim-nio',
                'jbyuki/one-small-step-for-vimkind',
            },
            lazy = false,
        },
        {
            'mrcjkb/rustaceanvim',
            version = '^6', -- Recommended
            lazy = false, -- This plugin is already lazy
            config = function()
                vim.g.rustaceanvim = function()
                    -- Update this path
                    local extension_path = vim.env.HOME .. '/home/joaj/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
                    local codelldb_path = extension_path .. 'adapter/codelldb'
                    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
                    local cfg = require 'rustaceanvim.config'
                    return {
                        dap = {
                            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                        },
                    }
                end
            end,
        },
        {
            'nvim-neotest/neotest',
            dependencies = {
                'nvim-neotest/nvim-nio',
                'nvim-lua/plenary.nvim',
                'antoinemadec/FixCursorHold.nvim',
                'nvim-treesitter/nvim-treesitter',
                'alfaix/neotest-gtest',
            },
            config = function()
                local utils = require 'neotest-gtest.utils'
                local lib = require 'neotest.lib'
                require('neotest').setup {
                    adapters = {
                        require('neotest-gtest').setup {
                            -- which debug adater to use? dap.adapters.<this debug_adapter> must be defined.
                            debug_adapter = 'gdb',
                        },
                        require 'rustaceanvim.neotest',
                    },
                    discovery = {
                        enabled = false,
                        concurrent = 1,
                    },
                }
            end,
        },
        {
            'folke/todo-comments.nvim',
            event = 'VimEnter',
            dependencies = { 'nvim-lua/plenary.nvim' },
            opts = {
                signs = false,
            },
        },
    }, {
        ui = {
            -- If you are using a Nerd Font: set icons to an empty table which will use the
            -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    })

    local dap = require 'dap'
    dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = '/home/joaj/.local/share/nvim/mason/bin/codelldb', -- I installed codelldb through mason.nvim
            args = { '--port', '${port}' },
        },
    }

    dap.configurations.c = {
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input(
                    'Path to executable: ',
                    '/home/joaj/bmw/orion2/bazel-bin/test/planning/motion_planning/behavior/lane_change/lane_segment_sequence_test'
                )
            end,
            cwd = '${workspaceFolder}',
        },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = 'Attach to running Neovim instance',
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    end
end

return M
