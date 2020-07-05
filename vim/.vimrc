"PLUG--------------------------------------------------------------------------
"{{{
call plug#begin('~/.vim/bundle')

Plug 'mzlogin/vim-markdown-toc'

"Cosmetic
Plug 'PotatoesMaster/i3-vim-syntax'     "syntax for i3 files
Plug 'morhetz/gruvbox'

Plug 'majutsushi/tagbar'

Plug 'tpope/vim-eunuch'				 "unix commands
Plug 'tpope/vim-fugitive'            "git
Plug 'tpope/vim-commentary'          "commentary
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'            "compile asynchronously
Plug 'tpope/vim-vinegar'             "project drawer
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-afterimage'
Plug 'tpope/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
"Plug 'vim-scripts/Conque-GDB'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/greplace.vim'

"Plug 'ctrlpvim/ctrlp.vim'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'junegunn/vim-easy-align'

Plug 'mustache/vim-mustache-handlebars'


Plug 'chrisbra/Colorizer'

Plug 'junegunn/goyo.vim'

"Plug 'vim-airline/vim-airline'
Plug 'mateusbraga/vim-spell-pt-br'

Plug 'junegunn/fzf.vim'

Plug 'elixir-editors/vim-elixir'

Plug 'fatih/vim-go'

Plug 'vimwiki/vimwiki'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

Plug 'stephpy/vim-yaml'

Plug 'rhysd/git-messenger.vim'

"
call plug#end()
"}}}
"CUSTOMIZATION-----------------------------------------------------------------
"{{{
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience
"

"Space is leader
"let mapleader = "\\"
let mapleader = "\<Space>"
"let mapleader = ","

" run quickfix after make
"autocmd QuickFixCmdPost * copen

"Automaticly go to directory file is in
"set autochdir

"" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

"define delay when expecting commads
set timeout timeoutlen=500 ttimeoutlen=100

" windows like clipboard
" yank to and paste from the clipboard without prepending "* to commands
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'

" move vertically by visual line
nnoremap j gj
nnoremap k gk

"use this instead with relative numbers
"set relativenumber     "relative numbers
"noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" search settings
set incsearch        " find the next match as we type the search
set hlsearch         " hilight searches by default

" suggestion for normal mode commands
set wildmode=list:longest

" keep the cursor visible within 5 lines when scrolling
set scrolloff=5

" indentation
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces
set tabstop=4

" no lines longer than 80 cols
" set textwidth=79
"
"go to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
"select pasted code
noremap gV `[v`]

set showcmd

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

"vimtex
let g:vimtex_compiler_latexmk = {
	\ 'options' : [
	\   '-pvc',
	\   '-pdf',
	\   '-e "$pdflatex=q/pdflatex %O -pdf -f -interaction=nonstopmode %S/"',
	\ ],
	\}

"autocmd BufWinEnter __run__,__doc__ :wincmd H

"}}}
"PLUGIN CONFIG----------------------------------------------------------------
"{{{
"
"latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

nnoremap <Leader>y :ConqueGdbCommand y<CR>
nnoremap <Leader>n :ConqueGdbCommand n<CR>
nmap <Leader>g :ConqueGdb<CR>

"autocmd vimenter * NERDTree
"map <C-n> :NERDTreeToggle<CR>

" Tagbar toggle and auto close
nmap <Leader>q :TagbarToggle<CR>
nmap <Leader>T :TagbarOpenAutoClose<CR>
nmap <Leader>c :!ctags *.c *.h<CR>

"ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/.vim/my-snippets"]
set runtimepath+=~/.vim/my-snippets/

let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufWinEnter * NERDTreeMirror

let g:NERDTreeWinSize=25

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

map <C-n> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
nmap <silent> <Leader>r :call clighter#Rename()<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:vimwiki_list = [{'template_path': '$HOME/vimwiki/templates',
		  \ 'template_default': 'def_template',
		  \ 'template_ext': '.html'}]

" # add the pre tag for inserting code snippets
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr, pre, script'

"let g:livepreview_previewer = 'zathura'
"set rtp^=/usr/share/vimpager
"}}}
"COLORS-----------------------------------------------------------------------
"{{{
colors gruvbox
set background=dark
set t_Co=256
let g:gruvbox_termcolors=16


"make a mark for column 80
set colorcolumn=80
highlight colorcolumn ctermbg=0 guibg=lightcyan


"show cursor line only when focused
augroup highlight_follows_focus
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup END

augroup highligh_follows_vim
	autocmd!
	autocmd FocusGained * set cursorline
	autocmd FocusLost * set nocursorline
augroup END

" On file types...
"   .md files are markdown files
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
"   set ft=masm for every .as file
autocmd BufRead,BufNewFile *.as setlocal filetype=masm
"}}}
"BACKUP------------------------------------------------------------------------
"{{{
if has("persistent_undo")
	set undodir=~/.vim/undodir/
	set undofile
endif

"set guioptions -=m
"set guioptions -=T

" remove the .ext~ files, but not the swapfiles
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
"}}}
"USABILITY CONFIGURATION ------------------------------------------------------
"{{{
"  Basic and pretty much needed settings to provide a solid base for source
"  code editting

" don't make vim compatible with vi
set nocompatible

" turn on syntax highlighting
syntax on

"show line numbers
"set number

" make vim try to detect file types and load plugins for them
filetype indent plugin on

set omnifunc=syntaxcomplete#Complete

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" by default, in insert mode backspace won't delete over line breaks, or
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" dont't unload buffers when they are abandoned, instead stay in the background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other non-typed
" comments
set lazyredraw

"highlight matching [{()}C9]
set showmatch

"show command in bottom bar
set showcmd

"visual autocomplete for command menu
set wildmenu

"activate mouse
set mouse=a

setlocal spell
set spelllang=pt_pt,en
hi clear SpellBad
"hi SpellBad cterm=underline
hi SpellBad cterm=bold
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"wrap
"set tw=79
"}}}
"LEADER KEYS-------------------------------------------------------------------
"{{{
set wmw=0
"nmap <Leader><Leader> :b#<CR>

"space open/closes folds
nnoremap <leader>f za

nmap <F2> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v
"}}}
"STATUS LINE-------------------------------------------------------------------
"{{{
set laststatus=2

set statusline=%F							"full path to file in the buffer
set statusline+=%m                          "rodified flag in square brackets
set statusline+=%r							"readonly flag in square brackets
set statusline+=%h                          "help flag in square brackets
set statusline+=%w                          "preview flag in square brackets
set statusline+=%=                          "split justification
set statusline+=%<[                         "truncation point
set statusline+=%{&ff}]                     "current fileformat
set statusline+=%y[                         "current syntax
set statusline+=%p][                        "current % into file
set statusline+=%00l/                       "current line
set statusline+=%L,                         "number of lines
set statusline+=%00v]                       "current column

set foldenable
"set foldmethod=indent   " fold based on indent level
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
"}}}
"Extend
"{{{

autocmd FileType python setlocal omnifunc=python3complete#Complete

"set tags+=$HOME/.vim/tags/python.ctags

set conceallevel=2
" sunaku's vim/tmux 256color hack. more info here:
" https://github.com/ninrod/tricks/blob/master/shell/tmux.md#sunakus-hack-for-fixing-256-colors-colorschemes-for-vim-inside-tmux
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"}}}

" inkscape latex
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/images/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/images/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

set nu
"source ~/.vim/config/user.vim
"
" vim:foldmethod=marker:foldlevel=0
