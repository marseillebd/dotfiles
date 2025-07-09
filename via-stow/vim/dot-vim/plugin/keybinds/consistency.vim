"""""""""""""""""""""""""""""""""""""
"""""" copy, paste, cut, and delete
"""""""""""""""""""""""""""""""""""""

" I so often cut into the temporary register (and then incorrectly paste from there)
" when what I really want to do is just delete and not worry about it.
"
" I ran into similar things in other editors, where I'd shift+delete to delete
" a line, but in so doing destroy my clipboard.
"
" Make the delete command drop save into the blackhole register instead of the
" unnamed register.
nnoremap d "_d
nnoremap D "_D
nnoremap dd "_dd
vnoremap d "_d
vnoremap D "_D
" To cut, use the `x` command defined here
" This doesn't loose us any features because `x` is a synonym for `<Del>`.
nnoremap x d
nnoremap X D
nnoremap xx dd
vnoremap x d
vnoremap X D
" The change commands by default save into the unnamed register.
" No.
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
vnoremap C "_C
vnoremap c "_c

" It turns out the <Del> key also clobbers the clipboard.
" I don't like that.
noremap <Del> "_<Del>

" The backspace key should work like the delete key in normal mode.
nnoremap <BS> "_dh

"""""""""""""""""""""""""""""
"""""" internal consistency
"""""""""""""""""""""""""""""

" Y for yank-to-end; matching C (change-to-end) and D (delete-to-end)
nnoremap Y y$

"""""" undo
" this should allow for faster navigating of the (linear) undo levels
" just like ctrl+z vs ctrl+shift+z in other editors
" also, just like other `thing`/`<S-thing>` pairs in vim
nnoremap <s-u> <c-r>

"""""""""""""""""""""""""""""
"""""" external consistency
"""""""""""""""""""""""""""""

" home key goes to first non-blank char, and then goes to first column
nnoremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
inoremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

