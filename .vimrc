
" Indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" Lines
set relativenumber
set nu
set nowrap
set scrolloff=8
set signcolumn=yes
set colorcolumn=80

" Buffers
set hidden

" Search
set nohlsearch
set incsearch

" History
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Mistakes
set noerrorbells

" Display
set termguicolors
set cmdheight=2

" Go fast
set updatetime=50

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'pineapplegiant/spaceduck'
call plug#end()

colorscheme spaceduck

" Remaps: mode lhs rhs
let mapleader = " "
" Search
nnoremap <leader>s <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Search: ") })<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fb <cmd>lua require "telescope".extensions.file_browser.file_browser()<cr>

"Plugs: telescope, lsp, tree sitter, fugediv
