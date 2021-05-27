# Plugins

[vimrc](vimrc.md)


## Plugin configuration

Vim configuration using <https://github.com/junegunn/vim-plug>.

```viml
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
```


* [CoC](plugin_coc.md)
* [FZF](plugin_fzf.md)
* [Ultisnips](plugin_ultisnips.md)
* [Easy Align](plugin_easy_align.md)
* [Limelight](plugin_limelight.md)
* [Vimwiki](plugin_vimwiki.md)
* [Nerdtree](plugin_nerdtree.md)
* [Latex](plugin_latex.md)
* [Pandoc](plugin_pandoc.md)
* [Markdown Preview](plugin_markdown_preview.md)
* [Tree Sitter](plugin_tree_sitter.md)
* [LSP Config](plugin_lsp_config.md)
* [Compe](plugin_compe.md)

<!-- vim: set ft=vim: set conceallevel=0-->
