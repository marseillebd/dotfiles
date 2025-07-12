" the all-important fuzy word completion based on file contents!
" TODO I'm sure there's ways I could improve this:
" - look through all words in all open buffers
" - but only the buffers whose file extension matches the current buffer's
"
" the condition checks if the characters before the cursor are all whitespace
" thus, we can still indent at the start of a line
imap <expr> <Tab> match(strpart(getline('.'), 0, max([0, col('.')-1])), '^\s*$') != -1
  \ ? '<Tab>'
  \ : '<Plug>(fzf-complete-bufferword)'

" ctrl+p to fuzzy find on git-tracked files
" TODO I really just want to ignore files matching the .gitignore, not
" necessarily restrict myself to just files that git knows about
nnoremap <C-p> :GFiles!<CR>

" one day, this just stopped working, unless I moved it to my main keybinds
" which is annoying b/c this should really only run when I have then fzf plugin
nnoremap <leader>l :Buffers!<CR>
