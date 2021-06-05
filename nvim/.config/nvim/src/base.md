# Base config

[vimrc](vimrc.md)

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

## Colorscheme
Light theme in the morning, dark theme at night.

```viml
if strftime('%H') >= 8 && strftime('%H') < 17
  colorscheme gruvbox 
  set background=light
else
  "colorscheme OceanicNext
  colors cosmic_latte
  set background=dark
endif

set t_Co=256
```

## Spellchecking

Spell check configuration.

```viml
" TODO: https://github.com/nvim-treesitter/nvim-treesitter/issues/698
" enable spell checking again when this issue is solved
"set spell
set spelllang=pt_pt,en
hi SpellBad cterm=underline
```

## Resume last position

Uncomment the following to have Vim jump to the last position when
reopening a file.

```viml
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
```

## Folds

Enable folds

```viml
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
```


<!-- vim: set ft=vim: set conceallevel=0-->
