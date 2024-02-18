"""""""""""""""""""""""""
"""""" general behavior
"""""""""""""""""""""""""

" By default, vim starts in compatible mode.
" I don't care about compatibility with an even older tool that I don't think I've ever actually used.
" (Yes, ofc a ~/.vimrc file already signals that it's vim, but what if that same file is used via `vim -u otherrc`?)
set nocompatible

" utf-8 enverywhere
set encoding=utf-8 " encoding shown in the terminal
set fileencoding=utf8 " encoding of file when written

" When switching buffers, allow unsaved changes.
set hidden

"""""" timing

" Don't wait too long for prefix commands.
set timeout timeoutlen=200

" write swap file this fast (milliseconds)
set updatetime=500

"""""" autocomplete

" show possible completions above the command line
set wildmenu
" use bash-like completion: first tab selects longest, second shows a list
" I _do not_ use `full`, because that screws with my muscle memory so bad
set wildmode=longest,list

"""""" search

" Incremental search
set incsearch

"""""" history

" saves much more history (`/`-search patterns and `:`-command entries)
set history=10000

"""""" undo

" saves much more undo information
set undolevels=10000

"""""" clipboard

" Use system clipboard by default for yank, paste, delete.
" This is to make it easier to copy-paste between different apps, which is the
" way everything else on my system works.
"
" This sets the unnamed register to the plus register, which is synchronous
" with the usual system clipboard.
"
" Does a prepend so that I retain the defaults:
" - autoselect, which I really have very little idea, but maybe has something
"   to do with mouse-wheel-click to paste, which I don't use
" - exclude:cons\|linux, which disables the clipboard on matching terminals
"   (linux console)
set clipboard^=unnamedplus

"""""" allow standard input methods

" allow the use of the mouse
set mouse=a

" Backspace over indentation `indent`, newlines `eol`,
" and before where the insert started.
set backspace=indent,eol,start

"""""" color

" this lets airline color its statusline correctly
" I also doubt I'll ever be on a terminal with non-256-colors
set t_Co=256

"""""" filetype integration

" Run commands specific to each filetype on open.
" This way, we can swap in new behavior for different filetypes
" (e.g. Makefiles need tab-indentation, _not_ space-indentation).
filetype plugin on

"""""" command execution

" TODO

"""""""""""""""""""""""""
"""""" language support
"""""""""""""""""""""""""

syntax on

"""""" indentation

" indent with spaces instead of tabs
set expandtab
" tab key inserts tab stops, and backspace deletes them
set smarttab
" round indent to next multiple of shiftwidth (helps ensure indentation is
" always aligned to a multiple of `shiftwidth`
set shiftround

" tab size
set tabstop=2 " size of a tabstop on the page
set softtabstop=2 " length of a tab key/backspace keypress
set shiftwidth=2 " how large is a level of indentation

" Unintrustive indentation (presumably when no filetype detected).
" `autoindent` just copies indentation from the previous line.
set autoindent
" smart indentation based on filetype
filetype indent on

""""""""""""""""""""
"""""" decorations
""""""""""""""""""""

"""""" line numbers

" absolute line numbers; use `relativenumber` for relative numbering
set number

"""""" context

" keep at least two lines at top and bottom of window beyond cursor position
set scrolloff=2

"""""" status line

" always show what mode is active
set showmode

" always show status line
set laststatus=2

"""""" visible whitespace

set list
set listchars=tab:├─,trail:·

"""""" highlighting

" highlight matching paren
set showmatch

"""""" line wrapping

" Do not wrap lines.
" (I expect lines of code to be short).
set nowrap

" Use elipsis to show when a line is too long to fit on-screen.
set listchars+=precedes:…,extends:…

"""""" cursor

" Distinguish insert/replace cursor from other cursors.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
"
" In insert mode, use a bar-shaped cursor (6).
" The bar means I know between which characters I will be inserting text.
let &t_SI = "\e[6 q"
" In replace mode, use an underline-shaped cursor (4).
" The underline lets me know which character will be replaced,
" and also that I'm _not_ in insert mode.
let &t_SR = "\e[4 q"
" In any other mode (non-insert, non-replace), use a block-shaped cursor (2).
" In normal (&c) mode, the block lets me see which character is selected for
" operation (e.g. `x` will delete under the block). As a corollary, `i` to
" insert will put the insertion before the block, and `a` to append will put
" it after the block.
let &t_EI = "\e[2 q"

