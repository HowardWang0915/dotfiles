call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'              " beautiful status bar
Plug 'vim-airline/vim-airline-themes'       "airline 的主题
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " vim autocomplete
Plug 'morhetz/gruvbox'                      " themes so beaitufil!
Plug 'arcticicestudio/nord-vim'             " nord also beautiful!
Plug 'lifepillar/vim-solarized8'            " solarized so beautiful
Plug 'preservim/nerdcommenter'              " fast commenting
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                     " vim fuzzy finder
Plug 'junegunn/goyo.vim'                    " vim focus mode!
Plug 'ryanoasis/vim-devicons'               " beautiful icons with vim!
Plug 'tpope/vim-surround'                   " add quotes faster for vim
Plug 'tpope/vim-repeat'                     " make . to work for vim-surround
Plug 'mhinz/vim-startify'                   " fancy startup
Plug 'Yggdroot/indentLine'                  " Show indent level of vim
Plug 'luochen1990/rainbow'                  " beautiful brackets for eyes
Plug 'tpope/vim-fugitive'                   " a git wrapper so good!
Plug 'chrisbra/Colorizer'                   " color-coded hex
Plug 'lervag/vimtex'                        " latex in vim!
call plug#end()
