"""""" leader key

let mapleader = " "
" without this, `<Space>` is a synonym for `l` that interferes with the leader
" key
nnoremap <Space> <Nop>

"""""" visual line navigation

nnoremap j gj
nnoremap k gk

"""""" fast escape

inoremap jf <Esc>
nnoremap jf <Esc>
vnoremap jf <Esc>
cnoremap jf <Esc>

"""""" fast command mode

" saves holding shift
nnoremap ; :
" go to next f/t/F/T character is still useful
" I might have remapped it as `:`, but this way the shift just doesn't matter
nnoremap ;; ;

"""""" fast save

" for this to work, you must have flow control turned off with `stty -ixon`
"
" the use of `:update` instead of `:w` means we only write if there have been
" changes

" normal, select, operator-pending modes (and visual, to be overwritten later)
noremap <C-s> :update<CR>
" visual mode
vnoremap <C-s> <ESC>:update<CR>
" insert and command-line modes
noremap! <C-s> <ESC>:update<CR>

