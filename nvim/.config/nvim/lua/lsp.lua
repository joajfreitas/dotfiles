local M = {}

M.setup = function()
	local lsp_zero = require("lsp-zero")

	local lua_opts = lsp_zero.nvim_lua_ls({
		single_file_support = false,
		on_attach = function(client, bufnr)
			print("hello world")
		end,
	})

	require("lspconfig").lua_ls.setup(lua_opts)

	lsp_zero.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps({ buffer = bufnr })
	end)

	--- if you want to know more about lsp-zero and mason.nvim
	--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
	require("mason").setup({})
	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
	})

	require("lspconfig").clangd.setup({})
	require("lspconfig").lua_ls.setup({
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	})

	local cmp = require("cmp")
	local cmp_action = require("lsp-zero").cmp_action()

	local lvim = require("lvim")

	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			-- `Enter` key to confirm completion
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			-- Ctrl+Space to trigger completion menu
			["<C-Space>"] = cmp.mapping.complete(),

			-- Navigate between snippet placeholder
			["<C-f>"] = cmp_action.luasnip_jump_forward(),
			["<C-b>"] = cmp_action.luasnip_jump_backward(),

			-- Scroll up and down in the completion documentation
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "ledger" },
		},
		formatting = {
			format = function(entry, vim_item)
				local max_width = 0 --lvim.builtin.cmp.formatting.max_width
				if max_width ~= 0 and #vim_item.abbr > max_width then
					vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
				end
				if lvim.use_icons then
					vim_item.kind = lvim.icons.kind[vim_item.kind] --lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

					if entry.source.name == "copilot" then
						vim_item.kind = lvim.icons.git.Octoface
						vim_item.kind_hl_group = "CmpItemKindCopilot"
					end

					if entry.source.name == "cmp_tabnine" then
						vim_item.kind = lvim.icons.misc.Robot
						vim_item.kind_hl_group = "CmpItemKindTabnine"
					end

					if entry.source.name == "crates" then
						vim_item.kind = lvim.icons.misc.Package
						vim_item.kind_hl_group = "CmpItemKindCrate"
					end

					if entry.source.name == "lab.quick_data" then
						vim_item.kind = lvim.icons.misc.CircuitBoard
						vim_item.kind_hl_group = "CmpItemKindConstant"
					end

					if entry.source.name == "emoji" then
						vim_item.kind = lvim.icons.misc.Smiley
						vim_item.kind_hl_group = "CmpItemKindEmoji"
					end
				end
				vim_item.menu = lvim.formatting.source_names[entry.source.name]
				vim_item.dup = lvim.formatting.duplicates[entry.source.name] or lvim.formatting.duplicated_default --builtin.cmp.formatting.duplicates_default

				return vim_item
			end,
		},
	})
end

return M
