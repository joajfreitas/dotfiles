-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print("Done.")
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "folke/tokyonight.nvim" },
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
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
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
		opts = {},
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
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")
local time = os.date("*t")

local sunset = { 18, 18, 19, 20, 21, 22, 22, 21, 20, 19, 18, 18 }
local sunrise = { 8, 8, 7, 6, 7, 6, 6, 7, 7, 8, 7, 8 }

if time.hour < sunrise[time.month] or time.hour > sunset[time.month] then
	vim.o.background = "dark"
else
	vim.o.background = "light"
end

vim.o.autochdir = true
vim.wo.number = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

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

require("lspconfig").tsserver.setup({
	single_file_support = false,
	on_init = function(client)
		-- disable formatting capabilities
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").clangd.setup({})

lsp_zero.setup_servers({ "rust_analyzer" })

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

lvim = {
	use_icons = true,
	icons = {
		kind = {
			Array = "",
			Boolean = "",
			Class = "",
			Color = "",
			Constant = "",
			Constructor = "",
			Enum = "",
			EnumMember = "",
			Event = "",
			Field = "",
			File = "",
			Folder = "󰉋",
			Function = "",
			Interface = "",
			Key = "",
			Keyword = "",
			Method = "",
			Module = "",
			Namespace = "",
			Null = "󰟢",
			Number = "",
			Object = "",
			Operator = "",
			Package = "",
			Property = "",
			Reference = "",
			Snippet = "",
			String = "",
			Struct = "",
			Text = "",
			TypeParameter = "",
			Unit = "",
			Value = "",
			Variable = "",
		},
		git = {
			LineAdded = "",
			LineModified = "",
			LineRemoved = "",
			FileDeleted = "",
			FileIgnored = "◌",
			FileRenamed = "",
			FileStaged = "S",
			FileUnmerged = "",
			FileUnstaged = "",
			FileUntracked = "U",
			Diff = "",
			Repo = "",
			Octoface = "",
			Branch = "",
		},
		ui = {
			ArrowCircleDown = "",
			ArrowCircleLeft = "",
			ArrowCircleRight = "",
			ArrowCircleUp = "",
			BoldArrowDown = "",
			BoldArrowLeft = "",
			BoldArrowRight = "",
			BoldArrowUp = "",
			BoldClose = "",
			BoldDividerLeft = "",
			BoldDividerRight = "",
			BoldLineLeft = "▎",
			BookMark = "",
			BoxChecked = "",
			Bug = "",
			Stacks = "",
			Scopes = "",
			Watches = "󰂥",
			DebugConsole = "",
			Calendar = "",
			Check = "",
			ChevronRight = "",
			ChevronShortDown = "",
			ChevronShortLeft = "",
			ChevronShortRight = "",
			ChevronShortUp = "",
			Circle = " ",
			Close = "󰅖",
			CloudDownload = "",
			Code = "",
			Comment = "",
			Dashboard = "",
			DividerLeft = "",
			DividerRight = "",
			DoubleChevronRight = "»",
			Ellipsis = "",
			EmptyFolder = "",
			EmptyFolderOpen = "",
			File = "",
			FileSymlink = "",
			Files = "",
			FindFile = "󰈞",
			FindText = "󰊄",
			Fire = "",
			Folder = "󰉋",
			FolderOpen = "",
			FolderSymlink = "",
			Forward = "",
			Gear = "",
			History = "",
			Lightbulb = "",
			LineLeft = "▏",
			LineMiddle = "│",
			List = "",
			Lock = "",
			NewFile = "",
			Note = "",
			Package = "",
			Pencil = "󰏫",
			Plus = "",
			Project = "",
			Search = "",
			SignIn = "",
			SignOut = "",
			Tab = "󰌒",
			Table = "",
			Target = "󰀘",
			Telescope = "",
			Text = "",
			Tree = "",
			Triangle = "󰐊",
			TriangleShortArrowDown = "",
			TriangleShortArrowLeft = "",
			TriangleShortArrowRight = "",
			TriangleShortArrowUp = "",
		},
		diagnostics = {
			BoldError = "",
			Error = "",
			BoldWarning = "",
			Warning = "",
			BoldInformation = "",
			Information = "",
			BoldQuestion = "",
			Question = "",
			BoldHint = "",
			Hint = "󰌶",
			Debug = "",
			Trace = "✎",
		},
		misc = {
			Robot = "󰚩",
			Squirrel = "",
			Tag = "",
			Watch = "",
			Smiley = "",
			Package = "",
			CircuitBoard = "",
		},
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		max_width = 0,
		--kind_icons = lvim.icons.kind,
		source_names = {
			nvim_lsp = "(LSP)",
			emoji = "(Emoji)",
			path = "(Path)",
			calc = "(Calc)",
			cmp_tabnine = "(Tabnine)",
			vsnip = "(Snippet)",
			luasnip = "(Snippet)",
			buffer = "(Buffer)",
			tmux = "(TMUX)",
			copilot = "(Copilot)",
			treesitter = "(TreeSitter)",
		},
		duplicates = {
			buffer = 1,
			path = 1,
			nvim_lsp = 0,
			luasnip = 1,
		},
		duplicates_default = 0,
	},
}

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

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnippets" })

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

local telescope_builtin = require("telescope.builtin")

local wk = require("which-key")

wk.register({
	f = { telescope_builtin.find_files, "Find file" },
	g = { telescope_builtin.git_files, "Find git files" },
	t = {
		name = "telescope", -- optional group name
		g = { telescope_builtin.live_grep, "Live grep" },
		b = { telescope_builtin.buffers, "Buffers" },
		h = { telescope_builtin.help_tags, "Help tags" },
	},
	e = { "<cmd>Neotree<cr>", "File explorer" },
	s = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch between source and header" },
	D = { vim.lsp.buf.type_definition, "Lsp type definition" },
	a = { vim.lsp.buf.code_action, "Lsp code action" },
	r = { vim.lsp.buf.rename, "Lsp rename" },
	z = {
		name = "zen",
		n = { "<cmd>TZNarrow<cr>", "Narrow" },
		f = { "<cmd>TZFocus<cr>", "Focus" },
		m = { "<cmd>TZMinimalist<cr>", "Minimalist" },
		a = { "<cmd>TZAtaraxis<cr>", "Ataraxis" },
		l = { "<cmd>Limelight<cr>", "Limelight" },
	},
}, { prefix = "<leader>" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true })

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4


---neotree---
require("neo-tree").setup({
        source_selector = {
            statusline = true,
        }
    })
