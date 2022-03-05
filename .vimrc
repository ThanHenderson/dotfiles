" Syntax
syntax on
"set t_Co=256
set encoding=utf-8
"set spell spelllang=en_us
set visualbell

" Line Settings
set number
"set relativenumber
set tabstop=4
set textwidth=80
set wrap
set autoindent
" Matching paren
set showmatch

" Current Information
set showmode
set showcmd
set ruler
set title
set modeline
set laststatus=2
set wildmenu

" Enables mouse input
set mouse=a


" --------- "
"  Plug-ins "
" --------- "

" NeoVim Plug
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

call plug#begin()

if has("nvim")
		Plug 'dense-analysis/ale'
		let g:ale_cpp_cc_executable = 'g++'
		let g:ale_cpp_cc_options = '-std=c++20 -Wall'

endif

call plug#end()