" highlight the line where the cursor is
" this helps me find the cursor when I've lost it (via jump, or just comping
" back to editing after a little while
set cursorline
highlight CursorLine cterm=NONE ctermbg=black

""""""""""""""""""""
"""""" Keybindings
""""""""""""""""""""

"""""" leader key

let mapleader = " "
" without this, `<Space>` is a synonym for `l` that interferes with the leader
" key
nnoremap <Space> <Nop>

"""""" internal consistency

" Y for yank-to-end; matching C (change-to-end) and D (delete-to-end)
nnoremap Y y$

"""""" visual line navigation

nnoremap j gj
nnoremap k gk

"""""" fast escape

inoremap jf <Esc>
vnoremap jf <Esc>
cnoremap jf <Esc>

"""""" fast command mode

" saves holding shift
nnoremap ; :
" go to next f/t/F/T character is still useful
" I might have remapped it as `:`, but this way the shift just doesn't matter
nnoremap ;; ;

"""""" fast switch buffers
nnoremap gb :ls<CR>:b

"""""" new paragraphs

" with cursor between paragraphs, insert into paragraph between
nnoremap oo o<Esc>O

" insert into paragraph above cursor line (splits the exiting paragraph)
nnoremap OO O<Esc>O<Esc>o

"""""" imitate other editors

" home key goes to first non-blank char, and then goes to first column
nnoremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

"""""" copy, paste, cut, and delete

" I so often cut into the temporary register (and then incorrectly paste from there)
" when what I really want to do is just delete and not worry about it.
"
" I ran into similar things in other editors, where I'd shift+delete to delete
" a line, but in so doing destroy my clipboard.
"
" Make the delete command drop save into the blackhole register instead of the
" unnamed register.
nnoremap d "_d
nnoremap D "_D
nnoremap dd "_dd
vnoremap d "_d
vnoremap D "_D
" To cut, use the `x` command defined here
" This doesn't loose us any features because `x` is a synonym for `<Del>`.
nnoremap x d
nnoremap X D
nnoremap xx dd
vnoremap x d
vnoremap X D
" The change commands by default save into the unnamed register.
" No.
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
vnoremap C "_C
vnoremap c "_c

" It turns out the <Del> key also clobbers the clipboard.
" I don't like that.
noremap <Del> "_<Del>

" The backspace key should work like the delete key in normal mode.
nnoremap <BS> "_dh

" Keep the visual selection on yank
vnoremap y ygv

"""""" macro tweaks

" The ADM-3A keyboard, for which `Vi` was initially developed had `@` just
" left of semicolon — where apostrophe is today. That is _way_ more convenient
" to type than `shift+2`.
nnoremap <Leader>' @
nnoremap <Leader>'' @@

" At the same time, I often find myself accidentally starting a macro with
" `q`, when I thought I was in sert mode or somthing, and then getting lost
" when next I hit `:` or something. Sometimes, it even overwrites a macro I
" cared about. Thus, I'm going to make `q` harder to accidentally type, while
" also making the macro-record interface a bit more consistent with the
" remapped macro-run from above.
" I don't think this will really get in my way, since multi-cursor support
" should obviate the need to record as many macros as is usual for vim.
nnoremap q <Nop>
nnoremap <Leader>q q

"""""" Shifting

" Shift characters left and right
" The `^[L` is used in place of <A-S-L>, which somehow didn't work.
"
" I use the "- (small delete) register so as not to clobber registers I care about.
" In normal mode, it's just a single character,
" so it's easy enough to cut a character and paste it, updating the cursor.
nnoremap L "-dl"-p
nnoremap H "-dh"-ph

" Shift lines up and down.
"
" For single lines, things are also relatively easy.
" TODO this binding has the issue of resetting your cursor position in the line.
nnoremap J "-dd"-p
nnoremap K "-ddk"-P
" For multiple lines (visual mode), we need a bit of fancy:
" - `:m` for the "move" command
" - the move command takes an address, which is
"   - `'>` the end of the selection
"   - `+1` plus (down) one line
" - `<CR>` done with the move
" - `gv` to reselect previous visual
" TODO use `gv=` to reindent, possibly
vnoremap J :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv
