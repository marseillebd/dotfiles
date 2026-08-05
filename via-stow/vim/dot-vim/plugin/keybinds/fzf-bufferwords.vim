function s:preceding_word()
  let p = getpos('.')[2]-1 " the minus 1 fixes up the one-indexing
  if p == 0
    return ""
  endif
  let line = getline('.')
  if match(line[p-1], '\W') == 0
    " the cursor is preceded by a non-word, so we don't want to throw away the
    " previous word
    return ""
  endif
  let words = split(line[0:p-1], '\W\+')
  if len(words) == 0
    return ""
  endif
  return words[-1]
endfunction

function s:buffer_words()
  let allwords = split(join(getline(1,'$'),"\n"),'\W\+')
  let prec = s:preceding_word()
  let i = index(allwords, prec)
  if i != -1
    let garbage = remove(allwords, i)
  endif
  " return join([i, prec, allwords], "\n")
  return uniq(sort(allwords))
endfunction

function s:completeBWords()
  return fzf#vim#complete(fzf#wrap({
    \ 'source': s:buffer_words(),
    \ }))
endfunction

inoremap <expr> <silent> <Plug>(fzf-complete-bufferword) <sid>completeBWords()

" the all-important fuzy word completion based on file contents!
" TODO I'm sure there's ways I could improve this:
" - look through all words in all open buffers
" - but only the buffers whose file extension matches the current buffer's
" but these assume I can speed up `s:buffer_words()`
"
" the competion only triggers if both:
" a) we aren't at the start of the line, or
" b) the previous character is whitespace.
" Otherwise, ordinary tab behavior is preserved.
imap <expr> <Tab>
  \ col('.') == 1 ? '<Tab>' :
  \ match(strpart(getline('.'), col('.') - 2, 1), '\s') != -1 ? '<Tab>' :
  \ '<Plug>(fzf-complete-bufferword)'

