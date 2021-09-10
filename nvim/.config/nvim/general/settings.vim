let mapleader=" "       " change leader key to space

set cmdheight=1         " set the space under the status bar
set tabstop=4           " tab shift
set shiftwidth=4
set expandtab   
set showmatch           " show matching bracket
set nu                  " show number lines
set cc=80               " 80 lines of code
set autoindent          " autoindent
set bg=dark             " dark background
set nohlsearch          " cancel highlight search
set scrolloff=10        " keep cursor in the middle
set mouse=a             " set mouse control on
set relativenumber
set path+=**            " for the find command
set cursorline          " display the cursor line
set nowrap              " go all the way around the world for long codes!
set ignorecase          " don't care about search
set noswapfile          " don't use swap 
set incsearch           " show incremental when searching
set t_Co=256
set guifont=DroidSansMono\ Nerd\ Font\ 11 "set for displaying


" set colorscheme
colorscheme gruvbox
" colorscheme nord
" colorscheme solarized8
set termguicolors


syntax on               " open syntax

" my remaps
:tnoremap <Esc> <C-\><C-n>      " terminal exit
nnoremap <SPACE> <NOP>          " Cause I am dumb and don't know how to get out


" make vim go back to the same place
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

