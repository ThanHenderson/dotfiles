set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Telescope, fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

"LSP, language server support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Fugative
Plug 'tpope/vim-fugitive'

" Markdown support in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Debugging
Plug 'puremourning/vimspector'

" Colour Scheme
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'rose-pine/neovim', { 'as': 'rose-pine', 'branch': 'main' }
Plug 'whatyouhide/vim-gotham'
Plug 'fxn/vim-monochrome'
Plug 'marko-cerovac/material.nvim'

call plug#end()

set termguicolors
let g:material_style = "deep ocean"
colorscheme material

let mapleader = " "

lua require('than')
