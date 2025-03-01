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
		{ "<leader>f", telescope_builtin.find_files, desc = "Find file" },
		{ "<leader>g", telescope_builtin.git_files, desc = "Find git files" },
		{ "<leader>t", group = "Search" },
		{ "<leader>tg", telescope_builtin.live_grep, desc = "Live grep" },
		{ "<leader>tb", telescope_builtin.buffers, desc = "Buffers" },
		{ "<leader>tp", telescope_builtin.builtin, desc = "Builtin pickers" },
		{ "<leader>th", telescope_builtin.help_tags, desc = "Help tags" },
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Find explorer" },
		{
			"<leader>s",
			"<cmd>ClangdSwitchSourceHeader<cr>",
			desc = "Switch between source and header",
		},
		{
			"<leader>D",
			vim.lsp.buf.type_definition,
			desc = "Lsp type definition",
		},
		{ "<leader>a", vim.lsp.buf.code_action, desc = "Lsp code action" },
		{ "<leader>r", vim.lsp.buf.rename, desc = "Lsp rename" },
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
	})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { silent = true })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
end

return M
