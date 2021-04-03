# Coc Setup

[Plugins](plugins.md)

## Base config

Recommended configuration from
[https://github.com/neoclide/coc.nvim#example-vim-configuration](https://github.com/neoclide/coc.nvim#example-vim-configuration).

Some servers have issues with backup files, see #649.

```viml
set nobackup
set nowritebackup
```

Give more space for displaying messages.

```viml
set cmdheight=2
```

Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
delays and poor user experience.

```viml
set updatetime=300
```

Don't pass messages to |ins-completion-menu|.

```viml
set shortmess+=c
```

Use tab for trigger completion with characters ahead and navigate.
NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
other plugin before putting this into your config.

```viml
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
```

Always show the signcolumn, otherwise it would shift the text each time
diagnostics appear/become resolved.

```viml
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
```

Use <c-space> to trigger completion.
```viml
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
```

Make <CR> auto-select the first completion item and notify coc.nvim to
format on enter, <cr> could be remapped by other vim plugin
```viml
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
```

Use `[g` and `]g` to navigate diagnostics
Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.

```viml
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
```

GoTo code navigation.
```viml
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
```

Use K to show documentation in preview window.
```viml
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
```

Highlight the symbol and its references when holding the cursor.
```viml
autocmd CursorHold * silent call CocActionAsync('highlight')
```

Symbol renaming.
```viml
nmap <leader>rn <Plug>(coc-rename)
```

Formatting selected code.

```viml
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
```

Applying codeAction to the selected region.
Example: `<leader>aap` for current paragraph
```viml
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
```

Remap keys for applying codeAction to the current buffer.
```viml
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
```
Apply AutoFix to problem on the current line.
```viml
nmap <leader>qf  <Plug>(coc-fix-current)
```

Map function and class text objects
NOTE: Requires 'textDocument.documentSymbol' support from the language server.

```viml
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
```

Remap <C-f> and <C-b> for scroll float windows/popups.
```viml
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif
```

Use CTRL-S for selections ranges.
Requires 'textDocument/selectionRange' support of language server.
```viml
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
```

Add `:Format` command to format current buffer.
```viml
command! -nargs=0 Format :call CocAction('format')
```

Add `:Fold` command to fold current buffer.
```viml
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
```

Add `:OR` command for organize imports of the current buffer.
```viml
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
```

Add NeoVim's native statusline support.
NOTE: Please see `:h coc-status` for integrations with external plugins that
provide custom statusline: lightline.vim, vim-airline.
```viml
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
```

```viml
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
```

## Old custom configuration

### Snippets
```viml
" Use <C-l> for triggering snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for selecting text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> to jump to the next placeholder, it's the default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jumping to the previous placeholder, it's the default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> to both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
```

```viml
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

"let g:coc_global_extensions = ['coc-python', 'coc-rome']

let g:autofmt_autosave = 1

```

<!-- vim: set ft=vim: set conceallevel=0: -->
