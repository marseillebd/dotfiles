#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

intodir="$HOME/.vim/pack/sandwich/start/sandwich"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/machakann/vim-sandwich "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi
