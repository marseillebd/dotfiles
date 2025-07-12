"""""" fast switch buffers
nnoremap <leader>l :ls<CR>:b

" this magically stopped working unless I put it here instead of in the fzf
" plugin's keybinds
nnoremap <leader>l :Buffers!<CR>

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

