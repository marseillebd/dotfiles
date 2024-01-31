#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

# Install tpope/vim-surround
intodir="$HOME/.vim/pack/airline/start/airline"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/vim-airline/vim-airline "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi
