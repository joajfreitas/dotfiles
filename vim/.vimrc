"PLUG--------------------------------------------------------------------------
"{{{
call plug#begin('~/.vim/bundle')

"Cosmetic
Plug 'PotatoesMaster/i3-vim-syntax'     "syntax for i3 files
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-eunuch'				 "unix commands
Plug 'tpope/vim-fugitive'            "git
Plug 'tpope/vim-commentary'          "commentary
Plug 'tpope/vim-vinegar'             "project drawer
Plug 'tpope/vim-tbone'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mateusbraga/vim-spell-pt-br'
"
call plug#end()
"}}}
"CUSTOMIZATION-----------------------------------------------------------------
"{{{

"Space is leader
let mapleader = "\<Space>"

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

set showcmd

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>
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

"}}}
"BACKUP------------------------------------------------------------------------
"{{{
if has("persistent_undo")
	set undodir=~/.vim/undodir/
	set undofile
endif

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
set number

" make vim try to detect file types and load plugins for them
filetype indent plugin on

set omnifunc=syntaxcomplete#Complete

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" by default, in insert mode backspace won't delete over line breaks, or
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" dont't unload buffers when they are abandoned, instead stay in the background
set hidden

" set unix line endings
"set fileformat=unix
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
set spelllang=en,pt_pt
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
" vim:foldmethod=marker:foldlevel=0
