---
title: vimrc
---


## Leader

Map space as leader.

```viml
map <Space> <Leader>
nnoremap <SPACE> <Nop>
let mapleader=" "
```

```viml
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
```

[plugins.md](plugins.md)


```viml
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

```

## Spell Checker

Spell check configuration

```viml
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
```

```viml

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
```

<!-- vim: set ft=vim: -->
