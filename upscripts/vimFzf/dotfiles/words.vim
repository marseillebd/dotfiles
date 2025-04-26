function s:preceding_word()
  let p = getpos('.')[2]-1 " the minus 1 fixes up the one-indexing
  if p == 0
    return ""
  endif
  let line = getline('.')
  if match(line[p-1], '\W') == 0
    " the cursor is no immediately preceded by a word, so we don't want to throw away the previous word
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
  return allwords
endfunction

function s:completeBWords()
  return fzf#vim#complete(fzf#wrap({
    \ 'source': uniq(sort(s:buffer_words())),
    \ }))
endfunction

inoremap <expr> <silent> <Plug>(fzf-complete-bufferword) <sid>completeBWords()
