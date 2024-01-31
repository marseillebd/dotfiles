" I don't use the `s` command at all, so I don't mind overwriting it.

nmap s  <Plug>Ysurround
nmap S  <Plug>YSurround
nmap ss <Plug>Yssurround
nmap Ss <Plug>YSsurround
nmap SS <Plug>YSsurround
vmap s  <Plug>VSurround

" FIXME these need to run _after_ this package has loaded
" " and no that I have those new surround commands, I can remove the defaults
" nunmap ys
" nunmap yS
" nunmap yss
" nunmap ySs
" nunmap ySS
" xunmap S
" xunmap gS
