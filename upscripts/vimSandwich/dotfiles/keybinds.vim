"""""" Text Objects """"""

" I only want the is/as text objects, not ib/ab
let g:textobj_sandwich_no_default_key_mappings = 1

" These were copied from the vim-sandwich default bindings 2024-02-17
silent! omap <unique> is <Plug>(textobj-sandwich-query-i)
silent! xmap <unique> is <Plug>(textobj-sandwich-query-i)
silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)

"""""" Operators """"""

" I want my customized surround-like bindings
let g:operator_sandwich_no_default_key_mappings = 1

" add
silent! nmap <unique> s <Plug>(sandwich-add)
silent! xmap <unique> s <Plug>(sandwich-add)
silent! omap <unique> s <Plug>(sandwich-add)

silent! nmap <unique> S s$

" delete
silent! nmap <unique> ds <Plug>(sandwich-delete)
silent! xmap <unique> ds <Plug>(sandwich-delete)

" replace
silent! nmap <unique> cs <Plug>(sandwich-replace)
silent! xmap <unique> cs <Plug>(sandwich-replace)
