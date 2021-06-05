# Markdown Preview

[Plugins](plugins.md)

[https://github.com/iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)

## Configuration

```viml
let g:mkdp_auto_close = 0
nnoremap <Leader>m :MarkdownPreview<CR>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

let g:mkdp_browser = 'qutebrowser'
set updatetime=100
```


<!-- vim: set ft=vim: set conceallevel=0-->
