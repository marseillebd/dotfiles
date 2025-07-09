"""""" fast switch buffers
nnoremap <leader>l :ls<CR>:b

"""""" fast panes

" I often find myself doing various pane-oriented commands and disliking the
" general slowness of prefixing with <C-w>

nnoremap zh <C-w>h
nnoremap zj <C-w>j
nnoremap zk <C-w>k
nnoremap zl <C-w>l

" If I'm splitting panes, I almost always want it vertical, and start editing
" on the right.
nnoremap zv <C-w>v<C-w>l

