#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

# Install tpope/vim-surround
intodir="$HOME/.vim/pack/surround/start/surround"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/tpope/vim-surround "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi

# Along with that, install tpope/vim-repeat to enable 
# I'm not worried about non-surround plugins using repeat, because
# they are not likely to be installed without surround also installed.
# I'd rather keep `repeat` alongside `surround`, because it's nearly
# essential functionality for `surround`, while also being confusing to
# look at on its own.
intodir="$HOME/.vim/pack/surround/start/repeat"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/tpope/vim-repeat "$intodir"
  " no docs for vim-repeat, so no helptags command
fi
