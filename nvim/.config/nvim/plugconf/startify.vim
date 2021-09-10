let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
            \]
let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' }
            \ ]
let g:startify_fortune_use_unicode = 1
let g:startify_files_number = 5
nmap <C-n> :Startify<CR>
