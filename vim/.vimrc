" ============================
"   Syntax and File Detection
" ============================

" Enable syntax highlighting
syntax on

" Enable file type detection, plugins, and indenting
filetype plugin indent on

" ============================
"   Visual Display Settings
" ============================
" Always show the current cursor position in the status line
set ruler

" Highlight matching pairs of braces, brackets, and parentheses
set showmatch

" Enable 256-color terminal support
set t_Co=256

" ============================
"   Indentation Settings
" ============================

" Set tab and indentation behavior (4 spaces per tab)
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab       " Convert tabs to spaces
set smartindent     " Enable smart indentation
set autoindent      " Automatically indent new lines

" ============================
"   Line Numbers and Scrolling
" ============================

set nu             " Show absolute line number for the current line
set wrap           " Enable line wrapping
set scrolloff=2     " Keep 2 lines of context when scrolling
set sidescrolloff=5 " Keep 5 columns of context when scrolling horizontally
set signcolumn=yes  " Always show the sign column
set colorcolumn=80  " Highlight column 80 for line length

" ============================
"   Buffer and File Settings
" ============================

" Allow opening a new file without saving the current one
set hidden

" ============================
"   Search Settings
" ============================

" Disable search highlight
set nohlsearch

" Enable incremental search
set incsearch

" Make searches case-insensitive unless uppercase letters are used
set smartcase
set ignorecase

" Add current directory and subdirectories to the search path
set path+=**

" ============================
"   History and Backup Settings
" ============================

" Disable swap files and backups
set noswapfile
set nobackup

" Set up undo directory and enable undofile
set undodir=~/.vim/undodir//
set undofile

" ============================
"   Mistakes and Sounds
" ============================

" Disable error bells
set noerrorbells

" ============================
"   Display and UI Settings
" ============================

" Set command-line height
set cmdheight=2

" Enable wildmenu for command completion
set wildmenu

" ============================
"   Performance and Speed
" ============================

" Reduce time to trigger CursorHold event
set updatetime=50

" Enable mouse support in all modes
set mouse=a

" ============================
"   Encoding and Backspace Settings
" ============================

" Use UTF-8 encoding
set encoding=utf-8

" Make backspace behave like in most other applications
set backspace=indent,eol,start

" ============================
"   Display Invisible Characters
" ============================

" Show invisible characters like tabs and spaces
set list
set showbreak=󱞩
set listchars=tab:›\ ,trail:·,extends:»,precedes:«,nbsp:⣿

" ============================
"   Line Wrapping Behavior
" ============================

" Allow wrapping of lines at the end of the screen
set whichwrap+=<,>,h,l,[,]

" ============================
"   Command-line Completion
" ============================

" Tab complete in a manner similar to bash
set wildmenu
set wildmode=longest,list,full

" ============================
"   Swap and Backup Files Location
" ============================

" Set the directory for swap files
set directory=~/.vim/swap//

" ============================
"   Clipboard Integration
" ============================

" Use the system clipboard for copy and paste operations
set clipboard=unnamed

" ============================
"   Status Line Settings
" ============================

" Always display the status line
set laststatus=2

" Automatically reload files if they are changed outside of Vim
set autoread

" ============================
"   Color Scheme and Appearance
" ============================

" Use a dark variant of the default colorscheme
colorscheme retrobox
set background=light
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Disable preview for completion suggestions
set completeopt-=preview

" Show the last line as much as possible
set display+=lastline

" Enable true color support (for Vim 8 or newer)
if v:version > 800
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" ============================
"   Leader Key Mapping
" ============================

" Set leader key to space
let mapleader = " " "
let g:mapleader = " " "

" ============================
"   Key Mappings
" ============================

" Arrow keys to move by screen line
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
vnoremap <Up> g<Up>
vnoremap <Down> g<Down>
inoremap <Up> <C-o>g<Up>
inoremap <Down> <C-o>g<Down>

" Prevent accidental deletion (cut) with 'd' and 'x'
nnoremap x "_x
nnoremap X "_X
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Use leader key for copying and cutting
nnoremap <leader>d "+dd
nnoremap <leader>D "+D
vnoremap <leader>d "+d
