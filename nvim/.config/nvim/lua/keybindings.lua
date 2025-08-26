local M = {}

M.setup = function()
	local telescope_builtin = require("telescope.builtin")
	local wk = require("which-key")
	wk.add({
		{
			"<leader>?",
			function()
				wk.show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
		{ "<leader>g", telescope_builtin.git_files, desc = "Find git tracked files" },
		{ "<leader>s", telescope_builtin.live_grep, desc = "Keyword search" },
		{ "<leader>f", telescope_builtin.find_files, desc = "Find file" },
		{ "<leader>p", require('telescope').extensions.projects.projects, desc = "Find project" },
		{ "<leader>t", group = "Search" },
		{ "<leader>tb", telescope_builtin.buffers, desc = "Buffers" },
		{ "<leader>tp", telescope_builtin.builtin, desc = "Builtin pickers" },
		{ "<leader>th", telescope_builtin.help_tags, desc = "Help tags" },
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Find explorer" },
		{
			"<leader>o",
			"<cmd>ClangdSwitchSourceHeader<cr>",
			desc = "Switch between source and header",
		},
		{
			"<leader>D",
			vim.lsp.buf.type_definition,
			desc = "Lsp type definition",
		},
		{ "<leader>l", group = "LSP" },
		{ "<leader>la", vim.lsp.buf.code_action, desc = "Lsp code action" },
		{ "<leader>lr", vim.lsp.buf.rename, desc = "Lsp rename" },
		{ "<leader>lf", vim.lsp.buf.format, desc = "Lsp format" },
		{ "<leader>z", group = "Zen Mode" },
		{ "<leader>zr", "<cmd>TZNarrow<cr>", desc = "Narrow" },
		{ "<leader>zf", "<cmd>TZFocus<cr>", desc = "Focus" },
		{ "<leader>zm", "<cmd>TZMinimalist<cr>", desc = "Minimalist" },
		{ "<leader>za", "<cmd>TZAtaraxis<cr>", desc = "Ataraxis" },
		{ "<leader>zl", "<cmd>Limelight<cr>", desc = "Limelight" },
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
	})
end

return M
