call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'nightsense/cosmic_latte'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'itspriddle/vim-shellcheck'
Plug 'wsdjeg/vim-lua'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mzlogin/vim-markdown-toc'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/Conque-GDB'
Plug 'hjson/vim-hjson'
Plug 'tpope/vim-commentary'
Plug 'stephpy/vim-yaml'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lepture/vim-jinja'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dubek/vim-mal'
Plug 'joajfreitas/fcp.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
call plug#end()
let g:fzf_nvim_statusline = 0

"This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

"Default fzf layout
"down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

"In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

"Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Enable per-command history.
"CTRL-N and CTRL-P will be automatically bound to next-history and
"previous-history instead of down and up. If you don't like the change,
"explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"[Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

"[[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

"[Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

"[Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '14%'})
" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

imap <C-f> <esc>:FZF<cr>
nmap <C-f> :FZF<cr>
let g:fzf_layout = { 'up': '~50%' }
nnoremap <Leader>f :Rg<CR>
nnoremap <leader>se :UltiSnipsEdit<CR>

"let g:UltiSnipsSnippetsDir = '~/.local/share/nvim/plugged/vim-snippets/snippets'
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsListSnippets = '<nop>'
"let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
let g:ulti_expand_or_jump_res = 0
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_ctermfg = 238
nmap <silent> gl :Limelight!!<CR>
xmap gl <Plug>(Limelight)
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0

nnoremap <Leader>wn :! lj diary-note<CR> :e ~/vimwiki/diary/diary.md<CR>

command Wiki Goyo | Limelight | VimwikiDiaryIndex

let g:vimwiki_folding='expr'
au FileType vimwiki set filetype=vimwiki.markdown
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeWinSize = 31
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeCascadeOpenSingleChildDir = 1

  map <F1> :call NERDTreeToggleAndFind()<cr>
  map <F2> :NERDTreeToggle<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
augroup latex
  autocmd!
  autocmd FileType tex nnoremap <buffer><F5> :VimtexCompile<CR>
  autocmd FileType tex map <silent> <buffer><F8> :call vimtex#latexmk#errors_open(0)<CR>
augroup END

let g:vimtex_compiler_latexmk = {
	\ 'options' : [
	\   '-pvc',
	\   '-pdf',
	\   '-e "$pdflatex=q/pdflatex %O -pdf -f -interaction=nonstopmode %S/"',
	\ ],
	\}
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#mode = ["syntax"]

let g:pandoc#keyboard#use_default_mappings = 1
"let g:pandoc#modules#enabled = ["formatting", "folding", "keyboard", "lists", "references", "styles", "sections", "links", "checkboxes"]
let g:pandoc#formatting#mode = "h"
let g:mkdp_auto_close = 0
nnoremap <Leader>m :MarkdownPreview<CR>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {"rust", "python"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.spell = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
"let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
map <Space> <Leader>
nnoremap <SPACE> <Nop>
let mapleader=" "
set showcmd
set completeopt+=noinsert
set completeopt+=preview

set hidden
set nu
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'

"activate mouse
set mouse=a

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" keep the cursor visible within 5 lines when scrolling
set scrolloff=5

"highlight matching [{()}C9]
set showmatch

" indentation
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces
set tabstop=4

set colorcolumn=80
if strftime('%H') >= 8 && strftime('%H') < 17
  colorscheme gruvbox 
  set background=light
else
  colors cosmic_latte
  set background=dark
endif

set t_Co=256
" TODO: https://github.com/nvim-treesitter/nvim-treesitter/issues/698
" enable spell checking again when this issue is solved
"set spell
set spelllang=pt_pt,en
hi SpellBad cterm=underline
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
set foldmethod=syntax
set foldnestmax=10
set foldlevel=0
" auto-save fold views
"augroup AutoSaveFolds
"autocmd!
"autocmd BufWinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview
"augroup END
set foldenable
"status line
"set laststatus=2
"
"set statusline=%F							"full path to file in the buffer
"set statusline+=%m                          "rodified flag in square brackets
"set statusline+=%r							"readonly flag in square brackets
"set statusline+=%h                          "help flag in square brackets
"set statusline+=%w                          "preview flag in square brackets
"set statusline+=%=                          "split justification
"set statusline+=%<[                         "truncation point
"set statusline+=%{&ff}]                     "current fileformat
"set statusline+=%y[                         "current syntax
"set statusline+=%p][                        "current % into file
"set statusline+=%00l/                       "current line
"set statusline+=%L,                         "number of lines
"set statusline+=%00v]                       "current column
"
"set foldenable
""set foldmethod=indent   " fold based on indent level
"set foldlevelstart=10   " open most folds by default
"set foldnestmax=10      " 10 nested fold max
let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'
"autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab smarttab
"autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab smarttab
"autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab smarttab

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
