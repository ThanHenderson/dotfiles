set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc


if has('nvim')
    let g:plug_home = stdpath('data') . "/plugged"
endif


call plug#begin()
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Fugative
Plug 'tpope/vim-fugitive'

" Colour Scheme
Plug 'pineapplegiant/spaceduck'
call plug#end()

colorscheme spaceduck

let mapleader = " "

lua require('than')
