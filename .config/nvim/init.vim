set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" ycm
" Plug 'ycm-core/YouCompleteMe'

" Fugative
Plug 'tpope/vim-fugitive'

" Colour Scheme
" Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
" Plug 'rose-pine/neovim', { 'as': 'rose-pine', 'branch': 'main' }
Plug 'whatyouhide/vim-gotham'

call plug#end()

set termguicolors
colorscheme gotham

let mapleader = " "

lua require('than')
