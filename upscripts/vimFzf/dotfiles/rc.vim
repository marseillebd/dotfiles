" I beleive this will put the auto-complete window near the text I'm
" inserting.
" However, I have not TODO tested on a version that supports popup windows.
if v:version >= 802
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif
