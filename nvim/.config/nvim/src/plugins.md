# Plugins

[vimrc](vimrc.md)


## Plugin configuration

Vim configuration using <https://github.com/junegunn/vim-plug>.

```viml
call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'morhetz/gruvbox'
Plug 'nightsense/cosmic_latte'
Plug 'mhartington/oceanic-next'

Plug 'vim-utils/vim-husk'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
Plug 'tpope/vim-fugitive'
Plug 'itspriddle/vim-shellcheck'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mzlogin/vim-markdown-toc'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'simrat39/rust-tools.nvim'
" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'

Plug 'hrsh7th/nvim-compe'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lepture/vim-jinja'
Plug 'wsdjeg/vim-lua'
Plug 'dubek/vim-mal'
Plug 'stephpy/vim-yaml'
Plug 'joajfreitas/fcp.vim'

call plug#end()
```


* [FZF](plugin_fzf.md)
* [Ultisnips](plugin_ultisnips.md)
* [Easy Align](plugin_easy_align.md)
* [Limelight](plugin_limelight.md)
* [Latex](plugin_latex.md)
* [Pandoc](plugin_pandoc.md)
* [Markdown Preview](plugin_markdown_preview.md)
* [Tree Sitter](plugin_tree_sitter.md)
* [LSP Config](plugin_lsp_config.md)
* [Rust Tools](plugin_rust_tools.md)
* [Compe](plugin_compe.md)

## No longer used plugins

* Plug 'mhinz/vim-startify'
* Plug 'scrooloose/nerdtree'
* Plug 'neoclide/coc.nvim'
* Plug 'rhysd/git-messenger.vim'
* Plug 'vim-scripts/Conque-GDB'

<!-- vim: set ft=vim: set conceallevel=0-->
