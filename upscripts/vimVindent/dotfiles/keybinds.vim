" jump to prev block of same indent.
map <silent> [= <Plug>(VindentBlockMotion_XO_prev)
" jump to next block of same indent.
map <silent ]= <Plug>(VindentBlockMotion_OO_next)
" jump to prev line with more indent.
map <silent [+ <Plug>(VindentMotion_prev_more)
" jump to next line with more indent.
map <silent ]+ <Plug>(VindentMotion_next_more)
" jump to prev line with less indent.
map <silent [- <Plug>(VindentMotion_prev_less)
" jump to next line with less indent.
map <silent ]- <Plug>(VindentMotion_next_less)

" jump to prev line with different indent.
map <silent> [; <Plug>(VindentMotion_prev_diff)
" jump to next line with different indent.
map <silent> ]; <Plug>(VindentMotion_next_diff)
" jump to start of the current block scope.
map <silent> [p <Plug>(VindentBlockMotion_XX_ss)
" jump to end   of the current block scope.
map <silent> ]p <Plug>(VindentBlockMotion_XX_se)

" select current block.
xmap <silent> ii <Plug>(VindentObject_XX_ii)
omap <silent> ii <Plug>(VindentObject_XX_ii)
" select current block + one extra line  at beginning.
xmap <silent> ai <Plug>(VindentObject_XX_ai)
omap <silent> ai <Plug>(VindentObject_XX_ai)
" select current block + two extra lines at beginning and end.
xmap <silent> aI <Plug>(VindentObject_XX_aI)
omap <silent> aI <Plug>(VindentObject_XX_aI)
