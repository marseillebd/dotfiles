"""""" Enable floating window with diagnostic text
let g:lsp_diagnostics_float_cursor = 1

" the hover seems to be broken unless the debouncing of writes to the swapfile
" is short enough. By default, updatetime is 4000ms, so I guessed something
" below the diagnostics float timeout (500ms).
set updatetime=400

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
     nmap <buffer> gd <plug>(lsp-definition)
     nmap <buffer> gs <plug>(lsp-document-symbol-search)
     nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
     nmap <buffer> gf <plug>(lsp-references)
     nmap <buffer> gi <plug>(lsp-implementation)
     nmap <buffer> <C-l><C-t> <plug>(lsp-type-definition)
     nmap <buffer> <C-l><C-r> <plug>(lsp-rename)
     nmap <buffer> <C-l><C-l> <plug>(lsp-code-action)
     nmap <buffer> ]g <plug>(lsp-next-diagnostic)
     nmap <buffer> [g <plug>(lsp-previous-diagnostic)
     nmap <buffer> ]e <plug>(lsp-next-error)
     nmap <buffer> [e <plug>(lsp-previous-error)
     nmap <buffer> ]w <plug>(lsp-next-warning)
     nmap <buffer> [w <plug>(lsp-previous-warning)
     nmap <buffer> <C-l><C-h> <plug>(lsp-hover)
     nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
     nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
