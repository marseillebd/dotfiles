" ctrl+p to fuzzy find on git-tracked files
" TODO I really just want to ignore files matching the .gitignore, not
" necessarily restrict myself to just files that git knows about
nnoremap <C-p> :GFiles<CR>

" one day, this just stopped working, unless I moved it to my main keybinds
" which is annoying b/c this should really only run when I have then fzf plugin
nnoremap <leader>l :Buffers<CR>
