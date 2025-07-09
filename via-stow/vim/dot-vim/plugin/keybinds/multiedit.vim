"""""""""""""""""""""
"""""" Macro Tweaks
"""""""""""""""""""""

" The ADM-3A keyboard, for which `Vi` was initially developed had `@` just
" left of semicolon — where apostrophe is today. That is _way_ more convenient
" to type than `shift+2`.
nnoremap <Leader>' @
nnoremap <Leader>'' @@

" At the same time, I often find myself accidentally starting a macro with
" `q`, when I thought I was in insert mode or somthing, and then getting lost
" when next I hit `:` or something. Sometimes, it even overwrites a macro I
" cared about. Thus, I'm going to make `q` harder to accidentally type, while
" also making the macro-record interface a bit more consistent with the
" remapped macro-run from above.
" I don't think this will really get in my way, since multi-cursor support
" should obviate the need to record as many macros as is usual for vim.
nnoremap q <Nop>
nnoremap <Leader>q q

"""""""""""""""""""""""
"""""" Normal Command
"""""""""""""""""""""""

" I often find myself executing `"norm` from visual-line mode. So, here's a
" shortcut.

vnoremap q :norm<space>
