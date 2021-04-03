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
call plug#begin()
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
nnoremap <leader>se :UltiSnipsEdit<CR>

"let g:UltiSnipsSnippetsDir = '~/.local/share/nvim/plugged/vim-snippets/snippets'
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsListSnippets = '<nop>'
"let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
let g:ulti_expand_or_jump_res = 0
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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
Plug 'prabirshrestha/async.vim'
Plug 'ihsanturk/neuron.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 238
  nmap <silent> gl :Limelight!!<CR>
  xmap gl <Plug>(Limelight)


Plug 'vimwiki/vimwiki'
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_global_ext = 0

nnoremap <Leader>wn :! lj diary-note<CR> :e ~/vimwiki/diary/diary.md<CR>

command Wiki Goyo | Limelight | VimwikiDiaryIndex
Plug 'scrooloose/nerdtree'
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
Plug 'morhetz/gruvbox'
Plug 'lervag/vimtex'
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
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
let g:mkdp_auto_close = 0
nnoremap <Leader>m :MarkdownPreview<CR>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'


Plug 'itspriddle/vim-shellcheck'
Plug 'wsdjeg/vim-lua'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

set foldenable

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#mode = ["syntax"]

let g:pandoc#keyboard#use_default_mappings = 1
"let g:pandoc#modules#enabled = ["formatting", "folding", "keyboard", "lists", "references", "styles", "sections", "links", "checkboxes"]
let g:pandoc#formatting#mode = "h"

let g:vimwiki_folding='expr'
au FileType vimwiki set filetype=vimwiki.markdown

Plug 'mzlogin/vim-markdown-toc'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/Conque-GDB'
Plug 'hjson/vim-hjson'
Plug 'tpope/vim-commentary'
Plug 'stephpy/vim-yaml'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lepture/vim-jinja'
"Plug 'ziglang/zig.vim'
"Plug 'elixir-editors/vim-elixir'
"Plug 'StanAngeloff/php.vim'
"Plug 'shmup/vim-sql-syntax'
"Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'file:///home/joaj/projects/f-lang/mal/impls/flang/mal-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'nightsense/cosmic_latte'
Plug 'rust-lang/rust.vim'
call plug#end()
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
set spell
set spelllang=pt_pt,en
hi SpellBad cterm=underline

"colors
"colors gruvbox
if strftime('%H') >= 7 && strftime('%H') < 17
  set background=light
else
  set background=dark
endif

colorscheme cosmic_latte

set background=dark
set t_Co=256
let g:gruvbox_termcolors=16

"set complete+=kspell

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

let g:fzf_layout = { 'up': '~50%' }
nnoremap <Leader>f :Rg<CR>

let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'

autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab smarttab
autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab smarttab
autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab smarttab

"execute literatevim#load("/home/joaj/.config/nvim/init.md")

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
