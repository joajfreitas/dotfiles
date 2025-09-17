local M = {}

-- Telescope keymaps for search
M.telescope_keymaps = function(wk)
    local builtin = require 'telescope.builtin'
    local telescope = require 'telescope'

    wk.add {
        { '<leader>s', group = '[S]earch' },
        { '<leader>sh', builtin.help_tags, desc = '[S]earch [H]elp' },
        { '<leader>sk', builtin.keymaps, desc = '[S]earch [K]eymaps' },
        { '<leader>g', builtin.git_files, desc = 'Search [G]it Files' },
        { '<leader>st', builtin.git_files, desc = '[S]earch Git [Tracked] Files' },
        { '<leader>sf', builtin.find_files, desc = '[S]earch [F]iles' },
        { '<leader>ss', builtin.builtin, desc = '[S]earch [S]elect Telescope' },
        { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord' },
        { '<leader>sg', builtin.live_grep, desc = '[S]earch by [G]rep' },
        { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
        { '<leader>sr', builtin.resume, desc = '[S]earch [R]esume' },
        { '<leader>s.', builtin.oldfiles, desc = "[S]earch Recent Files ('.' for repeat)" },
        { '<leader><leader>', builtin.buffers, desc = '[ ] Find existing buffers' },
        { '<leader>sp', telescope.extensions.projects.projects, desc = '[S]earch [P]rojects' },
        { '<leader>/', builtin.current_buffer_fuzzy_find, desc = '[/] Fuzzily search in current buffer' },
        {
            '<leader>s/',
            function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end,
            desc = '[S]earch [/] in Open Files',
        },
        {
            '<leader>sn',
            function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end,
            desc = '[S]earch [N]eovim files',
        },
        {
            '<leader>so',
            function()
                if vim.env.WIKI == nil then
                    vim.notify 'WIKI environment variable is not set'
                    return
                end
                builtin.find_files { cwd = vim.env.WIKI }
            end,
            desc = '[S]earch [O]bsidian files',
        },

        { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Find explorer' },
    }
end

--- LSP keymaps
M.lsp_keymaps = function(wk)
    wk.add {
        { '<leader>l', group = 'LSP' },
        { '<leader>la', vim.lsp.buf.code_action, desc = '[L]sp Code [A]ction' },
        { '<leader>lr', vim.lsp.buf.rename, desc = '[L]sp [R]ename' },
        { '<leader>lf', vim.lsp.buf.format, desc = '[L]sp [F]ormat' },
        {
            'gd',
            vim.lsp.buf.definition,
            desc = '[g]o to [d]efinition (LSP)',
        },
        {
            'gD',
            vim.lsp.buf.declaration,
            desc = '[g]o to [D]eclaration (LSP)',
        },
        {
            'gi',
            vim.lsp.buf.implementation,
            desc = '[g]o to [i]mplementation (LSP)',
        },
        {
            "go",
            vim.lsp.buf.type_definition,
            desc = "[g]o to type definiti[o]n (LSP)",
        },
        {
            'gr',
            vim.lsp.buf.references,
            desc = '[g]o to [r]eferences (LSP)',
        },
        {
            'gs',
            vim.lsp.buf.signature_help,
            desc = '[g]o to [s]ignature help (LSP)',
        },
        {
            '<leader>o',
            '<cmd>ClangdSwitchSourceHeader<cr>',
            desc = 'switch between source and header',
        },
    }
end

--- Zen mode keymaps
M.zen_mode_keymaps = function(wk)
    wk.add {
        { '<leader>z', group = 'Zen Mode' },
        { '<leader>zr', '<cmd>TZNarrow<cr>', desc = 'Narrow' },
        { '<leader>zf', '<cmd>TZFocus<cr>', desc = 'Focus' },
        { '<leader>zm', '<cmd>TZMinimalist<cr>', desc = 'Minimalist' },
        { '<leader>za', '<cmd>TZAtaraxis<cr>', desc = 'Ataraxis' },
        { '<leader>zl', '<cmd>Limelight<cr>', desc = 'Limelight' },

        --- Trouble ---

        { '<leader>x', group = 'Trouble' },
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle focus=True<cr>',
            desc = 'Diagnostics (Trouble)',
        },
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0 focus=True<cr>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        {
            '<leader>xs',
            '<cmd>Trouble symbols toggle focus=false<cr>',
            desc = 'Symbols (Trouble)',
        },
        {
            '<leader>xl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
            '<leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List (Trouble)',
        },
        {
            '<leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List (Trouble)',
        },
    }
end

-- DAP keymaps
M.dap_keymaps = function(wk)
    local dap = require 'dap'
    local widgets = require 'dap.ui.widgets'
    wk.add {
        { '<leader>d', group = 'Dap' },
        { '<loader>db', dap.toggle_breakpoint, desc = 'Toggle Breakpoint (Dap)' },
        { '<leader>dc', dap.continue, desc = 'Continue (Dap)' },
        { '<leader>di', dap.step_into, desc = 'Step Into (Dap)' },
        { '<leader>do', dap.step_over, desc = 'Step Over (Dap)' },
        { '<leader>dO', dap.step_out, desc = 'Step Out (Dap)' },
        { '<leader>dr', dap.repl.toggle, desc = 'Toggle Repl (Dap)' },
        { '<leader>dL', dap.run_last, desc = 'Run Last (Dap)' },
        {
            '<loader>dl',
            function()
                require('osv').launch { port = 8086 }
            end,
            desc = 'Launch nvim plugin (Dap)',
        },
        { '<loader>dw', widgets.hover, desc = 'Widgets Hover (Dap)' },
        {
            '<leader>df',
            function()
                widgets.centered_float(widgets.frames)
            end,
            desc = 'Widgets Frames (Dap)',
        },
    }
end

M.gitsigns_keymaps = function(wk)
    local gitsigns = require 'gitsigns'
    wk.add {
        {
            ']c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gitsigns.nav_hunk('next')
                end
            end,
            desc = 'Go to next git [C]hunk (Gitsigns)',
            mode = 'n',
        },
        {
            '[c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gitsigns.nav_hunk('prev')
                end
            end,
            desc = 'Go to previous git [C]hunk (Gitsigns)',
            mode = 'n',
        },
        { '<leader>hs', gitsigns.stage_hunk, desc = '[s]tage Hunk (Gitsigns)', mode='n' },
        { '<leader>hr', gitsigns.reset_hunk, desc = '[r]eset Hunk (Gitsigns)', mode='n' },
        {
            '<leader>hs',
            function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end,
            desc = '[s]tage Hunk (Gitsigns)',
            mode = 'v'
        },
        {
            '<leader>hr',
            function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end,
            desc = '[r]eset Hunk (Gitsigns)',
            mode = 'v',
        },
        { '<leader>hS', gitsigns.stage_buffer, desc = '[S]tage Buffer (Gitsigns)', mode='n' },
        { '<leader>hR', gitsigns.reset_buffer, desc = '[R]eset Buffer (Gitsigns)', mode='n' },
        { '<leader>hp', gitsigns.preview_hunk, desc = 'Preview [H]unk (Gitsigns)', mode='n' },
        { '<leader>hi', gitsigns.preview_hunk_inline, desc = 'Preview Hunk [i]nline (Gitsigns)', mode='n' },
        {
            '<leader>hb',
            function()
                gitsigns.blame_line({ full = true })
            end,
            desc = '[B]lame Line (Gitsigns)',
            mode='n'
        },
        { '<leader>hd', gitsigns.diffthis, desc = '[Ddiff This (Gitsigns)', mode='n' },
        {
            '<leader>hD',
            function()
                gitsigns.diffthis('~')
            end,
            desc = 'Diff This [~] (Gitsigns)',
            mode='n'
        },
        {
            '<leader>hQ',
            function()
                gitsigns.setqflist('all')
            end,
            desc = 'Set [Q]uickfix List (Gitsigns)',
            mode='n'
        },
        { '<leader>hq', gitsigns.setqflist, desc = 'Set [q]uickfix List (Gitsigns)', mode='n'},
        { '<leader>tb', gitsigns.toggle_current_line_blame, desc = '[T]oggle Current Line [b]lame (Gitsigns)', mode='n' },
        { '<leader>tw', gitsigns.toggle_word_diff, desc = '[T]oggle [w]ord Diff (Gitsigns)', mode='n'},
        { 'ih', gitsigns.select_hunk, desc = 'Select [H]unk (Gitsigns)', mode={'o', 'x'}},
    }
end


M.setup = function()
    local wk = require 'which-key'
    wk.add {
        {
            '<leader>?',
            function()
                wk.show { global = false }
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
        { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic [Q]uickfix list' },
        {
            '<Esc>',
            '<cmd>nohlsearch<cr>',
            mode = 'n',
            desc = 'Clear search highlight',
        },
    }

    M.telescope_keymaps(wk)
    M.lsp_keymaps(wk)
    M.zen_mode_keymaps(wk)
    M.dap_keymaps(wk)
    M.gitsigns_keymaps(wk)

    wk.add {
        { 'gl', vim.diagnostic.open_float, desc = 'Show diagnostics' },
        { '[d', vim.diagnostic.get_prev, desc = 'Previous diagnostic' },
        { ']d', vim.diagnostic.get_next, desc = 'Next diagnostic' },
    }
end

return M
