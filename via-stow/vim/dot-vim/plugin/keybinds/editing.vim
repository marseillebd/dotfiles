"""""" new paragraphs

" with cursor between paragraphs, insert into paragraph between
nnoremap oo o<Esc>O

" insert into paragraph above cursor line (splits the exiting paragraph)
nnoremap OO O<Esc>O<Esc>o

"""""" Shifting

" TODO use vim-move plugin

" Shift characters left and right
" The `^[L` is used in place of <A-S-L>, which somehow didn't work.
"
" I use the "- (small delete) register so as not to clobber registers I care about.
" In normal mode, it's just a single character,
" so it's easy enough to cut a character and paste it, updating the cursor.
"
" ok, so in the kitty terminal, the `^[L` doesn't work, but `<A-S-l>` does.
" That indicates that it was a problem with ambiguous keys in the old terminal
" protocol. I've therefore added the control key sequences as well.
nnoremap L "-dl"-p
nnoremap <A-S-l> "-dl"-p
nnoremap H "-dh"-ph
nnoremap <A-S-h> "-dh"-ph

" Shift lines up and down.
"
" For single lines, things are also relatively easy.
" TODO this binding has the issue of resetting your cursor position in the line.
nnoremap J "-dd"-p
nnoremap <A-S-j> "-dd"-p
nnoremap K "-ddk"-P
nnoremap <A-S-k> "-ddk"-P
" For multiple lines (visual mode), we need a bit of fancy:
" - `:m` for the "move" command
" - the move command takes an address, which is
"   - `'>` the end of the selection
"   - `+1` plus (down) one line
" - `<CR>` done with the move
" - `gv` to reselect previous visual
" TODO use `gv=` to reindent, possibly
"
" FIXME I am very unsure why moving lines up in kitty moves them twice the distance.
vnoremap J :m '>+1<CR>gv
vnoremap <A-S-j> :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv
vnoremap <A-S-k> :m '<-2<CR>gv
