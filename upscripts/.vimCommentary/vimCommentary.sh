#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

intodir="$HOME/.vim/pack/commentary/start/commentary"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/tpope/vim-commentary "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi
