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
set noshowmode          " The feature is already enabled by vim airline

" set colorscheme, change your color scheme here
colorscheme gruvbox
" colorscheme nord
" colorscheme solarized8

" better color for vim
set termguicolors
syntax on               " open syntax

" my remaps
:tnoremap <Esc> <C-\><C-n>      " terminal exit
nnoremap <SPACE> <NOP>          " Cause I am dumb and don't know how to get out
" these are for window management
nnoremap <Leader>w\ <C-w>v       " deal with window vertical splits
nnoremap <Leader>w- <C-w>s       " deal with window horizontal splits
nnoremap <Leader>wj <C-w>j       " deal with window jumping
nnoremap <Leader>wk <C-w>k       " deal with window jumping
nnoremap <Leader>wh <C-w>h       " deal with window jumping
nnoremap <Leader>wl <C-w>l       " deal with window jumping
nnoremap <Leader>wc <C-w>c       " deal with window jumping
nnoremap <Leader>w<C-o> <C-w><C-0>       " close all window except focus
" make saving file more easy
nnoremap <space> :w<CR>

" make vim go back to the same place
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

