nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz     " Navigate through QF list
nnoremap <C-q> :call ToggleQFList()<CR>

let g:QFopen = 0

fun! ToggleQFList()
    if g:QFopen == 0
        let g:QFopen = 1
        copen
    else
        let g:QFopen = 0
        cclose
    endif
endfun
