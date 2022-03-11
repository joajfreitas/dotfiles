set nu

nnoremap j gj
nnoremap k gk

set clipboard=unnamed
set mouse=a

set incsearch
set hlsearch
set showmatch

set colorcolumn=80

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
call plug#end()

set completeopt=menu,menuone,noselect
colorscheme gruvbox
set background=dark

lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
	tools = {
		autoSetHints = true,
		hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},
	server = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = 'clippy'
				},

			}
		}

	},
}

--require('rust-tools').setup(opts)
require("lspconfig").pylsp.setup{}
require("lspconfig").clangd.setup{}

local cmp = require'cmp'
cmp.setup({
	snippet = {
	expand = function(args)
		vim.fn["vsnip#anonymous"](args.body)
	end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behaviour = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},
	
	sources = cmp.config.sources({
		{name = 'nvim_lsp' },
		{name = 'vsnip' },
		{name = 'path' },
		{name = 'buffer' },
	}),
})

EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
