local M = {}

M.setup = function()
    local telescope_builtin = require("telescope.builtin")
    local wk = require("which-key")
    wk.add({
        {"<leader>f", telescope_builtin.find_files, desc="Find file"},
        {"<leader>g", telescope_builtin.git_files, desc="Find git files"},
        {"<leader>s", group = "[S]earch"},
        {"<leader>sh", telescope_builtin.help_tags, desc="[S]earch [H]elp"},
        {"<leader>sk", telescope_builtin.keymaps, desc="[S]earch [K]eymaps"},
        {"<leader>sf", telescope_builtin.find_files, desc="[S]earch [F]iles"},
        {"<leader>ss", telescope_builtin.builtin, desc="[S]earch [S]elect Telescope"},
        {"<leader>sw", telescope_builtin.grep_string, desc="[S]earch current [W]ord"},
        {"<leader>sg", telescope_builtin.live_grep, desc="[S]earch by [G]rep"},
        {"<leader>sd", telescope_builtin.diagnostics, desc="[S]earch [D]iagnostics"},
        {"<leader>sr", telescope_builtin.resume, desc="[S]earch [R]esume"},
        {"<leader>s.", telescope_builtin.oldfiles, desc="[S]earch Recent Files ('.' for repeat)"},
        {"<leader><leader>", telescope_builtin.buffers, desc="[ ] Find existing buffers"},
        {
                "<leader>/",
                function()
                        telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                                winblend = 10,
                                previewer = false,
                        })
                end,
                desc = "[/] Fuzzy search in current buffer"
        },
        {
                "<leader>s/",
                function()
                        telescope_builtin.live_grep {
                                grep_open_files = true,
                                prompt_title = "Grep in open files",
                        }
                end,
                desc = "[S]earch  [/] in open files"
        },
        {
                "<leader>sn",
                function()
                        telescope_builtin.find_files { cwd = vim.fn.stdpath 'config' }
                end,
                desc = "[S]earch [N]eovim files"
        },
        {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc="File explorer"},
        {"<leader>o", "<cmd>ClangdSwitchSourceHeader<cr>", desc="Switch between source and header"},
        {"<leader>D", vim.lsp.buf.type_definition, desc="Lsp type definition"},
	{"<leader>l", group = "[L]sp"},
	{"<leader>la", vim.lsp.buf.code_action, desc = "Lsp code action" },
	{"<leader>lr", vim.lsp.buf.rename, desc = "Lsp rename" },
	{"<leader>lf", vim.lsp.buf.format, desc = "Lsp format" },
        {"<leader>z", group = "[Z]en"},
        {"<leader>zn", "<cmd>TZNarrow<cr>", desc="Narrow"},
        {"<leader>zf", "<cmd>TZFocus<cr>", desc="Focus"},
        {"<leader>zm", "<cmd>TZMinimalist<cr>", desc="Minimalist"},
        {"<leader>za", "<cmd>TZAtaraxis<cr>", desc="Ataraxis"},
        {"<leader>zl", "<cmd>Limelight<cr>", desc="Limelight"},
	{ "<leader>x", group = "Trouble" },
	{
		"<leader>xx",
		"<cmd>Trouble diagnostics toggle focus=True<cr>",
		desc = "Diagnostics (Trouble)",
	},
	{
		"<leader>xX",
		"<cmd>Trouble diagnostics toggle filter.buf=0 focus=True<cr>",
		desc = "Buffer Diagnostics (Trouble)",
	},
	{
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		desc = "Symbols (Trouble)",
	},
	{
		"<leader>xl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "LSP Definitions / references / ... (Trouble)",
	},
	{
		"<leader>xL",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "Location List (Trouble)",
	},
	{
		"<leader>xQ",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "Quickfix List (Trouble)",
	},
	{
		"gd",
		vim.lsp.buf.definition,
		desc = "Go to definition (LSP)",
	},
	{
		"gD",
		vim.lsp.buf.declaration,
		desc = "Go to declaration (LSP)",
	},
	{
		"gi",
		vim.lsp.buf.implementation,
		desc = "Go to implementation (LSP)",
	},
	{
		"go",
		vim.lsp.buf.type_definition,
		desc = "Go to type definition (LSP)",
	},
	{
		"gr",
		vim.lsp.buf.references,
		desc = "Go to references (LSP)",
	},
	{
		"gs",
		vim.lsp.buf.signature_help,
		desc = "Signature help (LSP)",
	},
	{ "gl", vim.diagnostic.open_float, desc = "Show diagnostics" },
	{ "[d", vim.diagnostic.get_prev, desc = "Previous diagnostic" },
	{ "]d", vim.diagnostic.get_next, desc = "Next diagnostic" },
	{ "<leader>q", vim.diagnostic.setloclist, desc = "Quickfix list" },
        {
          '<leader>lk',
          function()
            local acronym = vim.fn.input {
              prompt = 'Acronym: ',
            }
            local result = require('acronym-viewer').lookup(acronym)
            if result == nil then
              vim.notify('Could not find a definition for ' .. acronym .. '.', vim.log.levels.ERROR)
            else
              vim.notify(result, vim.log.levels.INFO)
            end
          end,
        },
    })

    vim.keymap.set("n", "gre", require('telescope.builtin').lsp_references, {silent=true})
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, {silent = true})
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, {silent = true})
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, {silent = true})

end

return M
