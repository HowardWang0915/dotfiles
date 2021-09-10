" Jump to specific Window.
fun! GotoWindow(id)
  :call win_gotoid(a:id)
endfun

let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools']

nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>

nnoremap <leader>dd :call vimspector#Launch()<CR>   " Launch the dubugger
nmap <leader>dn <Plug>VimspectorStepInto            " next
nmap <leader>ds <Plug>VimspectorStepOver            " step
" nmap <leader>dc <Plug>VimspectorStepOut
nmap <leader>db <Plug>VimspectorToggleBreakpoint    " set break point
nmap <leader>drc <Plug>VimspectorRunToCursor

nnoremap <leader>dq :call vimspector#Reset()<CR>
